open Num_asm

type ty = Float | Gen | Unit

let print_graph g =
  M.iter (fun x s -> print_string (x^"  ");
                S.iter (fun y -> print_string (y^" ")) s; print_newline ()) g

(* 汎用レジスタか浮動小数レジスタかを分ける *)
let rec classify_fv_exp e = 
  match e with
  | Nop | Li _ | FLi _ | SetL _ | Comment _ | SetGlb _ -> S.empty, S.empty
  | Mr(x) | Neg(x) | In(x) | Out(x) | ItoF(x) -> S.singleton x, S.empty
  | FMr(x) | FNeg(x) | FSqrt(x) | FtoI(x) -> S.empty, S.singleton x
  | Add(x, y') | Sub(x, y') | FLw(x, y') | Lw(x, y') | Sll(x, y') | Srl(x, y') | Sra(x, y') -> S.of_list (x :: fv_id_or_imm y'), S.empty
  | Sw(x, y, z') -> S.of_list (x :: y :: fv_id_or_imm z'), S.empty
  | FSw(x, y, z') -> S.of_list (y :: fv_id_or_imm z'), S.singleton x
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> S.empty, S.of_list [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> S.of_list (x :: fv_id_or_imm y'), S.empty
  | IfFEq(x, y', e1, e2) | IfFLE(x, y', e1, e2) -> S.empty, S.of_list (fv_id_or_imm x @ fv_id_or_imm y')
  | CallCls(x, ys, zs) -> failwith "クロージャはとりあえずエラー" (*S.of_list (x :: ys), S.of_list zs*)
  | CallDir(_, ys, zs) -> S.of_list ys, S.of_list zs
  | Subst((x, t), e) -> classify_fv_exp e
  | _ -> failwith ("something went wrong")


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
      let fv_g, fv_f = classify_fv_exp e in (* 汎用レジスタ用と浮動小数レジスタ用 *)
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
      let fv_g, fv_f = classify_fv_exp e in (* 汎用レジスタ用と浮動小数レジスタ用 *)
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
  if (lives' = lives && flives' = flives) then 
    lives, flives
  else
    iter_analysis lives' flives' t


(* 生存解析の情報から干渉グラフを構成する *)
let rec make_graph g =
  Int_M.fold 
    (fun i live m -> 
      S.fold (fun x m' -> M.add x (S.union (S.remove x live) (try M.find x m' with Not_found -> S.empty)) m') live m)
    g
    M.empty

(* 楽観的彩色 *)
let rec optimistic g stack spill t =
  if (M.cardinal g = 0) then
    stack, spill
  else
    let length = Array.length (match t with Float -> Asm.fregs | Gen -> Asm.regs) in
    let r = M.fold 
              (fun x s r ->
                match r with
                | Some y -> Some y
                | None ->
                  if (S.cardinal s < length) then
                    Some x
                  else
                    None) g None in
    match r with (* 確実に塗れるものがあるか *)
    | Some x -> optimistic (M.remove x (M.map (S.remove x) g)) (x :: stack) spill t
    | None -> 
      print_endline "spillある...";
      failwith "spillがあるのでとりあえずエラー";
      let (x, _) = M.choose g in 
      optimistic (M.remove x (M.map (fun s -> (S.filter (fun a -> x <> a) s)) g)) (x :: stack) (x :: spill) t

let rec find_step_by_step i step used regs =
  if S.mem regs.(i) used then
    find_step_by_step (i + step) step used regs
  else
    i

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
    if List.mem x spill then
      failwith ("hoge")
      (*
      env
      *)
    else
(*      if (Asm.is_reg x) then (* レジスタの場合はそのまま *) (* [TODO]レジスタがspillの対象になりうるので変えるべき(そのうち変えます) *) (* <- 本当になりうる? *)
        alloc g xs spill (M.add x x env) t 
      else
 *)       if (M.mem x env) then
          alloc g xs spill env t m
        else
          let allocated = S.filter (fun y -> M.mem y env) (M.find x g) in (* xと干渉するもののうちすでに割り当てられているもの *)
          let used = S.map (fun y -> M.find y env) allocated (*S.fold (fun y s -> S.add (M.find y env) s) allocated S.empty*) in
          let i = find_can_use 0 used regs (try Some (M.find x m) with Not_found -> None) in
          alloc g xs spill (M.add x regs.(i) env) t m
  | [] -> env


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
  | CallCls(x, ys, zs) -> CallCls(x, List.map (fun x -> find x Gen map fmap) ys, List.map (fun x -> find x Float map fmap) zs)
  | CallDir(x, ys, zs) -> CallDir(x, List.map (fun x -> find x Gen map fmap) ys, List.map (fun x -> find x Float map fmap) zs)
  | Subst((x, t), e) -> 
    let t' = (match t with | Type.Float -> Float | Type.Unit -> Unit | _ -> Gen) in
    Subst((find x t' map fmap, t), replace_exp e map fmap)
  | Save(x, y) -> Save(x, y)
  | Restore(x) -> Restore(x)
  | _ -> assert(false)

and 
 replace e map fmap =
  match e with
  | Let((x, t), e, i, cont) ->
    (match e with
    | Save _ | Restore _ ->  Let((x, t), e, i, replace cont map fmap) (* Restoreはすでに適切になっている *)
    | _ ->
      let x' =
      (match t with
      | Type.Float -> if Asm.is_reg x then x else (try M.find x fmap with Not_found -> Asm.reg_fzero) (* Not_foundのものはすぐに捨てられる変数などなのでなんでもよい *)
      | Type.Unit -> "%r0" (* 適当に *)
      | _ -> if Asm.is_reg x then x else (try M.find x map with Not_found -> Asm.reg_zero)
      ) in
      Let((x', t), replace_exp e map fmap, i, replace cont map fmap)
    )
  | Ans(e, i) -> Ans(replace_exp e map fmap, i)

let rec print_map map =
  M.iter (fun x y -> print_endline (x ^ " " ^ y)) map

(* 彩色 *)
(* グラフと型(汎用レジスタか浮動小数レジスタか)を受け取って彩色を返す *)
let rec coloring g t e =
  let stack, spill = optimistic g [] [] t in
  let m = make_priority_map e in
  let map = alloc g stack spill M.empty t m in map

(* とりあえず挿入するだけ *)
let rec insert_restore xs ty e map = 
  S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) xs e


let rec save_before_call e g fg map fmap =
  match e with
  | Let((x, t), e', i, cont) ->
    (match e' with
    | CallDir(name, ys, zs) ->
      let cont = insert_restore ((*S.filter (fun x -> not (Asm.is_reg x))*) (S.remove x (Int_M.find i g))) Type.Int cont map in
      let cont = insert_restore ((*S.filter (fun x -> not (Asm.is_reg x))*) (S.remove x (Int_M.find i fg))) Type.Float cont fmap in
      let cont = save_before_call cont g fg map fmap in (* restoresは，ifの中で末尾に呼び出しがある際にifを出てからrestoreするやつを取り出す *)
      let e = S.fold (fun y e -> seq (Save(M.find y map, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i g))) (Let((x, t), e', i, cont)) in
      let e = S.fold (fun y e -> seq (Save(M.find y fmap, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i fg))) e in
      e
    | IfEq(a, b, e1, e2) -> 
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      let cont' = save_before_call cont g fg map fmap in
      Let((x, t), IfEq(a, b, e1', e2'), i, cont')
    | IfGE(a, b, e1, e2) -> 
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      let cont' = save_before_call cont g fg map fmap in
      Let((x, t), IfGE(a, b, e1', e2'), i, cont')
    | IfLE(a, b, e1, e2) -> 
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      let cont' = save_before_call cont g fg map fmap in
      Let((x, t), IfLE(a, b, e1', e2'), i, cont')
    | IfFEq(a, b, e1, e2) -> 
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      let cont' = save_before_call cont g fg map fmap in
      Let((x, t), IfFEq(a, b, e1', e2'), i, cont')
    | IfFLE(a, b, e1, e2) ->
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      let cont' = save_before_call cont g fg map fmap in
      Let((x, t), IfFLE(a, b, e1', e2'), i, cont')
    | e' -> 
      let cont' = save_before_call cont g fg map fmap in
      Let((x, t), e', i, cont')
    )
  | Ans(e', i) ->
    (match e' with
    (* [TODO] 末尾で呼び出しがある場合に何とかする *)
    | CallDir(name, ys, zs) ->
    (*
      let e = S.fold (fun y e -> seq (Save(M.find y map, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (Int_M.find i g)) (Ans(e', i)) in
      let e = S.fold (fun y e -> seq (Save(M.find y fmap, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (Int_M.find i fg)) e in
      *)
      e
    | IfEq(a, b, e1, e2) -> 
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      Ans(IfEq(a, b, e1', e2'), i)
    | IfGE(a, b, e1, e2) ->
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      Ans(IfGE(a, b, e1', e2'), i)
    | IfLE(a, b, e1, e2) ->
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      Ans(IfLE(a, b, e1', e2'), i)
    | IfFEq(a, b, e1, e2) ->
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      Ans(IfFEq(a, b, e1', e2'), i)
    | IfFLE(a, b, e1, e2) ->
      let e1' = save_before_call e1 g fg map fmap in
      let e2' = save_before_call e2 g fg map fmap in
      Ans(IfFLE(a, b, e1', e2'), i)
    | Subst((x, t), exp)->
      (match exp with 
      | CallDir(name, ys, zs) ->
        incr counter;
        let res = insert_restore (S.remove x (Int_M.find i g)) Type.Int (Ans(Nop, !counter)) map in
        let res = insert_restore (S.remove x (Int_M.find i fg)) Type.Float res fmap in
        let e = S.fold (fun y e -> seq (Save(M.find y map, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (Int_M.find i g)) (Let((x, t), e', i, res)) in
        let e = S.fold (fun y e -> seq (Save(M.find y fmap, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (Int_M.find i fg)) e in
        e
      | _ -> Ans(e', i)
      )
    | e' -> Ans(e', i)
    )


let rec allocate e =
  let graph, fgraph = iter_analysis Int_M.empty Int_M.empty e in
  let g = make_graph graph in
  let fg = make_graph fgraph in
  let map = coloring g Gen e in
  let fmap = coloring fg Float e in
  let e = save_before_call e graph fgraph map fmap in
  replace e map fmap


let rec allocate_fun { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t } =
  print_endline ("allocate "^x);
  let graph, fgraph = iter_analysis Int_M.empty Int_M.empty e in
  Int_M.iter (fun i s -> print_int i; print_string "  "; S.iter (fun y -> print_string (y^" ")) s; print_newline ()) graph; 
  (* まずは汎用レジスタから *)
  let g = make_graph graph in
  let stack, spill = optimistic g [] [] Gen in
  let (i, env) = List.fold_left (fun (i, env) y -> (i + 1, M.add y Asm.regs.(i) env)) (0, ((*M.add x Asm.reg_cl*) M.empty)) ys in (* reg_clに注意 *)
  let map = alloc g stack spill env Gen (make_priority_map e) in
  (* 浮動小数レジスタ *)

  Int_M.iter (fun i s -> print_int i; print_string "  "; S.iter (fun y -> print_string (y^" ")) s; print_newline ()) fgraph; 
  let fg = make_graph fgraph in
  let stack, spill = optimistic fg [] [] Float in
  let (i, env) = List.fold_left (fun (i, env) y -> (i + 1, M.add y Asm.fregs.(i) env)) (0, M.empty) zs in
  let fmap = alloc fg stack spill env Float (make_priority_map e) in
(*
  print_endline "print map";
  print_map map;
  print_endline "print fmap";
  print_map fmap;
*)

  let e = save_before_call e graph fgraph map fmap in
  { name = Id.L(x); args = ys; fargs = zs; body = replace e map fmap; ret = t }
  


let rec f (Prog(data, fundefs, e)) =
  let graph, fgraph = iter_analysis Int_M.empty Int_M.empty e in (* 生存解析 *)
  Int_M.iter (fun i s -> Printf.printf "%d  " i; S.iter (fun x -> print_string (x^" ")) s; print_newline ()) graph;
  let g = make_graph graph in
  let fg = make_graph fgraph in
  (*
  print_endline "print graph";
  print_graph g;
  *)
  let map = coloring g Gen e in
  let fmap = coloring fg Float e in
  print_endline "print map";
  print_map map;
  print_endline "print fmap";
  print_map fmap;
  let e = save_before_call e graph fgraph map fmap in
  let e = replace e map fmap in
  Prog(data, List.map allocate_fun fundefs, e)
