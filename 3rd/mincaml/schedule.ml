open Num_asm

let rec ready_set graph =
  let a = Int_M.fold (fun a l s -> Int_Int_S.fold (fun p ss -> Int_S.add (fst p) ss) l s) graph Int_S.empty in
  let b = Int_M.fold (fun a l s -> Int_S.add a s) graph Int_S.empty in
(*  print_endline "Ready set";
  Int_S.iter (fun a -> print_int a; print_string " ") ready; print_newline ();
  *)
  Int_S.diff b a


type instr = NOP | ALU | FPU | MEM | If | Unknown

let rec get_itype = function
  | Nop | Sw _ | FSw _ | Save _ | In _ | Out _ | Comment _ -> NOP
  | Li _ | SetL _ | Mr _ | Neg _ | Add _ | Sub _ | SetGlb _ | Sll _ | Srl _ | Sra _ -> ALU
  | FLi _ | FMr _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ | FSqrt _ | FtoI _ | ItoF _ -> FPU
  | Lw _ | FLw _ | Restore _ -> MEM
  | IfEq _ | IfLE _ | IfGE _ | IfFEq _ | IfFLE _ -> If
  | _ -> Unknown


let rec set_edge a b =
  match a, b with
  (*
  | ALU, ALU -> 1
  | MEM, _ -> 3
  | FPU, FPU -> 3
  | _ -> 0
  *)
  | ALU, ALU -> 2
  | MEM, _ -> 2
  | FPU, FPU -> 2
  | _ -> 0

(* グラフの型は (Int_Int_S.t) Int_M.t *)

let rec add_edge i yi graph =
  let edges = 
    if (Int_M.mem i graph) then
      Int_M.find i graph
    else
      Int_Int_S.empty
  in
    Int_M.add i (Int_Int_S.add yi edges) graph

