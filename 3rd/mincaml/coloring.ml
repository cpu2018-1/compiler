open Num_asm

type ty = Float | Gen

let print_graph g =
  M.iter (fun x s -> print_string (x^"  ");
                S.iter (fun y -> print_string (y^" ")) s; print_newline ()) g

(* 汎用レジスタか浮動小数レジスタかを分ける *)
(* Save/Restoreはない前提 *)
let classify_fv_exp e = 
  match e with
  | Nop | Li _ | FLi _ | SetL _ | Comment _ | SetGlb _ | Save _ | Restore _ -> S.empty, S.empty
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


(* live[i]の更新 *)
let rec update lives flives succ dest =
  match succ with
  | [] -> S.empty, S.empty
  | e :: es -> 
    (
    match e with
    | Let((x, t), e, j, cont) ->
      let def, fdef = 
        (match t with
        | Type.Unit -> S.empty, S.empty
        | Type.Float -> S.empty, S.singleton x
        | _ -> S.singleton x, S.empty
        ) in
      let fv_g, fv_f = classify_fv_exp e in (* 汎用レジスタ用と浮動小数レジスタ用 *)
      let live_j = try Int_M.find j lives with Not_found -> S.empty in
      let flive_j = try Int_M.find j flives with Not_found -> S.empty in
      let lives', flives' = update lives flives es dest in
      let live_j' = S.union (S.union (S.diff (live_j) def) fv_g) lives' in
      let flive_j' = S.union (S.union (S.diff (flive_j) fdef) fv_f) flives' in
      (live_j', flive_j')
    | Ans(e, j) ->
      let def, fdef = 
        (match dest with
        | x, Type.Unit -> S.empty, S.empty
        | x, Type.Float -> S.empty, S.singleton x
        | x, _ -> S.singleton x, S.empty
        ) in
      let fv_g, fv_f = classify_fv_exp e in (* 汎用レジスタ用と浮動小数レジスタ用 *)
      let live_j = try Int_M.find j lives with Not_found -> S.empty in
      let flive_j = try Int_M.find j flives with Not_found -> S.empty in
      let lives', flives' = update lives flives es dest in
      let live_j' = S.union (S.union (S.diff (live_j) def) fv_g) lives' in
      let flive_j' = S.union (S.union (S.diff (flive_j) fdef) fv_f) flives' in
      (live_j', flive_j')
    )

(* eを走査する部分 *)
let rec liveness_analysis_main lives flives t succ dest =
  match t with
  | Let((x, t), e, i, cont) ->
    (match e with
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> (* ここのiに対応する命令は比較であることにする *)
      let lives1, flives1 = liveness_analysis_main lives flives e1 [cont] (x, t) in 
      let lives2, flives2 = liveness_analysis_main lives1 flives1 e2 [cont] (x, t) in 
      let live_i, flive_i = update lives2 flives2 [e1; e2] (x, t) in (* live[i]を更新 *)
      liveness_analysis_main (Int_M.add i live_i lives2) (Int_M.add i flive_i flives2) cont succ dest
    | _ -> 
      let live_i, flive_i = update lives flives [cont] dest in
      liveness_analysis_main (Int_M.add i live_i lives) (Int_M.add i flive_i flives) cont succ dest
    )
  | Ans(e, i) -> 
    (match e with
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> (* ここの(x, t)に対応する命令は比較であることにする *)
      let lives1, flives1 = liveness_analysis_main lives flives e1 succ dest in 
      let lives2, flives2 = liveness_analysis_main lives1 flives1 e2 succ dest in 
      let live_i, flive_i = update lives2 flives2 [e1; e2] dest in (* live[i]を更新 *)
      Int_M.add i live_i lives2, Int_M.add i flive_i flives2
    | _ -> 
      let live_i, flive_i = update lives flives succ dest in
      Int_M.add i live_i lives, Int_M.add i flive_i flives
    )


let rec iter_analysis lives flives t =
  let lives', flives' = liveness_analysis_main lives flives t [] ("_R_0", Type.Unit) in
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

let rec find_can_use i used regs =
  if S.mem regs.(i) used then
    find_can_use (i + 1) used regs
  else
    i

