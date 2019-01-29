open Num_asm

let table = ref M.empty

let count = ref 0
let a = ref false

type ty = Float | Gen | Unit

let print_graph g =
  M.iter (fun x s -> print_string (x^"  ");
                S.iter (fun y -> print_string (y^" ")) s; print_newline ()) g

(******************************)
(* 生存解析 *)


(* 汎用レジスタか浮動小数レジスタかを分ける *)
let rec classify_fv_exp e t = 
  match e with
  | Nop | Li _ | FLi _ | SetL _ | Comment _ | SetGlb _ | Restore _ -> S.empty, S.empty
  | Mr(x) | Neg(x) | In(x) | Out(x) | ItoF(x) -> S.singleton x, S.empty
  | FMr(x) | FNeg(x) | FSqrt(x) | FtoI(x) -> S.empty, S.singleton x
  | Add(x, y') | Sub(x, y') | FLw(x, y') | Lw(x, y') | Sll(x, y') | Srl(x, y') | Sra(x, y') -> S.of_list (x :: fv_id_or_imm y'), S.empty
  | Sw(x, y, z') -> S.of_list (x :: y :: fv_id_or_imm z'), S.empty
  | FSw(x, y, z') -> S.of_list (y :: fv_id_or_imm z'), S.singleton x
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> S.empty, S.of_list [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> S.of_list (x :: fv_id_or_imm y'), S.empty
  | IfFEq(x, y', e1, e2) | IfFLE(x, y', e1, e2) -> S.empty, S.of_list (fv_id_or_imm x @ fv_id_or_imm y')
  | CallCls(x, ys, zs) -> S.of_list (x :: ys), S.of_list zs
  | CallDir(_, ys, zs) -> S.of_list ys, S.of_list zs
  | Subst((x, t), e) -> classify_fv_exp e t
  | Save (x, y) -> (match t with Type.Float -> S.empty, S.singleton y | _ -> S.singleton y, S.empty) (* 特殊な場合(spillが発生してSaveが挿入された場合)でしか起こりえないのでこれでok *)


(* live[i]の更新 *)
let rec update lives flives succ =
  match succ with
  | [] -> S.empty, S.empty
  | e :: es -> 
    (
    match e with
    | Let((x, t), e, j, cont) ->
      let def, fdef = 
        (match e with
        | IfEq _ | IfLE _ | IfGE _ | IfFLE _ | IfFEq _ -> S.empty, S.empty
        | _ -> 
          (match t with
          | Type.Unit -> S.empty, S.empty
          | Type.Float -> S.empty, S.singleton x
          | _ -> S.singleton x, S.empty
          )
        )
      in
      let fv_g, fv_f = classify_fv_exp e t in (* 汎用レジスタ用と浮動小数レジスタ用 *)
      let live_j = try Int_M.find j lives with Not_found -> S.empty in
      let flive_j = try Int_M.find j flives with Not_found -> S.empty in
      let lives', flives' = update lives flives es in
      let live_j' = S.union (S.union (S.diff (live_j) def) fv_g) lives' in
      let flive_j' = S.union (S.union (S.diff (flive_j) fdef) fv_f) flives' in
      (live_j', flive_j')
    | Ans(e, j) ->
      let def, fdef = 
        (match e with
        | Subst((x, t), e) -> (match t with | Type.Float -> S.empty, S.singleton x | Type.Unit -> S.empty, S.empty | _ -> S.singleton x, S.empty)
        | _ -> S.empty, S.empty
        )
      in
      let fv_g, fv_f =
        (match e with
        | Subst((x, t), e) -> classify_fv_exp e t 
        | _ -> classify_fv_exp e Type.Int (* Intは適当 *) (* 汎用レジスタ用と浮動小数レジスタ用 *)
        )
      in
      let live_j = try Int_M.find j lives with Not_found -> S.empty in
      let flive_j = try Int_M.find j flives with Not_found -> S.empty in
      let lives', flives' = update lives flives es in
      let live_j' = S.union (S.union (S.diff (live_j) def) fv_g) lives' in
      let flive_j' = S.union (S.union (S.diff (flive_j) fdef) fv_f) flives' in
      (live_j', flive_j')
    )

(* eを走査する部分 *)
let rec liveness_analysis_main lives flives t succ =
  match t with
  | Let((x, t), e, i, cont) ->
    (match e with
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> (* ここのiに対応する命令は比較であることにする *)
      let lives1, flives1 = liveness_analysis_main lives flives e1 [cont] in 
      let lives2, flives2 = liveness_analysis_main lives1 flives1 e2 [cont] in 
      let live_i, flive_i = update lives2 flives2 [e1; e2] in (* live[i]を更新 *)
      liveness_analysis_main (Int_M.add i live_i lives2) (Int_M.add i flive_i flives2) cont succ
    | _ -> 
      let live_i, flive_i = update lives flives [cont] in
      liveness_analysis_main (Int_M.add i live_i lives) (Int_M.add i flive_i flives) cont succ
    )
  | Ans(e, i) -> 
    (match e with
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> (* ここの(x, t)に対応する命令は比較であることにする *)
      let lives1, flives1 = liveness_analysis_main lives flives e1 succ in 
      let lives2, flives2 = liveness_analysis_main lives1 flives1 e2 succ in 
      let live_i, flive_i = update lives2 flives2 [e1; e2] in (* live[i]を更新 *)
      Int_M.add i live_i lives2, Int_M.add i flive_i flives2
    | _ -> 
      let live_i, flive_i = update lives flives succ in
      Int_M.add i live_i lives, Int_M.add i flive_i flives
    )


let rec iter_analysis lives flives t =
  let lives', flives' = liveness_analysis_main lives flives t [] in
  (* 差分を出力/デバッグ用 *)
  (*
  let lives'' = Int_M.merge 
                (fun x s1 s2 -> match s1, s2 with | None, None -> None | Some s1, None -> Some s1 | Some s1, Some s2 -> if S.diff s1 s2 = S.empty then None else ((*assert(S.diff s2 s1 <> S.empty);*) Some (S.diff s1 s2)) | _ -> assert(false)) lives' lives in
  incr count; 
  print_string "lives' differed by lives "; print_int !count; print_newline ();
  Int_M.iter (fun x s -> print_string ((string_of_int x)^"  "); S.iter (fun y -> print_string (y^" ")) s; print_newline ()) lives'';
  let lives'' = Int_M.merge 
                (fun x s1 s2 -> match s1, s2 with | None, None -> None | Some s1, None -> Some s1 | Some s1, Some s2 -> if S.diff s1 s2 = S.empty then None else ((*assert(S.diff s2 s1 <> S.empty);*) Some (S.diff s1 s2)) | None, Some s1 -> None) lives lives' in
  incr count; 
  print_string "lives differed by lives' "; print_int !count; print_newline ();
  Int_M.iter (fun x s -> print_string ((string_of_int x)^"  "); S.iter (fun y -> print_string (y^" ")) s; print_newline ()) lives'';
  (if lives' = lives then
  (
    print_endline "hoge"
  )
  else
    print_endline "fuga"
  );
  *)
  (*
  a := false;
  incr count;
  print_endline "fuga "; print_int !count; print_newline ();
  Int_M.iter (fun i s -> S.iter (fun x -> if int_M.mem i lives then if S.mem x (Int_M.find i lives) then () else (a := true; print_string (x^" "))) s; (if !a then print_newline () else ())) lives';
  (*
  Int_M.iter (fun i s -> S.iter (fun x -> if Int_M.mem i lives then if S.mem x (Int_M.find i lives) then () else (a := true; print_string (x^" ")) else ()) s; (if !a then print_newline () else ())) lives';
  *)
  Int_M.iter (fun i s -> S.iter (fun x -> if S.mem x (Int_M.find i flives) then () else (a := true; print_string (x^" "))) s; (if !a then print_newline () else ())) flives';
  *)
  (*
  let a = Int_M.fold (fun i s acc -> acc + S.cardinal s) lives' 0 in
  let b = Int_M.fold (fun i s acc -> acc + S.cardinal s) lives 0 in
  let c = Int_M.fold (fun i s acc -> acc + S.cardinal s) flives' 0 in
  let d = Int_M.fold (fun i s acc -> acc + S.cardinal s) flives 0 in
  print_int a; print_newline ();
  print_int b; print_newline ();
  print_int c; print_newline ();
  print_int d; print_newline ();
  *)
 
  if (lives' = lives && flives' = flives) then 
  (
    lives, flives
  )
  else
  (
    iter_analysis lives' flives' t
  )
(* ここまで生存解析 *)
(******************************)

(* 生存解析の情報から干渉グラフを構成する *)
let rec make_graph g =
  Int_M.fold 
    (fun i live m -> 
      S.fold (fun x m' -> M.add x (S.union (S.remove x live) (try M.find x m' with Not_found -> S.empty)) m') live m)
    g
    M.empty

(* 各変数が何回使われるか/spillの選択のため *)
let rec get_freq e =
  let merge_m = fun key a b ->
    match a, b with
    | None, None -> None
    | Some x, None -> Some x
    | None, Some y -> Some y
    | Some x, Some y -> Some (x + y)
  in
  let update_m = function
    | None -> Some 1
    | Some n -> Some (n + 1)
  in
  match e with
  | Let(xt, e, i, cont) ->
    (match e with 
    | IfEq(a, b', e1, e2) | IfLE(a, b', e1, e2) | IfGE(a, b', e1, e2) ->
      let l = a :: fv_id_or_imm b' in
      List.fold_left (fun m x -> M.update x update_m m) (M.merge merge_m (M.merge merge_m (get_freq e1) (get_freq e2)) (get_freq cont)) l
    | IfFEq(a', b', e1, e2) | IfFLE(a', b', e1, e2) ->
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      List.fold_left (fun m x -> M.update x update_m m) (M.merge merge_m (M.merge merge_m (get_freq e1) (get_freq e2)) (get_freq cont)) l
    | _ -> 
      let l = fv_exp e in
      List.fold_left (fun m x -> M.update x update_m m) (get_freq cont) l
    )
  | Ans(e, i) ->
    (match e with 
    | IfEq(a, b', e1, e2) | IfLE(a, b', e1, e2) | IfGE(a, b', e1, e2) ->
      let l = a :: fv_id_or_imm b' in
      List.fold_left (fun m x -> M.update x update_m m) (M.merge merge_m (get_freq e1) (get_freq e2)) l
    | IfFEq(a', b', e1, e2) | IfFLE(a', b', e1, e2) ->
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      List.fold_left (fun m x -> M.update x update_m m) (M.merge merge_m (get_freq e1) (get_freq e2)) l
    | _ -> 
      let l = fv_exp e in
      List.fold_left (fun m x -> M.update x update_m m) (M.empty) l
    )
 

      
(* 楽観的彩色 *)
let rec optimistic g freq stack spill t =
  if (M.cardinal g = 0) then
    stack, spill
  else
    let length = Array.length (match t with Float -> Asm.fregs | Gen -> Asm.regs | Unit -> assert(false)) in
    let r = M.fold 
              (fun x s r ->
                match r with
                | Some y -> Some y
                | None ->
                  if (S.cardinal s < length - 1) then
                    Some x
                  else
                    None) g None in
    match r with (* 確実に塗れるものがあるか *)
    | Some x -> optimistic (M.remove x (M.map (S.remove x) g)) freq (if List.mem x stack then stack else (x :: stack)) spill t
    | None -> 
      (* 選択 *)
      let (x, min) = M.fold (fun x _ (y, min) -> let tm = M.find x freq in if tm < min then (x, tm) else (y, min)) g (let (t, _) = M.choose g in (t, M.find t freq)) in
      optimistic (M.remove x (M.map (S.remove x) g)) freq (x :: stack) (x :: spill) t


(* 割り当てるレジスタを探す *)
(* 無理なら前から見ていって割り当てられるものを割り当てる *)
let rec find_step_by_step i step used regs =
  if S.mem regs.(i) used then
    find_step_by_step (i + step) step used regs
  else
    i

(* まずはレジスタのスワップが少なくなるように割り当ててみる *)
let rec find_can_use i used regs m =
  let m' = 
    (match m with
    | None -> None 
    | Some n -> Int_M.fold 
            (fun i max maybe -> 
                  if S.mem regs.(i) used then 
                    maybe 
                  else
                    (match maybe with
                    | None -> Some (i, max)
                    | Some (j, max') -> if i > j then Some (i, max) else Some (j, max'))) n None 
    ) in
  match m' with
  | Some (i, _) -> i
  | None -> find_step_by_step 0 1 used regs
  
(* 引数をみてどのレジスタに割り当てるのが良さそうかのmapを返す *)
let rec make_priority_map e =
  match e with
  | Let((x, t), e, i, cont) ->
    (match e with
    | CallDir(_, ys, zs) -> 
      let m = make_priority_map cont in
      let (_, m') = List.fold_left 
                  (fun (i, m') y -> let l = try M.find y m' with Not_found -> Int_M.empty in
                                   (i + 1, M.add y (Int_M.add i (try Int_M.find i l + 1 with Not_found -> 1) l) m')) (0, m) ys in
      let (_, m'') = List.fold_left 
                  (fun (i, m') y -> let l = try M.find y m' with Not_found -> Int_M.empty in
                                   (i + 1, M.add y (Int_M.add i (try Int_M.find i l + 1 with Not_found -> 1) l) m')) (0, m') zs in
      m''
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> 
      let f = fun x a b -> 
              match a, b with
              | Some c, Some d -> Some (Int_M.fold (fun i j acc -> if Int_M.mem i d then Int_M.add i (j + Int_M.find i d) acc else Int_M.add i j acc) c d)
              | Some c, None -> Some c
              | None, Some d -> Some d
              | None, None -> None in
      M.merge f (M.merge f (make_priority_map e1) (make_priority_map e2)) (make_priority_map cont)
    | _ -> make_priority_map cont
    )
  | Ans(e, i) ->
    (match e with
    | CallDir(_, ys, zs) -> 
      let m = M.empty in
      let (_, m') = List.fold_left 
                  (fun (i, m') y -> let l = try M.find y m' with Not_found -> Int_M.empty in
                                   (i + 1, M.add y (Int_M.add i (try Int_M.find i l + 1 with Not_found -> 1) l) m')) (0, m) ys in
      let (_, m'') = List.fold_left 
                  (fun (i, m') y -> let l = try M.find y m' with Not_found -> Int_M.empty in
                                   (i + 1, M.add y (Int_M.add i (try Int_M.find i l + 1 with Not_found -> 1) l) m')) (0, m') zs in
      m''
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> 
      let f = fun x a b -> 
              match a, b with
              | Some c, Some d -> Some (Int_M.fold (fun i j acc -> if Int_M.mem i d then Int_M.add i (j + Int_M.find i d) acc else Int_M.add i j acc) c d)
              | Some c, None -> Some c
              | None, Some d -> Some d
              | None, None -> None in
      M.merge f (make_priority_map e1) (make_priority_map e2)
    | _ -> M.empty
    )

let rec alloc g stack spill env t m =
  let regs = (match t with Float -> Asm.fregs |  Gen -> Asm.regs) in
  match stack with
  | x :: xs -> 
    if List.mem x spill then (* spillの可能性があるものはとりあえず放置 *)
      alloc g xs spill env t m
    else
        if (M.mem x env) then
          alloc g xs spill env t m
        else
          let allocated = S.filter (fun y -> M.mem y env) (M.find x g) in (* xと干渉するもののうちすでに割り当てられているもの *)
          let used = S.map (fun y -> M.find y env) allocated (*S.fold (fun y s -> S.add (M.find y env) s) allocated S.empty*) in
          let i = find_can_use 0 used regs (try Some (M.find x m) with Not_found -> None) in
          alloc g xs spill (M.add x regs.(i) env) t m
  | [] -> (* spillは割り当ててないが，とりあえずenvを返す *)
    env



(* 彩色 *)
(* グラフと型(汎用レジスタか浮動小数レジスタか)を受け取って彩色を返す *)
let rec coloring g t e =
  let regs = (match t with Gen -> Asm.regs | Float -> Asm.fregs | Unit -> assert(false)) in
  let stack, spill = optimistic g (get_freq e) [] [] t in
  let m = make_priority_map e in
  let map = alloc g stack spill M.empty t m in (* spillなく塗れるものの塗り方 *)
  (* spillが実は塗れるかもしれない *)
  let b, map' = List.fold_left 
            (fun (b', m) x -> 
              if b' then
                (* g'はxと接している点の色の集合 *)
                let g' = S.map (fun y -> if M.mem y map then M.find y map else y) (M.find x g) in
                let b2, reg = Array.fold_left (fun (b', r) x -> if b' then (b', r) else if not (S.mem x g') then (true, x) else (false, r)) (false, "false") regs in
                if b2 then
                  b2, M.add x reg m
                else
                  b2, m
              else
                b', m
            )
            (true, map)
            spill in
  if b then
    [], map'
  else
    spill, map



(* spillが生じた際の処理 *)
let rec save x t e =
  match e with
  | Let((y, yt), exp, i, cont) ->
    (match exp with 
    | Save _ | Restore _ -> 
      Let((y, yt), exp, i, save x t cont)
    | _ ->
      if x = y then
      ( 
        incr counter;
        Let((y, yt), exp, i, Let((Id.gentmp Type.Unit, Type.Unit), Save(x, x), !counter, cont))
      )
      else
        (match exp with
        | IfEq(a, b', e1, e2) -> Let((y, yt), IfEq(a, b', save x t e1, save x t e2), i, save x t cont)
        | IfLE(a, b', e1, e2) -> Let((y, yt), IfLE(a, b', save x t e1, save x t e2), i, save x t cont)
        | IfGE(a, b', e1, e2) -> Let((y, yt), IfGE(a, b', save x t e1, save x t e2), i, save x t cont)
        | IfFEq(a', b', e1, e2) -> Let((y, yt), IfFEq(a', b', save x t e1, save x t e2), i, save x t cont)
        | IfFLE(a', b', e1, e2) -> Let((y, yt), IfFLE(a', b', save x t e1, save x t e2), i, save x t cont)
        | _ -> Let((y, yt), exp, i, save x t cont)
        )
    )
  | Ans(exp, i) ->
    (match exp with
    | IfEq(a, b', e1, e2) -> Ans(IfEq(a, b', save x t e1, save x t e2), i)
    | IfLE(a, b', e1, e2) -> Ans(IfLE(a, b', save x t e1, save x t e2), i)
    | IfGE(a, b', e1, e2) -> Ans(IfGE(a, b', save x t e1, save x t e2), i)
    | IfFEq(a', b', e1, e2) -> Ans(IfFEq(a', b', save x t e1, save x t e2), i)
    | IfFLE(a', b', e1, e2) -> Ans(IfFLE(a', b', save x t e1, save x t e2), i)
    | _ -> Ans(exp, i)
    )

let rec restore x t e =
  match e with
  | Let((y, yt), exp, i, cont) ->
    (match exp with
    | IfEq(a, b', e1, e2) -> 
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Let((y, yt), IfEq(a, b', restore x t e1, restore x t e2), i, restore x t cont))
      ) else
        Let((y, yt), IfEq(a, b', restore x t e1, restore x t e2), i, restore x t cont)
    | IfLE(a, b', e1, e2) -> 
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Let((y, yt), IfLE(a, b', restore x t e1, restore x t e2), i, restore x t cont))
      ) else
        Let((y, yt), IfLE(a, b', restore x t e1, restore x t e2), i, restore x t cont)
    | IfGE(a, b', e1, e2) -> 
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Let((y, yt), IfGE(a, b', restore x t e1, restore x t e2), i, restore x t cont))
      ) else
        Let((y, yt), IfGE(a, b', restore x t e1, restore x t e2), i, restore x t cont)
    | IfFEq(a', b', e1, e2) -> 
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Let((y, yt), IfFEq(a', b', restore x t e1, restore x t e2), i, restore x t cont))
      ) else
        Let((y, yt), IfFEq(a', b', restore x t e1, restore x t e2), i, restore x t cont)
    | IfFLE(a', b', e1, e2) -> 
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Let((y, yt), IfFLE(a', b', restore x t e1, restore x t e2), i, restore x t cont))
      ) else
        Let((y, yt), IfFLE(a', b', restore x t e1, restore x t e2), i, restore x t cont)
    | _ -> 
      let l = fv_exp exp in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Let((y, yt), exp, i, restore x t cont))
      ) else
        Let((y, yt), exp, i, restore x t cont)
    )
  | Ans(exp, i) ->
    (match exp with
    | IfEq(a, b', e1, e2) -> 
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Ans(IfEq(a, b', restore x t e1, restore x t e2), i))
      ) else
        Ans(IfEq(a, b', restore x t e1, restore x t e2), i)
    | IfLE(a, b', e1, e2) -> 
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Ans(IfLE(a, b', restore x t e1, restore x t e2), i))
      ) else
        Ans(IfLE(a, b', restore x t e1, restore x t e2), i)
    | IfGE(a, b', e1, e2) -> 
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Ans(IfGE(a, b', restore x t e1, restore x t e2), i))
      ) else
        Ans(IfGE(a, b', restore x t e1, restore x t e2), i)
    | IfFEq(a', b', e1, e2) -> 
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Ans(IfFEq(a', b', restore x t e1, restore x t e2), i))
      ) else
        Ans(IfFEq(a', b', restore x t e1, restore x t e2), i)
    | IfFLE(a', b', e1, e2) -> 
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Ans(IfFLE(a', b', restore x t e1, restore x t e2), i))
      ) else
        Ans(IfFLE(a', b', restore x t e1, restore x t e2), i)
    | _ -> 
      let l = fv_exp exp in
      if (List.mem x l) then
      (
        incr counter;
        Let((x, t), Restore(x), !counter, Ans(exp, i))
      ) else
        Ans(exp, i)
    )

    

(* 以下replace関連 *)
(* map or fmapから取り出す *)
let find x t map fmap = 
  print_endline ("attempt to find "^x);
  if Asm.is_reg x then
    x
  else
  (
  match t with
  | Float -> M.find x fmap
  | Gen -> M.find x map
  | Unit -> "%r0"
  )

let rec replace_id_or_imm x' t map fmap =
  match x' with
  | V(x) -> V(find x t map fmap)
  | c -> c

let rec replace_exp e map fmap =
(*
  print_exp 1 e;
  *)
  match e with
  | Nop | Li _ | FLi _ | SetL _ | Comment _ | SetGlb _ -> e
  | Mr(x) -> Mr(find x Gen map fmap)
  | Neg(x) -> Neg(find x Gen map fmap)
  | In(x) -> In(find x Gen map fmap)
  | Out(x) -> Out(find x Gen map fmap)
  | ItoF(x) -> ItoF(find x Gen map fmap)
  | FMr(x) -> FMr(find x Float map fmap)
  | FNeg(x) -> FNeg(find x Float map fmap)
  | FSqrt(x) -> FSqrt(find x Float map fmap)
  | FtoI(x) -> FtoI(find x Float map fmap)
  | Add(x, y') -> Add((find x Gen map fmap), replace_id_or_imm y' Gen map fmap)
  | Sub(x, y') -> Sub((find x Gen map fmap), replace_id_or_imm y' Gen map fmap)
  | Lw(x, y') -> Lw((find x Gen map fmap), replace_id_or_imm y' Gen map fmap)
  | FLw(x, y') -> FLw((find x Gen map fmap), replace_id_or_imm y' Gen map fmap)
  | Sll(x, y') -> Sll((find x Gen map fmap), replace_id_or_imm y' Gen map fmap)
  | Srl(x, y') -> Srl((find x Gen map fmap), replace_id_or_imm y' Gen map fmap)
  | Sra(x, y') -> Sra((find x Gen map fmap), replace_id_or_imm y' Gen map fmap)
  | Sw(x, y, z') -> Sw((find x Gen map fmap), find y Gen map fmap, replace_id_or_imm z' Gen map fmap)
  | FSw(x, y, z') -> FSw((find x Float map fmap), find y Gen map fmap, replace_id_or_imm z' Gen map fmap)
  | FAdd(x, y) -> FAdd((find x Float map fmap), find y Float map fmap)
  | FSub(x, y) -> FSub((find x Float map fmap), find y Float map fmap)
  | FMul(x, y) -> FMul((find x Float map fmap), find y Float map fmap)
  | FDiv(x, y) -> FDiv((find x Float map fmap), find y Float map fmap)
  | IfEq(x, y', e1, e2) -> IfEq((find x Gen map fmap), replace_id_or_imm y' Gen map fmap, replace e1 map fmap, replace e2 map fmap)
  | IfLE(x, y', e1, e2) -> IfLE((find x Gen map fmap), replace_id_or_imm y' Gen map fmap, replace e1 map fmap, replace e2 map fmap)
  | IfGE(x, y', e1, e2) -> IfGE((find x Gen map fmap), replace_id_or_imm y' Gen map fmap, replace e1 map fmap, replace e2 map fmap)
  | IfFEq(x', y', e1, e2) -> IfFEq(replace_id_or_imm x' Float map fmap, replace_id_or_imm y' Float map fmap, replace e1 map fmap, replace e2 map fmap)
  | IfFLE(x', y', e1, e2) -> IfFLE(replace_id_or_imm x' Float map fmap, replace_id_or_imm y' Float map fmap, replace e1 map fmap, replace e2 map fmap)
  | CallCls(x, ys, zs) -> CallCls(find x Gen map fmap, List.map (fun x -> find x Gen map fmap) ys, List.map (fun x -> find x Float map fmap) zs)
  | CallDir(x, ys, zs) -> CallDir(x, List.map (fun x -> find x Gen map fmap) ys, List.map (fun x -> find x Float map fmap) zs)
  | Subst((x, t), e) -> 
    let t' = (match t with | Type.Float -> Float | Type.Unit -> Unit | _ -> Gen) in
    Subst((find x t' map fmap, t), replace_exp e map fmap)
  | Save(x, y) -> if Asm.is_reg x then Save(x, y) else Save((if M.mem x map then M.find x map else M.find x fmap), y)
  | Restore(x) -> Restore(x)
  | _ -> assert(false)

and 
 replace e map fmap =
  match e with
  | Let((x, t), e, i, cont) ->
    (match e with
    (*
    | Save _ | Restore _ ->  Let((x, t), e, i, replace cont map fmap) (* Save/Restoreはすでに適切にreplaceされている *)
    *)
    | _ ->
      let x' =
      (match t with
      | Type.Float -> if Asm.is_reg x then x else (try M.find x fmap with Not_found -> Asm.reg_fzero) (* Not_foundのものはすぐに捨てられる変数などなのでなんでもよい *)
      | Type.Unit -> Asm.reg_zero (* 適当に *)
      | _ -> if Asm.is_reg x then x else (try M.find x map with Not_found -> Asm.reg_zero)
      ) in
      Let((x', t), replace_exp e map fmap, i, replace cont map fmap)
    )
  | Ans(e, i) -> Ans(replace_exp e map fmap, i)

let rec print_map map =
  M.iter (fun x y -> print_endline (x ^ " " ^ y)) map


(*
(* 初めて使われるタイミングで挿入する *)
let rec insert_restore xs ty cont map = 
  if (xs = S.empty) then
    cont
  else
    match cont with
    | _ -> cont
    | _ -> (* とりあえずすぐにrestore / 要改善 *) (* バグを取りきれなかったのでとりあえずこれで提出します *)
        let cont = S.fold
                     (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) xs cont in
        cont
    | Let((x, t), e, i, cont') ->
      (match e with
      | CallDir(a, ys, zs) ->
        let s = S.inter xs (S.of_list (ys @ zs)) in
        S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) s (Let((x, t), e, i, cont'))
      | IfEq(a, b, e1, e2) -> 
        let s = S.inter xs (S.of_list (a :: fv_id_or_imm b)) in
        S.fold 
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Let((x, t), 
            IfEq(a, b, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), 
            i, 
            insert_restore (S.diff (S.diff xs s) (S.inter (S.of_list (fv e1)) (S.of_list (fv e2)))) ty cont' map))   (* 両方でrestoreされたものはcont'でrestoreする必要がないなど，改善の余地あり *)
      | IfLE(a, b, e1, e2) -> 
        let s = S.inter xs (S.of_list (a :: fv_id_or_imm b)) in
        S.fold
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Let((x, t), 
            IfLE(a, b, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), 
            i, 
            insert_restore (S.diff (S.diff xs s) (S.inter (S.of_list (fv e1)) (S.of_list (fv e2)))) ty cont' map))
      | IfGE(a, b, e1, e2) -> 
        let s = S.inter xs (S.of_list (a :: fv_id_or_imm b)) in
        S.fold
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Let((x, t), 
            IfGE(a, b, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), 
            i, 
            insert_restore (S.diff (S.diff xs s) (S.inter (S.of_list (fv e1)) (S.of_list (fv e2)))) ty cont' map))
      | IfFEq(a, b, e1, e2) -> 
        let s = S.inter xs (S.of_list (fv_id_or_imm a @ fv_id_or_imm b)) in
        S.fold
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Let((x, t), 
            IfFEq(a, b, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), 
            i, 
            insert_restore (S.diff (S.diff xs s) (S.inter (S.of_list (fv e1)) (S.of_list (fv e2)))) ty cont' map))
      | IfFLE(a, b, e1, e2) -> 
        let s = S.inter xs (S.of_list (fv_id_or_imm a @ fv_id_or_imm b)) in
        S.fold
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Let((x, t), 
            IfFLE(a, b, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, 
              insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), 
            i, 
            insert_restore (S.diff (S.diff xs s) (S.inter (S.of_list (fv e1)) (S.of_list (fv e2)))) ty cont' map))
      | Restore(y) ->
        Let((x, t), e, i, insert_restore (S.remove y xs) ty cont' map)
        (*
      | _ ->
        let cont = S.fold
                     (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) xs cont in
        cont
        *)
      | Save(x, y) ->
        let s = S.inter xs (S.of_list (fv_exp e)) in
                    (Let((x, t), e, i, insert_restore (S.diff xs s) ty cont' map))
      | _ -> 
        let s = S.inter xs (S.of_list (fv_exp e)) in
        let cont = S.fold 
                    (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
                    s
                    (Let((x, t), e, i, insert_restore (S.diff xs s) ty cont' map)) in
        cont
      )
    | Ans(e, i) ->
      (match e with
      | Restore(y) ->
        let cont = S.fold
                     (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) (S.remove y xs) cont in
        cont
      | _ ->
        let cont = S.fold
                     (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) xs cont in
        cont
      | IfEq(a, b, e1, e2) ->
        let s = S.inter xs (S.of_list (a :: fv_id_or_imm b)) in
        S.fold 
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Ans(IfEq(a, b, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), i))
      | IfLE(a, b, e1, e2) -> 
        let s = S.inter xs (S.of_list (a :: fv_id_or_imm b)) in
        S.fold
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Ans(IfLE(a, b, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), i))
      | IfGE(a, b, e1, e2) -> 
        let s = S.inter xs (S.of_list (a :: fv_id_or_imm b)) in
        S.fold
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Ans(IfGE(a, b, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), i))
      | IfFEq(a, b, e1, e2) ->
        let s = S.inter xs (S.of_list (fv_id_or_imm a @ fv_id_or_imm b)) in
        S.fold
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Ans(IfFEq(a, b, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), i))
      | IfFLE(a, b, e1, e2) ->
        let s = S.inter xs (S.of_list (fv_id_or_imm a @ fv_id_or_imm b)) in
        S.fold
          (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc)))
          s
          (Ans(IfFLE(a, b, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e1))) ty e1 map, insert_restore (S.inter (S.diff xs s) (S.of_list (fv e2))) ty e2 map), i))
      | _ ->
      (*
        let v = S.of_list (fv_exp e) in
        print_int i; print_newline ();
        print_exp 1 e;
        S.iter (fun x -> print_string (x^" ")) v; print_newline ();
        S.iter (fun x -> print_string (x^" ")) xs; print_newline ();
        S.iter (fun x -> assert(S.mem x v)) xs;
        *)
        (*
        let cont'' = S.fold
                     (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) (S.diff xs s) (incr counter; Ans(Nop, !counter)) in
                     *)
        let cont = S.fold
                     (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) xs cont in
        cont
      )
*)    

let rec insert_restore e graph fgraph map fmap ans whenever =
  match e with
  | Let((x, t), exp, i, cont) ->
    (match exp with
    | CallDir(name, ys, zs) ->
      let s = S.diff (S.of_list ys) registered in
      let fs = S.diff (S.of_list zs) registered in
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.singleton x) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Let((x, t), exp, i, cont')) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) fs e' in
      registered', e'
    | CallCls(name, ys, zs) ->
      let s = S.diff (S.add name (S.of_list ys)) registered in
      let fs = S.diff (S.of_list zs) registered in
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.singleton x) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Let((x, t), exp, i, cont')) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) fs e' in
      registered', e'
    | IfEq(a, b', e1, e2) ->
      let s = S.diff (S.of_list (a :: fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.inter registered1 registered2) in
      registered', S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Let((x, t), IfEq(a, b', e1', e2'), i, cont'))
    | IfLE(a, b', e1, e2) ->
      let s = S.diff (S.of_list (a :: fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.inter registered1 registered2) in
      registered', S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Let((x, t), IfLE(a, b', e1', e2'), i, cont'))
    | IfGE(a, b', e1, e2) ->
      let s = S.diff (S.of_list (a :: fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.inter registered1 registered2) in
      registered', S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Let((x, t), IfGE(a, b', e1', e2'), i, cont'))
    | IfFEq(a, b', e1, e2) ->
      let s = S.diff (S.of_list (fv_id_or_imm a @ fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.inter registered1 registered2) in
      registered', S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) s (Let((x, t), IfFEq(a, b', e1', e2'), i, cont'))
    | IfFLE(a, b', e1, e2) ->
      let s = S.diff (S.of_list (fv_id_or_imm a @ fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.inter registered1 registered2) in
      registered', S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) s (Let((x, t), IfFLE(a, b', e1', e2'), i, cont'))
    | Restore(y) ->
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.add y registered) in
      registered', Let((x, t), exp, i, cont')
    | Save(y, z) ->
      let registered', cont' = insert_restore cont graph fgraph map fmap registered in
      registered', Let((x, t), exp, i, cont')
    | _ -> 
      let fv, ffv = classify_fv_exp exp t in
      let s = S.diff fv registered in
      let fs = S.diff ffv registered in
      let registered', cont' = insert_restore cont graph fgraph map fmap (S.add x (S.union s (S.union fs registered))) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Let((x, t), exp, i, cont')) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) fs e' in
      registered', e'
    )
  | Ans(exp, i) ->
    (match exp with
    | CallDir(name, ys, zs) ->
      let s = S.diff (S.of_list ys) registered in
      let fs = S.diff (S.of_list zs) registered in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Ans(exp, i)) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) fs e' in
      S.empty, e'
    | CallCls(name, ys, zs) ->
      let s = S.diff (S.add name (S.of_list ys)) registered in
      let fs = S.diff (S.of_list zs) registered in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Ans(exp, i)) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) fs e' in
      S.empty, e'
    | IfEq(a, b', e1, e2) ->
      let s = S.diff (S.of_list (a :: fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      S.inter registered1 registered2, S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Ans(IfEq(a, b', e1', e2'), i))
    | IfLE(a, b', e1, e2) ->
      let s = S.diff (S.of_list (a :: fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      S.inter registered1 registered2, S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Ans(IfLE(a, b', e1', e2'), i))
    | IfGE(a, b', e1, e2) ->
      let s = S.diff (S.of_list (a :: fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      S.inter registered1 registered2, S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Ans(IfGE(a, b', e1', e2'), i))
    | IfFEq(a, b', e1, e2) ->
      let s = S.diff (S.of_list (fv_id_or_imm a @ fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      S.inter registered1 registered2, S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) s (Ans(IfFEq(a, b', e1', e2'), i))
    | IfFLE(a, b', e1, e2) ->
      let s = S.diff (S.of_list (fv_id_or_imm a @ fv_id_or_imm b')) registered in
      let registered1, e1' = insert_restore e1 graph fgraph map fmap (S.union s registered) in
      let registered2, e2' = insert_restore e2 graph fgraph map fmap (S.union s registered) in
      S.inter registered1 registered2, S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) s (Ans(IfFLE(a, b', e1', e2'), i))
    | Restore(y) ->
      S.add y registered, Ans(exp, i)
    | Save(y, z) ->
      registered, Ans(exp, i)
    | Subst((x, t), exp) ->
      (match exp with 
      | Save(y, z) -> registered, Ans(Subst((x, t), exp), i)
      | _ ->
        let fv, ffv = classify_fv_exp exp t in
        let s = S.diff fv registered in
        let fs = S.diff ffv registered in
        let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Ans(Subst((x, t), exp), i)) in
        let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) fs e' in
        let r = (match exp with CallDir _ | CallCls _ -> S.singleton x | Restore(y) -> S.add y registered | _ -> S.add x (S.union s (S.union fs registered))) in
        r, e'
      )
    | _ -> 
      let fv, ffv = classify_fv_exp exp Type.Unit in (* なんでもいいので適当にType.Unit *)
      let s = S.diff fv registered in
      let fs = S.diff ffv registered in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, Type.Int), Restore(y), !counter, acc))) s (Ans(exp, i)) in
      let e' = S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y fmap, Type.Float), Restore(y), !counter, acc))) fs e' in
      S.union s (S.union fs registered), e'
    )
 
    

(* 呼び出し前の退避 *)
let rec save_before_call e g fg map fmap =
  match e with
  | Let((x, t), e', i, cont) ->
    (match e' with
    | CallDir(Id.L(name), ys, zs) | CallCls(name, ys, zs) ->
    (*
      let cont = insert_restore ((*S.filter (fun x -> not (Asm.is_reg x))*) (S.remove x (Int_M.find i g))) Type.Int cont map in
      let cont = insert_restore ((*S.filter (fun x -> not (Asm.is_reg x))*) (S.remove x (Int_M.find i fg))) Type.Float cont fmap in
      *)
      let cont = save_before_call cont g fg map fmap in
      let e = S.fold (fun y e -> seq (Save(M.find y map, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i g))) (Let((x, t), e', i, cont)) in
      let e = S.fold (fun y e -> seq (Save(M.find y fmap, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i fg))) e in
      e
    | IfEq(a, b, e1, e2) -> 
      Let((x, t), IfEq(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i, save_before_call cont g fg map fmap)
    | IfGE(a, b, e1, e2) -> 
      Let((x, t), IfGE(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i, save_before_call cont g fg map fmap)
    | IfLE(a, b, e1, e2) -> 
      Let((x, t), IfLE(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i, save_before_call cont g fg map fmap)
    | IfFEq(a, b, e1, e2) -> 
      Let((x, t), IfFEq(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i, save_before_call cont g fg map fmap)
    | IfFLE(a, b, e1, e2) ->
      Let((x, t), IfFLE(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i, save_before_call cont g fg map fmap)
    | _ -> 
      Let((x, t), e', i, save_before_call cont g fg map fmap)
    )
  | Ans(e', i) ->
    (match e' with
    | IfEq(a, b, e1, e2) -> 
      Ans(IfEq(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i)
    | IfGE(a, b, e1, e2) ->
      Ans(IfGE(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i)
    | IfLE(a, b, e1, e2) ->
      Ans(IfLE(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i)
    | IfFEq(a, b, e1, e2) ->
      Ans(IfFEq(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i)
    | IfFLE(a, b, e1, e2) ->
      Ans(IfFLE(a, b, save_before_call e1 g fg map fmap, save_before_call e2 g fg map fmap), i)
    | Subst((x, t), exp) ->
      (match exp with 
      | CallDir(Id.L(name), ys, zs) | CallCls(name, ys, zs) ->
        incr counter;
        (*
        let res = insert_restore (S.remove x (Int_M.find i g)) Type.Int (Ans(Nop, !counter)) map in
        let res = insert_restore (S.remove x (Int_M.find i fg)) Type.Float res fmap in
        *)
        let e = S.fold (fun y e -> seq (Save(M.find y map, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i g))) (Ans(Subst((x, t), exp), i)) in
        let e = S.fold (fun y e -> seq (Save(M.find y fmap, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i fg))) e in
        e
      | _ -> Ans(e', i)
      )
    | e' -> Ans(e', i)
    )


(*
let rec insert_restore_spill x t reg_spl e =
  match e with
  | Let((y, yt), exp, i, cont) ->
    (match exp with
    | IfEq(a, b', e1, e2) ->
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Let((y, yt), IfEq(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont))
      ) else
        Let((y, yt), IfEq(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont)
    | IfLE(a, b', e1, e2) ->
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Let((y, yt), IfLE(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont))
      ) else
        Let((y, yt), IfLE(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont)
    | IfGE(a, b', e1, e2) ->
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Let((y, yt), IfGE(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont))
      ) else
        Let((y, yt), IfGE(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont)
    | IfFEq(a', b', e1, e2) ->
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Let((y, yt), IfFEq(a', b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont))
      ) else
        Let((y, yt), IfFEq(a', b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont)
    | IfFLE(a', b', e1, e2) ->
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Let((y, yt), IfFLE(a', b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont))
      ) else
        Let((y, yt), IfFLE(a', b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i, insert_restore_spill x t reg_spl cont)
    | _ -> 
      if (List.mem x (fv_exp exp)) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Let((y, yt), exp, i, insert_restore_spill x t reg_spl cont))
      ) else
        Let((y, yt), exp, i, insert_restore_spill x t reg_spl cont)
    )
  | Ans(exp, i) ->
    (match exp with
    | IfEq(a, b', e1, e2) ->
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Ans(IfEq(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i))
      ) else
        Ans(IfEq(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i)
    | IfLE(a, b', e1, e2) ->
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Ans(IfLE(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i))
      ) else
        Ans(IfLE(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i)
    | IfGE(a, b', e1, e2) ->
      let l = a :: fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Ans(IfGE(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i))
      ) else
        Ans(IfGE(a, b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i)
    | IfFEq(a', b', e1, e2) ->
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Ans(IfFEq(a', b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i))
      ) else
        Ans(IfFEq(a', b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i)
    | IfFLE(a', b', e1, e2) ->
      let l = fv_id_or_imm a' @ fv_id_or_imm b' in
      if (List.mem x l) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Ans(IfFLE(a', b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i))
      ) else
        Ans(IfFLE(a', b', insert_restore_spill x t reg_spl e1, insert_restore_spill x t reg_spl e2), i)
    | _ -> 
      if (List.mem x (fv_exp exp)) then
      (
        incr counter;
        Let((reg_spl, t), Restore(x), !counter, Ans(exp, i))
      ) else
        Ans(exp, i)
    )
*)
let rec allocate e =
(*
  print_t 1 e;
  *)
  let graph, fgraph = iter_analysis Int_M.empty Int_M.empty e in
  let g = make_graph graph in
  let fg = make_graph fgraph in
  let spill, map = coloring g Gen e in
  let fspill, fmap = coloring fg Float e in
  if (spill = [] && fspill = []) then
    let e = save_before_call e graph fgraph map fmap in
    let _, e = insert_restore e graph fgraph map fmap S.empty in
    replace e map fmap
  else if (spill = []) then
    let e = List.fold_left (fun e' x -> save x (Type.Float) (restore x (Type.Float) e')) e fspill in
    allocate e
  else if (fspill = []) then
    let e = List.fold_left (fun e' x -> save x (Type.Int) (restore x (Type.Int) e')) e spill in
    allocate e
  else
    let e = List.fold_left (fun e' x -> save x (Type.Float) (restore x (Type.Float) e')) e fspill in
    let e = List.fold_left (fun e' x -> save x (Type.Int) (restore x (Type.Int) e')) e spill in
    allocate e



let rec allocate_fun { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t } =
  print_endline ("allocate "^x);
  (*
  print_t 1 e;
  *)
  let graph, fgraph = iter_analysis Int_M.empty Int_M.empty e in

(*
  Int_M.iter (fun i s -> print_int i; print_string "  "; S.iter (fun y -> print_string (y^" ")) s; print_newline ()) graph; 
  *)
  (* まずは汎用レジスタから *)
  let g = make_graph graph in
  let stack, spill = optimistic g (get_freq e) ys [] Gen in (* 引数が割り当てられるレジスタは決まっている *)
  let (i, env) = List.fold_left (fun (i, env) y -> (i + 1, M.add y Asm.regs.(i) env)) (0, (M.add x Asm.reg_cl M.empty)) ys in (* reg_clに注意 *)
  let map = alloc g stack spill env Gen (make_priority_map e) in

  let b, map' = List.fold_left 
            (fun (b', m) x -> 
              if b' then
                (* g'はxと接している点の色の集合 *)
                let g' = S.map (fun y -> if M.mem y m then M.find y m else y) (M.find x g) in
                let b2, reg = Array.fold_left (fun (b', r) x -> if b' then (b', r) else if not (S.mem x g') then (true, x) else (false, r)) (false, "false") Asm.regs in
                if b2 then
                  b2, M.add x reg m
                else
                  b2, m
              else
                b', m
            )
            (true, map)
            spill in
  let spill, map = 
    if b then
      [], map'
    else
      spill, map
  in



  (* 浮動小数レジスタ *)

(*
  Int_M.iter (fun i s -> print_int i; print_string "  "; S.iter (fun y -> print_string (y^" ")) s; print_newline ()) fgraph; 
  *)
  let fg = make_graph fgraph in
  let stack, fspill = optimistic fg (get_freq e) zs [] Float in
  let (i, env) = List.fold_left (fun (i, env) y -> (i + 1, M.add y Asm.fregs.(i) env)) (0, M.empty) zs in
  let fmap = alloc fg stack fspill env Float (make_priority_map e) in
  let b, map' = List.fold_left 
            (fun (b', m) x -> 
              if b' then
                (* g'はxと接している点の色の集合 *)
                let g' = S.map (fun y -> if M.mem y m then M.find y m else y) (M.find x g) in
                let b2, reg = Array.fold_left (fun (b', r) x -> if b' then (b', r) else if not (S.mem x g') then (true, x) else (false, r)) (false, "false") Asm.fregs in
                if b2 then
                  b2, M.add x reg m
                else
                  b2, m
              else
                b', m
            )
            (true, fmap)
            fspill in
  let fspill, fmap = 
    if b then
      [], map'
    else
      fspill, map
  in
  if (spill = [] && fspill = []) then
    let e = save_before_call e graph fgraph map fmap in
    let _, e = insert_restore e graph fgraph map fmap (S.add x (S.union (S.of_list ys) (S.of_list zs))) in
    { name = Id.L(x); args = ys; fargs = zs; body = replace e map fmap; ret = t }
  else if (spill = []) then
    let e = List.fold_left (fun e' x -> save x (Type.Float) (restore x (Type.Float) e')) e fspill in
    allocate_fun { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t }
  else if (fspill = []) then
    let e = List.fold_left (fun e' x -> save x (Type.Int) (restore x (Type.Int) e')) e spill in
    allocate_fun { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t }
  else
    let e = List.fold_left (fun e' x -> save x (Type.Float) (restore x (Type.Float) e')) e fspill in
    let e = List.fold_left (fun e' x -> save x (Type.Int) (restore x (Type.Int) e')) e spill in
    allocate_fun { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t }

  


let rec f (Prog(data, fundefs, e)) =
  table := List.fold_left (fun m { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t } -> M.add x t m) M.empty fundefs;
  let e = allocate e in
  Prog(data, List.map allocate_fun fundefs, e)
