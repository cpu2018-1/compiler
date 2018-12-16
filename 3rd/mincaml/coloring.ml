open Num_asm

type def_type = Unit | Float | Gen

(* 汎用レジスタか浮動小数レジスタかを分ける *)
(* Save/Restoreはない前提 *)
let classify_fv_exp = function
  | Nop | Li _ | FLi _ | SetL _ | Comment _ | SetGlb _  -> S.empty, S.empty
  | Mr(x) | Neg(x) | In(x) | Out(x) | ItoF(x) -> S.singleton x, S.empty
  | FMr(x) | FNeg(x) | FSqrt(x) | FtoI(x) -> S.empty, S.singleton x
  | Add(x, y') | Sub(x, y') | FLw(x, y') | Lw(x, y') | Sll(x, y') | Srl(x, y') | Sra(x, y') -> S.of_list (x :: fv_id_or_imm y'), S.empty
  | Sw(x, y, z') -> S.of_list (x :: y :: fv_id_or_imm z'), S.empty
  | FSw(x, y, z') -> S.of_list (y :: fv_id_or_imm z'), S.singleton x
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> S.empty, S.of_list [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> S.of_list (fv_id_or_imm y'), S.empty
  | IfFEq(x, y', e1, e2) | IfFLE(x, y', e1, e2) -> S.empty, S.of_list (fv_id_or_imm y')
  | CallCls(x, ys, zs) -> S.of_list (x :: ys), S.of_list zs
  | CallDir(_, ys, zs) -> S.of_list ys, S.of_list zs
  | _ -> assert(false)


(* live[i]の更新 *)
let rec update lives flives succ dest =
  match succ with
  | [] -> S.empty, S.empty
  | e :: es -> 
    (
    match e with
    | Let((x, t), e, j, cont) ->
      let fv_g, fv_f = classify_fv_exp e in (* 汎用レジスタ用と浮動小数レジスタ用 *)
      let live_j = try Int_M.find j lives with Not_found -> S.empty in
      let flive_j = try Int_M.find j flives with Not_found -> S.empty in
      let lives', flives' = update lives flives es dest in
      let def, fdef = 
        (match t with
        | Type.Unit -> S.empty, S.empty
        | Type.Float -> S.empty, S.singleton x
        | _ -> S.singleton x, S.empty
        ) in
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
      let live_j = if (Int_M.mem j lives) then Int_M.find j lives else S.empty in
      let flive_j = if (Int_M.mem j flives) then Int_M.find j flives else S.empty in
      let lives', flives' = update lives flives es dest in
      let live_j' = S.union (S.union (S.diff (live_j) def) fv_g) lives' in
      let flive_j' = S.union (S.union (S.diff (flive_j) fdef) fv_f) flives' in
      (live_j', flive_j')
    )



let rec liveness_analysis_main lives flives t succ dest =
  match t with
  | Let((x, t), e, i, cont) ->
    (match e with
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> (* ここの(x, t)に対応する命令は比較であることにする *)
      let lives1, flives1 = liveness_analysis_main lives flives e1 [cont] (x, t) in 
      let lives2, flives2 = liveness_analysis_main lives1 flives1 e2 [cont] (x, t) in 
      let live_i, flive_i = update lives2 flives2 [e1; e2] dest in (* live[i]を更新 *)
      liveness_analysis_main (Int_M.add i live_i lives2) (Int_M.add i flive_i flives2) cont succ dest
    | _ -> 
      let live_i, flive_i = update lives flives [cont] dest in
      liveness_analysis_main (Int_M.add i live_i lives) (Int_M.add i flive_i flives) cont succ dest
    )
  | Ans(e, i) -> 
    (match e with
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> (* ここの(x, t)に対応する命令は比較であることにする *)
      let lives1, flives1 = liveness_analysis_main lives flives e1 [] dest in 
      let lives2, flives2 = liveness_analysis_main lives1 flives1 e2 [] dest in 
      let live_i, flive_i = update lives2 flives2 [e1; e2] dest in (* live[i]を更新 *)
      Int_M.add i live_i lives2, Int_M.add i flive_i flives2
    | _ -> 
      let live_i, flive_i = update lives flives [] dest in
      Int_M.add i live_i lives, Int_M.add i flive_i flives
    )
 
    

let rec iter_analysis lives flives t =
  let lives', flives' = liveness_analysis_main lives flives t [] ("_R_0", Type.Unit) in
  if (lives' = lives && flives = flives') then
    lives, flives
  else
    iter_analysis lives' flives' t


let rec analysis_fun { name = Id.L(x); args = xs; fargs = ys; body = e; ret = t} =
  let g, fg = iter_analysis Int_M.empty Int_M.empty e in
  (*
  print_endline ("analyze "^x);
  print_endline "general purpose";
  Int_M.iter (fun x l -> print_string ((string_of_int x)^"  ");
                          S.iter (fun y -> print_string (y^" ")) l; print_newline ()) g;
  print_endline "float point";
  Int_M.iter (fun x l -> print_string ((string_of_int x)^"  ");
                          S.iter (fun y -> print_string (y^" ")) l; print_newline ()) fg;
  *)
  { name = Id.L(x); args = xs; fargs = ys; body = e; ret = t}

let rec f (Prog(data, fundefs, e)) =
  let g, fg = iter_analysis Int_M.empty Int_M.empty e in
  (*
  print_endline "general purpose";
  Int_M.iter (fun x l -> print_string ((string_of_int x)^"  ");
                          S.iter (fun y -> print_string (y^" ")) l; print_newline ()) g;
  print_endline "float point";
  Int_M.iter (fun x l -> print_string ((string_of_int x)^"  ");
                          S.iter (fun y -> print_string (y^" ")) l; print_newline ()) fg;
  let fundefs' = List.map analysis_fun fundefs in
  *)
  Prog(data, fundefs, e)