let rec alloc g stack spill env t =
  let regs = (match t with Float -> Asm.fregs |  Gen -> Asm.regs) in
  match stack with
  | x :: xs -> 
    if List.mem x spill then
      env
    else
      if (Asm.is_reg x) then (* レジスタの場合はそのまま *) (* [TODO]レジスタがspillの対象になりうるので変えるべき(そのうち変えます) *) (* <- 本当になりうる? *)
        alloc g xs spill (M.add x x env) t 
      else
        if (M.mem x env) then
        alloc g xs spill env t
        else
          let allocated = S.filter (fun y -> M.mem y env) (M.find x g) in (* xと干渉するもののうちすでに割り当てられているもの *)
          let used = S.fold (fun y s -> S.add (M.find y env) s) allocated S.empty in
          let i = find_can_use 0 used regs in
          alloc g xs spill (M.add x regs.(i) env) t
  | [] -> env

let rec replace_id_or_imm x' map =
  match x' with
  | V(x) -> V(if Asm.is_reg x then x else M.find x map)
  | c -> c

let rec replace_exp e map fmap =
  match e with
  | Nop | Li _ | FLi _ | SetL _ | Comment _ | SetGlb _ -> e
  | Mr(x) -> Mr(if Asm.is_reg x then x else M.find x map)
  | Neg(x) -> Neg(if Asm.is_reg x then x else M.find x map)
  | In(x) -> In(if Asm.is_reg x then x else M.find x map)
  | Out(x) -> Out(if Asm.is_reg x then x else M.find x map)
  | ItoF(x) -> ItoF(if Asm.is_reg x then x else M.find x map)
  | FMr(x) -> FMr(if Asm.is_reg x then x else M.find x fmap)
  | FNeg(x) -> FNeg(if Asm.is_reg x then x else M.find x fmap)
  | FSqrt(x) -> FSqrt(if Asm.is_reg x then x else M.find x fmap)
  | FtoI(x) -> FtoI(if Asm.is_reg x then x else M.find x fmap)
  | Add(x, y') -> Add((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map)
  | Sub(x, y') -> Sub((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map)
  | Lw(x, y') -> Lw((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map)
  | FLw(x, y') -> FLw((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map)
  | Sll(x, y') -> Sll((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map)
  | Srl(x, y') -> Srl((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map)
  | Sra(x, y') -> Sra((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map)
  | Sw(x, y, z') -> Sw((if Asm.is_reg x then x else M.find x map), (if Asm.is_reg y then y else M.find y map), replace_id_or_imm z' map)
  | FSw(x, y, z') -> FSw((if Asm.is_reg x then x else M.find x fmap), (if Asm.is_reg y then y else M.find y map), replace_id_or_imm z' map)
  | FAdd(x, y) -> FAdd((if Asm.is_reg x then x else M.find x fmap), if Asm.is_reg y then y else M.find y fmap)
  | FSub(x, y) -> FSub((if Asm.is_reg x then x else M.find x fmap), if Asm.is_reg y then y else M.find y fmap)
  | FMul(x, y) -> FMul((if Asm.is_reg x then x else M.find x fmap), if Asm.is_reg y then y else M.find y fmap)
  | FDiv(x, y) -> FDiv((if Asm.is_reg x then x else M.find x fmap), if Asm.is_reg y then y else M.find y fmap)
  | IfEq(x, y', e1, e2) -> IfEq((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map, replace e1 map fmap, replace e2 map fmap)
  | IfLE(x, y', e1, e2) -> IfLE((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map, replace e1 map fmap, replace e2 map fmap)
  | IfGE(x, y', e1, e2) -> IfGE((if Asm.is_reg x then x else M.find x map), replace_id_or_imm y' map, replace e1 map fmap, replace e2 map fmap)
  | IfFEq(x', y', e1, e2) -> IfFEq(replace_id_or_imm x' fmap, replace_id_or_imm y' fmap, replace e1 map fmap, replace e2 map fmap)
  | IfFLE(x', y', e1, e2) -> IfFLE(replace_id_or_imm x' fmap, replace_id_or_imm y' fmap, replace e1 map fmap, replace e2 map fmap)
  | CallCls(x, ys, zs) -> CallCls(x, List.map (fun x -> if Asm.is_reg x then x else M.find x map) ys, List.map (fun x -> if Asm.is_reg x then x else M.find x fmap) zs)
  | CallDir(x, ys, zs) -> CallDir(x, List.map (fun x -> if Asm.is_reg x then x else M.find x map) ys, List.map (fun x -> if Asm.is_reg x then x else M.find x fmap) zs)
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
let rec coloring g t =
  let stack, spill = optimistic g [] [] t in
  let map = alloc g stack spill M.empty t in map

(* とりあえず挿入するだけ *)
let rec insert_restore xs ty e map = 
  S.fold (fun y acc -> if Asm.is_reg y then acc else (incr counter; Let((M.find y map, ty), Restore(y), !counter, acc))) xs e


let rec save_before_call e g fg map fmap =
  match e with
  | Let((x, t), e', i, cont) ->
    (match e' with
    | CallDir(name, ys, zs) ->
      let cont = insert_restore (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i g))) Type.Int cont map in
      let cont = insert_restore (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i fg))) Type.Float cont fmap in
      let restores, frestores, cont = save_before_call cont g fg map fmap in (* restoresは，ifの中で末尾に呼び出しがある際にifを出てからrestoreするやつを取り出す *)
      let e = S.fold (fun y e -> seq (Save(M.find y map, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i g))) (Let((x, t), e', i, cont)) in
      let e = S.fold (fun y e -> seq (Save(M.find y fmap, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (S.remove x (Int_M.find i fg))) e in
      restores, frestores, e
    | IfEq(a, b, e1, e2) -> 
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      let z, w, cont' = save_before_call cont g fg map fmap in
      let cont' = insert_restore (S.remove x (S.union restores1 restores2)) Type.Int cont' map in
      let cont' = insert_restore (S.remove x (S.union frestores1 frestores2)) Type.Float cont' fmap in
      z, w,(*S.remove x (S.union restores1 restores2), S.remove x (S.union frestores1 frestores2), *)Let((x, t), IfEq(a, b, e1', e2'), i, cont'')
    | IfGE(a, b, e1, e2) -> 
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      let z, w, cont' = save_before_call cont g fg map fmap in
      let cont' = insert_restore (S.remove x (S.union restores1 restores2)) Type.Int cont' map in
      let cont' = insert_restore (S.remove x (S.union frestores1 frestores2)) Type.Float cont' fmap in
      z, w,(*S.empty, S.empty,*)(*S.remove x (S.union restores1 restores2), S.remove x (S.union frestores1 frestores2), *)Let((x, t), IfGE(a, b, e1', e2'), i, cont')
    | IfLE(a, b, e1, e2) -> 
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      let z, w, cont' = save_before_call cont g fg map fmap in
      let cont' = insert_restore (S.remove x (S.union restores1 restores2)) Type.Int cont' map in
      let cont' = insert_restore (S.remove x (S.union frestores1 frestores2)) Type.Float cont' fmap in
      z, w,(*S.empty, S.empty,*)(*S.remove x (S.union restores1 restores2), S.remove x (S.union frestores1 frestores2), *)Let((x, t), IfLE(a, b, e1', e2'), i, cont')
    | IfFEq(a, b, e1, e2) -> 
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      let z, w, cont' = save_before_call cont g fg map fmap in
      let cont' = insert_restore (S.remove x (S.union restores1 restores2)) Type.Int cont' map in
      let cont' = insert_restore (S.remove x (S.union frestores1 frestores2)) Type.Float cont' fmap in
      z, w,(*S.empty, S.empty,*)(*S.remove x (S.union restores1 restores2), S.remove x (S.union frestores1 frestores2), *)Let((x, t), IfFEq(a, b, e1', e2'), i, cont')
    | IfFLE(a, b, e1, e2) ->
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      let z, w, cont' = save_before_call cont g fg map fmap in
      let cont' = insert_restore (S.remove x (S.union restores1 restores2)) Type.Int cont' map in
      let cont' = insert_restore (S.remove x (S.union frestores1 frestores2)) Type.Float cont' fmap in
      z, w,(*S.empty, S.empty,*)(*S.remove x (S.union restores1 restores2), S.remove x (S.union frestores1 frestores2), *)Let((x, t), IfFLE(a, b, e1', e2'), i, cont')
    | e' -> 
      let restores, frestores, cont' = save_before_call cont g fg map fmap in
      restores, frestores, Let((x, t), e', i, cont')
    )
  | Ans(e', i) ->
    (match e' with
    (* [TODO] 末尾で呼び出しがある場合に何とかする *)
    | CallDir(name, ys, zs) ->
      let e = S.fold (fun y e -> seq (Save(M.find y map, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (Int_M.find i g)) (Ans(e', i)) in
      let e = S.fold (fun y e -> seq (Save(M.find y fmap, y), e)) (S.filter (fun x -> not (Asm.is_reg x)) (Int_M.find i fg)) e in
      Int_M.find i g, Int_M.find i fg, e
    | IfEq(a, b, e1, e2) -> 
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      S.union restores1 restores2, S.union frestores1 frestores2, Ans(IfEq(a, b, e1', e2'), i)
    | IfGE(a, b, e1, e2) ->
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      S.union restores1 restores2, S.union frestores1 frestores2, Ans(IfGE(a, b, e1', e2'), i)
    | IfLE(a, b, e1, e2) ->
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      S.union restores1 restores2, S.union frestores1 frestores2, Ans(IfLE(a, b, e1', e2'), i)
    | IfFEq(a, b, e1, e2) ->
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      S.union restores1 restores2, S.union frestores1 frestores2, Ans(IfFEq(a, b, e1', e2'), i)
    | IfFLE(a, b, e1, e2) ->
      let restores1, frestores1, e1' = save_before_call e1 g fg map fmap in
      let restores2, frestores2, e2' = save_before_call e2 g fg map fmap in
      S.union restores1 restores2, S.union frestores1 frestores2, Ans(IfFLE(a, b, e1', e2'), i)
    | e' -> S.empty, S.empty, Ans(e', i)
    )


let rec allocate e =
  let graph, fgraph = iter_analysis Int_M.empty Int_M.empty e in
  let g = make_graph graph in
  let fg = make_graph fgraph in
  let map = coloring g Gen in
  let fmap = coloring fg Float in
  let _, _, e = save_before_call e graph fgraph map fmap in
  replace e map fmap


let rec allocate_fun { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t } =
  print_endline ("allocate "^x);
  let graph, fgraph = iter_analysis Int_M.empty Int_M.empty e in
  Int_M.iter (fun i s -> print_int i; print_string "  "; S.iter (fun y -> print_string (y^" ")) s; print_newline ()) graph; 
  (* まずは汎用レジスタから *)
  let g = make_graph graph in
  let stack, spill = optimistic g [] [] Gen in
  let (i, env) = List.fold_left (fun (i, env) y -> (i + 1, M.add y Asm.regs.(i) env)) (0, ((*M.add x Asm.reg_cl*) M.empty)) ys in (* reg_clに注意 *)
  let map = alloc g stack spill env Gen in
  (* 浮動小数レジスタ *)

  Int_M.iter (fun i s -> print_int i; print_string "  "; S.iter (fun y -> print_string (y^" ")) s; print_newline ()) fgraph; 
  let fg = make_graph fgraph in
  let stack, spill = optimistic fg [] [] Float in
  let (i, env) = List.fold_left (fun (i, env) y -> (i + 1, M.add y Asm.fregs.(i) env)) (0, M.empty) zs in
  let fmap = alloc fg stack spill env Float in
(*
  print_endline "print map";
  print_map map;
  print_endline "print fmap";
  print_map fmap;
*)

  let _, _, e = save_before_call e graph fgraph map fmap in
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
  let map = coloring g Gen in
  let fmap = coloring fg Float in
  (*
  print_endline "print map";
  print_map map;
  print_endline "print fmap";
  print_map fmap;
  *)
  let _, _, e = save_before_call e graph fgraph map fmap in
  let e = replace e map fmap in
  Prog(data, List.map allocate_fun fundefs, e)
