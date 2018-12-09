open Num_asm

(* 定義したが使わなさそう *)
(*
let rec update x lives cont = 
  match cont with
  | Let((y, t), e, i, cont') -> 
    match e with 
    | IfEq(a, b', t1, t2) | IfLE(a, b', e1, e2) | IfGE(a, b', e1, e2) | IfFEq(a, b', e1, e2) | IfFLE(a, b', e1, e2) ->
      
    let lives' = update x lives cont' in
    let live_y = if(Int_M.mem y lives') then Int_M.find y lives' else Int_S.empty in
    let live_x = if(Int_M.mem x lives') then Int_M.find x lives' else Int_S.empty in
    Int_M.add x (Int_S.union (Int_S.union (Int_S.diff live_y (Int_S.singleton y)) (Int_S.of_list (fv_exp e))) live_x) lives'
  | Ans(e) -> lives
  *)



let rec update lives succ =
  match succ with
  | [] -> S.empty
  | e :: es -> 
    match e with
    | Let((x, t), e, j, cont) ->
      let live_j = if (Int_M.mem j lives) then Int_M.find j lives else S.empty in
      S.union (S.union (S.diff (live_j) (S.singleton x)) (S.of_list (fv_exp e))) (update lives es)
    | Ans(e, j) ->
      let live_j = if (Int_M.mem j lives) then Int_M.find j lives else S.empty in
      S.union (S.union (live_j) (S.of_list (fv_exp e))) (update lives es)
      
      


let rec liveness_analysis_main lives t succ =
  match t with
  | Let((x, t), e, i, cont) ->
    print_int i; print_newline ();
    (match e with 
    | IfEq(a, b', e1, e2) | IfLE(a, b', e1, e2) | IfGE(a, b', e1, e2) -> (* ここの(x, t)に対応する命令は比較であることにする *)
      let live_i = update lives [e1; e2] in
      let lives1 = liveness_analysis_main lives e1 [cont] in 
      let lives2 = liveness_analysis_main lives1 e1 [cont] in 
      liveness_analysis_main (Int_M.add i live_i lives2) cont succ
    | IfFEq(a, b', e1, e2) | IfFLE(a, b', e1, e2) -> (* ここの(x, t)に対応する命令は比較であることにする *)
      let live_i = update lives [e1; e2] in
      let lives1 = liveness_analysis_main lives e1 [cont] in 
      let lives2 = liveness_analysis_main lives1 e1 [cont] in 
      liveness_analysis_main (Int_M.add i live_i lives) cont succ
    | _ -> 
      let live_i = update lives [cont] in
      liveness_analysis_main (Int_M.add i live_i lives) cont succ
    )
  | Ans(e, i) -> 
    let live_i = update lives succ in
    Int_M.add i live_i lives
    

let rec iter_analysis lives t =
  print_endline "iter!";
  let lives' = liveness_analysis_main lives t [] in
  if (lives' = lives) then
    lives
  else
    iter_analysis lives' t


let rec analysis_fun { name = x; args = xs; fargs = ys; body = e; ret = t} =
  { Asm.name = x; Asm.args = xs; Asm.fargs = ys; Asm.body = invert_t e; Asm.ret = t}

let rec f (Prog(data, fundefs, e)) =
  let g = iter_analysis Int_M.empty e in
  let g' = Int_M.bindings g in
  List.iter (fun (x, l) -> print_string ((string_of_int x)^"  ");
                          S.iter (fun y -> print_string (y^" ")) l; print_newline ()) g';
  print_int (Int_M.cardinal g); print_newline ();
  Asm.Prog(data, List.map invert_fun fundefs, invert_t e)
