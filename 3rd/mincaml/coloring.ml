open Num_asm

type def_type = Unit | Float | Gen

(* 汎用レジスタか浮動小数レジスタかを分ける *)
(* Save/Restoreはない前提 *)
let classify_fv_exp = function
  | Nop | Li _ | FLi _ | SetL _ | Comment _ | SetGlb _  -> S.empty, S.empty
  | Mr(x) | Neg(x) | In(x) | Out(x) | ItoF(x) | -> S.singleton x, S.empty
  | FMr(x) | FNeg(x) | FSqrt(x) | FtoI(x) -> S.empty, S.singleton x
  | Add(x, y') | Sub(x, y') | FLw(x, y') | Lw(x, y') | Sll(x, y') | Srl(x, y') | Sra(x, y') -> S.of_list (x :: fv_id_or_imm y'), S.empty
  | Sw(x, y, z') -> S.of_list (x :: y :: fv_id_or_imm z'), S.empty
  | FSw(x, y, z') -> S.of_list (y :: fv_id_or_imm z'), S.singleton x
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> S.empty, S.of_list [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> S.of_list (x :: fv_id_or_imm y'), S.empty
  | IfFEq(x, y', e1, e2) | IfFLE(x, y', e1, e2) -> S.empty, S.of_list (fv_id_or_imm x @ fv_id_or_imm y')
  | CallCls(x, ys, zs) -> S.of_list (x :: ys), S.of_list zs
  | CallDir(_, ys, zs) -> S.of_lsit ys, S.of_list zs
  | _ -> assert(false)

let rec defined_ans = function
  | Let(_, _, _, cont) -> defined_ans cont
  | Ane(e, _) -> defined e
and

 defined = function
  | Nop | Comment _ | In _ | Out _ | Sw _ | FSw _ -> Unit
  | Li _ | SetL _ | SetGlb _ | Mr _ | Neg _ | FtoI _ | Add _ | Sub _ | Lw _ | Sll _ | Srl _ | Sra _ -> Gen
  | FLi _ | ItoF _ | FMr _ | FNeg _ | FSqrt _ | FLw _ | FAdd _ | FSub _ | FMul _ | FDiv _ -> Float
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) |
  | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> 
      let t1 = defined_ans e1 in
      let t2 = defined_ans e2 in
      assert (t1 = t2); t1
  (* [TODO] 関数呼び出しをなんとかする *)
  | _ -> assert false


(* live[i]の更新 *)
let rec update lives flives succ =
  match succ with
  | [] -> S.empty
  | e :: es -> 
    (
    match e with
    | Let((x, t), e, j, cont) ->
      let fv_g, fv_f = classify_fv_exp e in (* 汎用レジスタ用と浮動小数レジスタ用 *)
      let live_j = if (Int_M.mem j lives) then Int_M.find j lives else S.empty in
      let flive_j = if (Int_M.mem j flives) then Int_M.find j flives else S.empty in
      let lives', flives' = update lives flives es in
      let def, fdef = 
        (match defined e with
        | Unit -> S.empty, S.empty
        | Gen -> S.singleton x, S.emtpy
        | Float -> S.empty, S.singleton x
        ) in
      let lives_j' = S.union (S.union (S.diff (live_j) def) fv_g) lives' in
      let flives_j' = S.union (S.union (S.diff (flive_j) fdef) fv_f) flives' in
      (live_j', flive_j')
    | Ans(e, j) ->
      let fv_g, fv_f = classify_fv_exp e in (* 汎用レジスタ用と浮動小数レジスタ用 *)
      let live_j = if (Int_M.mem j lives) then Int_M.find j lives else S.empty in
      let flive_j = if (Int_M.mem j flives) then Int_M.find j flives else S.empty in
      let lives', flives' = update lives flives es in
      let live_j' = S.union (S.union (live_j) fv_g) lives' in
      let flive_j' = S.union (S.union (flive_j) fv_f) flives' in
      (live_j', flive_j')
    )



let rec liveness_analysis_main lives flives t succ =
  match t with
  | Let((x, t), e, i, cont) ->
    (match e with 
    | IfEq(a, b', e1, e2) | IfLE(a, b', e1, e2) | IfGE(a, b', e1, e2) -> (* ここの(x, t)に対応する命令は比較であることにする *)
      let live_i, flive_i = update lives flives [e1; e2] in
      let lives1 = liveness_analysis_main lives flives e1 [cont] in 
      let lives2 = liveness_analysis_main lives1 flives e2 [cont] in 
      liveness_analysis_main (Int_M.add i live_i lives2) (Int_M.add i flive_i f)cont succ
    | IfFEq(a, b', e1, e2) | IfFLE(a, b', e1, e2) -> (* ここの(x, t)に対応する命令は比較であることにする *)
      let live_i = update lives [e1; e2] in
      let lives1 = liveness_analysis_main lives e1 [cont] in 
      let lives2 = liveness_analysis_main lives1 e2 [cont] in 
      liveness_analysis_main (Int_M.add i live_i lives) cont succ
    | _ -> 
      let live_i = update lives [cont] in
      liveness_analysis_main (Int_M.add i live_i lives) cont succ
    )
  | Ans(e, i) -> 
    let live_i = update lives succ in
    Int_M.add i live_i lives
    

let rec iter_analysis lives t =
  let lives' = liveness_analysis_main lives t [] in
  if (lives' = lives) then
    lives
  else
    iter_analysis lives' t


let rec analysis_fun { name = Id.L(x); args = xs; fargs = ys; body = e; ret = t} =
  { Asm.name = Id.L(x); Asm.args = xs; Asm.fargs = ys; Asm.body = invert_t e; Asm.ret = t}

let rec f (Prog(data, fundefs, e)) =
  let g = iter_analysis Int_M.empty e in
  let g' = Int_M.bindings g in
  (*
  List.iter (fun (x, l) -> print_string ((string_of_int x)^"  ");
                          S.iter (fun y -> print_string (y^" ")) l; print_newline ()) g';
  let fundefs' = List.map analysis_fun fundefs in
  *)
  Prog(data, fundefs, e)
