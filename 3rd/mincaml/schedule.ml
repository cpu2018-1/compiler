open Num_asm


let rec add_edge i yi graph =
  let edges = 
    if (Int_M.mem i graph) then
      Int_M.find i graph
    else
      []
  in
    Int_M.add i (yi:: edges) graph


let rec check_war x i t graph =
  match t with
  | Let((y, _), e, j, t') -> 
    if (List.mem x (fv_exp e)) then
      check_war x i t' (add_edge i (j, 0) graph)
    else
      check_war x i t' graph
  | Ans(e, j) -> graph

let rec check_raw i xs t graph =
  match t with
  | Let((y, _), e, j, t') ->
    if (List.mem y xs) then
      check_raw i xs t' (add_edge i (j, 0) graph)
    else
      check_raw i xs t' graph
  | Ans(e, j) -> graph


let rec check_waw x i t graph =
  match t with
  | Let((y, _), e, j, t') ->
    if (x = y) then
      check_waw x i t' (add_edge i (j, 0) graph)
    else
      check_waw x i t' graph
  | Ans(e, j) -> graph



let rec make_graph_t t graph =
  match t with
  | Ans(e, i) -> graph
  | Let((x, _), e, i, cont) -> 
    let graph1 = check_war x i cont graph in
    let graph2 = check_raw i (fv_exp e) cont graph1 in
    let graph3 = check_waw x i cont graph2 in
    make_graph_t cont graph3


let rec ready_set graph =
  Int_M.filter (fun x l -> l = []) graph




let rec f (Prog(data, fundefs, e)) =
  let g = make_graph_t e Int_M.empty in
  let g' = Int_M.bindings g in
  List.iter (fun (x, l) -> print_string ((string_of_int x)^"  ");
                          List.iter (fun (y, i) -> print_string ((string_of_int y)^" ")) l; print_newline ()) g';
  print_int (Int_M.cardinal g); print_newline ();
  Prog(data, fundefs, e)