let rec fv_of_if e =
  match e with
  | IfEq(a, b', e1, e2) | IfLE(a, b', e1, e2) | IfGE(a, b', e1, e2) ->
    (match b' with
    | V(b) -> true, [a; b;]
    | _ -> true, [a;]
    )
  | IfFEq(a', b', e1, e2) | IfFLE(a', b', e1, e2) ->
    (match a', b' with
    | V(a), V(b) -> true, [a; b]
    | V(a), _ -> true, [a;]
    | _, V(b) -> true, [b]
    | _, _ -> true, []
    )
  | _ -> false, fv_exp e


let rec check_if i cont graph =
  match cont with
  | Let((y, _), e, j, t') ->
    let is_if, _ = fv_of_if e in
    if (is_if) then
      check_if i t' (add_edge i (j, 0) graph)
    else
      check_if i t' graph
  | Ans(e, j) ->
    let is_if, _ = fv_of_if e in
    if (is_if) then
      add_edge i (j, 0) graph
    else
      graph
    

let rec add_all_edges i cont graph =
  match cont with
  | Let((y, _), e, j, t') ->
    add_all_edges i t' (add_edge i (j, 0) graph)
  | Ans(e, j) ->
      add_edge i (j, 0) graph
 


let rec check_war x i i_type t graph =
  match t with
  | Let((y, _), e, j, t') -> 
    let is_if, fvs = fv_of_if e in
    if (is_if) then
      (match e with
      | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
      | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        let g = check_war x i i_type t' (add_edge i (j, (set_edge i_type (get_itype e))) graph) in
        let g = check_war x i i_type e1 g in
        let g = check_war x i i_type e2 g in
        g
      | _ -> assert(false)
      )
    else
      if (List.mem x (fv_exp e)) then
        check_war x i i_type t' (add_edge i (j, (set_edge i_type (get_itype e))) graph) (* 0はレイテンシ/とりえあず0入れとく *)
      else
        check_war x i i_type t' graph
  | Ans(e, j) ->
    let is_if, fvs = fv_of_if e in
    if (is_if) then
      (match e with
      | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
      | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        let g = check_war x i i_type e1 (add_edge i (j, (set_edge i_type (get_itype e))) graph) in
        let g = check_war x i i_type e2 g in
        g
      | _ -> assert(false)
      )
    else
      if (List.mem x (fv_exp e)) then
        add_edge i (j, (set_edge i_type (get_itype e))) graph
      else
        graph
 

let rec check_raw i i_type xs t graph =
  match t with
  | Let((y, _), e, j, t') ->
    let is_if, fvs = fv_of_if e in
    if (is_if) then
      (match e with
      | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
      | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        let g = check_raw i i_type xs t' (add_edge i (j, (set_edge i_type (get_itype e))) graph) in
        let g = check_raw i i_type xs e1 g in
        let g = check_raw i i_type xs e2 g in
        g
      | _ -> assert(false)
      )
    else
      if (List.mem y xs) then
        check_raw i i_type xs t' (add_edge i (j, (set_edge i_type (get_itype e))) graph)
      else
        check_raw i i_type xs t' graph
  | Ans(e, j) ->
    let is_if, fvs = fv_of_if e in
    if (is_if) then
      (match e with
      | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
      | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        let g = check_raw i i_type xs e1 graph in
        let g = check_raw i i_type xs e2 g in
        g
      | _ -> assert(false)
      )
    else
      graph
 

let rec check_waw x i i_type t graph =
  match t with
  | Let((y, _), e, j, t') ->
    let is_if, fvs = fv_of_if e in
    if (is_if) then
      (match e with
      | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
      | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        let g = check_waw x i i_type t' (add_edge i (j, (set_edge i_type (get_itype e))) graph) in
        let g = check_waw x i i_type e1 g in
        let g = check_waw x i i_type e2 g in
        g
      | _ -> assert(false)
      )
    else
      if (x = y) then
        check_waw x i i_type t' (add_edge i (j, (set_edge i_type (get_itype e))) graph)
      else
        check_waw x i i_type t' graph
  | Ans(e, j) ->
    let is_if, fvs = fv_of_if e in
    if (is_if) then
      (match e with
      | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
      | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        let g = check_waw x i i_type e1 graph in
        let g = check_waw x i i_type e2 g in
        g
      | _ -> assert(false)
      )
    else
      graph
 

let rec check_stall x i i_type fvs cont graph =
  let graph = check_war x i i_type cont graph in
  let graph = check_raw i i_type fvs cont graph in
  let graph = check_waw x i i_type cont graph in
  check_if i cont graph 

let replace_if e a b =
  match e with
  | IfEq(x, y, e1, e2) -> IfEq(x, y, a, b)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, a, b)
  | IfGE(x, y, e1, e2) -> IfGE(x, y, a, b)
  | IfFLE(x, y, e1, e2) -> IfFLE(x, y, a, b)
  | IfFEq(x, y, e1, e2) -> IfFEq(x, y, a, b)
  | _ -> assert(false)


let rec determine_path_set g = (* クリティカルパスの写像を返す *)
  let ready = ready_set g in
  if (Int_S.cardinal ready = Int_M.cardinal g) then 
    Int_M.fold (fun i _ s -> Int_M.add i 0 s) g Int_M.empty
  else
    try
    let i = Int_S.choose ready in
    let s = Int_M.find i g in  (* iから出る辺の集合 *)
    let g' = Int_M.remove i g in
    let set = determine_path_set g' in (* g'に対してクリティカルパスを求めたもの *)
    let m = Int_Int_S.fold (fun (k, w) t -> max (w + Int_M.find k set) t) s (0) in
    Int_M.add i m set
    with Not_found -> raise (Failure ("hoge"))



let rec determine_path g =
  let ready = ready_set g in
  let s = determine_path_set g in
  let m, _ = Int_S.fold (fun i (k, mi) -> if mi < Int_M.find i s then (i, Int_M.find i s) else (k, mi)) ready (0, 0) in
  m 

let rec determine g =
  let i = determine_path g in
  print_int i; print_newline ();
  i




let rec fetch_sub e j =
  match e with
  | Let((x, t), e', i, cont) ->
    if (i = j) then
      ((x, t), e', i), cont
    else
      let ej, cont' = fetch_sub cont j in
      ej, Let((x, t), e', i, cont')
  | Ans(e', i) ->
    assert(false)

let rec fetch e j = (* j の命令を前に持ってくる *)
  let ((x, t), ej, j), e' = fetch_sub e j in
  Let((x, t), ej, j, e')
  

let rec list_scheduling e =
  match e with
  | Let((x, t), e', i, cont) ->
    let e, g = make_graph_t e Int_M.empty in
    let j = determine g in 
    let Let((y, yt), ye, yi, ycont) = fetch e j in
    Let((y, yt), ye, yi, list_scheduling ycont)
  | Ans(e, i) -> Ans(e, i)

and
(* 依存グラフを構成する *)
 make_graph_t t graph =
  match t with
  | Ans(e, i) ->
    let is_if, fvs = fv_of_if e in
    if (is_if) then
      (match e with
      | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
      | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        let e1' = list_scheduling e1 in
        let e2' = list_scheduling e2 in
        Ans(replace_if e e1' e2', i), graph
      | _ -> assert(false)
      )
    else
      Ans(e, i), (Int_M.add i Int_Int_S.empty graph)
  | Let((x, xt), e, i, cont) -> 
    let is_if, fvs = fv_of_if e in
    if (is_if) then
      (match e with 
      | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
      | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        let e1' = list_scheduling e1 in
        let e2' = list_scheduling e2 in
        let g = add_all_edges i cont graph in
        let cont', g = make_graph_t cont g in
        Let((x, xt), replace_if e e1' e2', i, cont'), g
      | _ -> assert(false)
      )
    else
      let graph' = check_stall x i (get_itype e) (fv_exp e) cont graph in
      let cont', g = make_graph_t cont graph' in
      Let((x, xt), e, i, cont'), g


let print_graph g =
  Int_M.iter (fun i s -> print_int i; print_string "  ";
                Int_Int_S.iter (fun (a, b) -> Printf.printf "(%d, %d)" a b; print_string " ";) s; print_newline ()) g


let rec f (Prog(data, fundefs, e)) =
  let e, g = make_graph_t e Int_M.empty in
  let e = list_scheduling e in
  let ready = ready_set g in
  print_graph g;
  Prog(data, fundefs, e)
