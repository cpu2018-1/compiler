open KNormal

let rec list_diff l1 l2 = 
  match l1 with
  | [] -> []
  | x :: xs -> 
    if (List.mem x l2) then
      list_diff xs l2
    else
      x :: (list_diff xs l2) 


let rec lifted free = function (* lambda liftingされるべき関数をその自由変数と共にe1の中から列挙する *)
  | LetRec ({ name = (x, t); args = yts; body = e1 }, e2) -> 
    let zs = S.diff (fv e1) (S.add x (S.of_list (List.map fst yts))) in
    let intersection = S.inter (S.of_list (List.map fst free)) zs in
    if (S.is_empty intersection) then
      lifted free e2
    else
      let rec find a l = 
        match l with
        | [] -> failwith ("something went wrong")
        | (x, t) :: xs when x = a -> (x, t)
        | (x, t) :: xs -> find a xs
      in
      ({ name = (x, t); args = yts; body = e1 }, List.map (fun x -> find x free) (S.elements intersection)) :: (lifted free e2)
  | Let ((x, t), e1, e2) ->
    lifted free e1 @ lifted free e2
  | IfEq (x, y, e1, e2) 
  | IfLE (x, y, e1, e2) ->
    lifted free e1 @ lifted free e2
  | e -> []

let rec lifted_delete free = function (* lambda liftingされるべき関数をその自由変数と共にe1の中から列挙する *)
  | LetRec ({ name = (x, t); args = yts; body = e1 }, e2) -> 
    let zs = S.diff (fv e1) (S.add x (S.of_list (List.map fst yts))) in
    let intersection = S.inter (S.of_list (List.map fst free)) zs in
    if (S.is_empty intersection) then
      LetRec ({ name = (x, t); args = yts; body = e1 }, lifted_delete free e2)
    else
      lifted_delete free e2
  | Let ((x, t), e1, e2) -> 
    Let ((x, t), lifted_delete free e1, lifted_delete free e2)
  | IfEq(x, y, e1, e2) ->
    IfEq(x, y, lifted_delete free e1, lifted_delete free e2)
  | IfLE(x, y, e1, e2) ->
    IfLE(x, y, lifted_delete free e1, lifted_delete free e2)
  | e -> e




let concat defs e = 
  let f ({ name = (x, t); args = yts; body = e1 }, zts) e =
    LetRec ({ name = (x, t); args = yts @ zts; body = e1 }, e) in
  List.fold_right f defs e

let rec lifting free = function (* bound は自由変数の集合 *)
  | LetRec ({ name = (x, t); args = yts; body = e1 }, e2) -> 
    let free' = (x, t) :: yts @ free in
    let e1' = lifting free' e1 in
    let defs = lifted free' e1' in
    let e1'' = lifted_delete free' e1' in
    concat defs (LetRec({ name = (x, t); args = yts; body = e1'' }, lifting free e2))
  | Let ((x, t), e1, e2) ->
    Let ((x, t), lifting free e1, lifting free e2)
  | IfLE (x, y, e1, e2) ->
    IfLE (x, y, lifting free e1, lifting free e2)
  | IfEq (x, y, e1, e2) ->
    IfEq (x, y, lifting free e1, lifting free e2)
  | e -> e
