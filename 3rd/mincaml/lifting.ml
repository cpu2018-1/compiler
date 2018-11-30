open KNormal

let rec list_diff l1 l2 = 
  match l1 with
  | [] -> []
  | x :: xs -> 
    if (List.mem x l2) then
      list_diff xs l2
    else
      x :: (list_diff xs l2) 

let rec is_used_as_var x = function
  | Var(h) when h = x -> true
  | IfEq(a, b, e1, e2) | IfEq(a, b, e1, e2) -> is_used_as_var x e1 || is_used_as_var x e2
  | Let((a, t), e1, e2) when a <> x -> is_used_as_var x e1 || is_used_as_var x e2
  | Let((a, t), e1, e2) -> is_used_as_var x e1
  | LetRec({ name = (a, t); args = yts; body = e1 }, e2) when a <> x ->
        is_used_as_var x e1 || is_used_as_var x e2
  | App(_, ys) | Tuple(ys) | ExtFunApp(_, ys) ->
            List.fold_left (fun b y -> (y = x) || b) false ys
  | LetTuple(xts, y, e) when not (List.mem x (List.map fst xts)) -> x = y || is_used_as_var x e
  | LetTuple(xts, y, e) -> x = y
  | e -> false


let rec add_arguments h zts = function
  | LetRec ({ name = (x, t); args = yts; body = e1 }, e2) when x <> h -> 
    LetRec ({ name = (x, t); args = yts; body = (add_arguments h zts e1) }, add_arguments h zts e2)
  | Let ((x, t), e1, e2) when x <> h -> 
    Let ((x, t), add_arguments h zts e1, add_arguments h zts e2)
  | Let ((x, t), e1, e2) -> 
    Let ((x, t), add_arguments h zts e1, e2)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, add_arguments h zts e1, add_arguments h zts e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, add_arguments h zts e1, add_arguments h zts e2)
  | App(x, xts) when x = h -> App(x, xts @ zts)
  | LetTuple(xts, y, e) when not (List.mem h (List.map fst xts)) -> LetTuple(xts, y, add_arguments h zts e)
  | e -> e


let rec type_fun_ext t ts =
  match t with 
  | Type.Fun(xs, t) -> Type.Fun(xs @ ts, t)
  | _ -> failwith("something went wrong in type_fun_ext")


let rec lifted free = function (* lambda liftingされるべき関数をその自由変数と共にe1の中から列挙しつつ，元の定義部は消す *)
  | LetRec ({ name = (x, t); args = yts; body = e1 }, e2) -> 
    let zs = S.diff (fv e1) (S.add x (S.of_list (List.map fst yts))) in
    let intersection = S.inter (S.of_list (List.map fst free)) zs in
    if (S.is_empty intersection) then (* xが自由変数を持たないならxに対しては特に何もしない *)
        let lifted_list, e2' = lifted free e2 in
        (lifted_list, LetRec ({ name = (x, t); args = yts; body = e1 }, e2'))
    else
      if (is_used_as_var x e1 || is_used_as_var x e2) then (* 変数として使われているときはlambda lifting しない *)
        let lifted_list, e2' = lifted free e2 in
        (lifted_list, LetRec ({ name = (x, t); args = yts; body = e1 }, e2'))
      else (* lambda lifting する *)
        let lifted_list, e2' = lifted free e2 in
        let rec find a l = 
          match l with
          | [] -> failwith ("something went wrong")
          | (x, t) :: xs when x = a -> (x, t)
          | (x, t) :: xs -> find a xs
        in
        let zts = List.map (fun x -> find x free) (S.elements intersection) in
        (({ name = (x, (type_fun_ext t (List.map (fun x -> snd x) zts))); args = yts; body = e1 }, zts) :: lifted_list, add_arguments x (List.map (fun x -> fst x) zts) e2')
  | Let ((x, t), e1, e2) ->
    let l1, e1' = lifted free e1 in
    let l2, e2' = lifted free e2 in
    (l1 @ l2, Let((x, t), e1', e2'))
  | IfEq (x, y, e1, e2) ->
    let l1, e1' = lifted free e1 in
    let l2, e2' = lifted free e2 in
    (l1 @ l2, IfEq(x, y, e1', e2'))
  | IfLE (x, y, e1, e2) ->
    let l1, e1' = lifted free e1 in
    let l2, e2' = lifted free e2 in
    (l1 @ l2, IfLE(x, y, e1', e2'))
  | LetTuple(xts, y, e) ->
    let l, e' = lifted free e in
    (l, LetTuple(xts, y, e'))
  | e -> ([], e)




let concat defs e = 
  let f ({ name = (x, t); args = yts; body = e1 }, zts) e =
    LetRec ({ name = (x, t); args = yts @ zts; body = e1 }, e) in
  List.fold_right f defs e

let rec lifting_fun = function
  | LetRec ({ name = (x, t); args = yts; fun = e1 }, e2) -> 
    let free = yts in
    let e1' = lifting_fun e1 in
    let defs, e1'' = lifted free e1' in
    concat defs ((LetRec({ name = (x, t); args = yts; fun = e1'' }, lifting_fun e2)))
  | Let ((x, t), e1, e2) ->
    let free = [(x, t)] in
    let e1' = lifting_fun e1 in
    let e2' = lifting_fun e2 in
    let defs, e1'' = lifted free e1' in
    concat defs (Let ((x, t), e1'', e2'))
  | IfLE (x, y, e1, e2) -> IfLE (x, y, lifting_fun e1, lifting_fun e2)
  | IfEq (x, y, e1, e2) -> IfEq (x, y, lifting_fun e1, lifting_fun e2)
  | LetTuple(xts, y, e) ->
    let free = xts in
    let e' = lifting_fun e in
    let defs, e'' = lifted free e' in
    concat defs (LetTuple(xts, y, lifting_fun e''))
  | e -> e


let rec lifting_formula env = function
  | LetRec ({ name = (x, t); args = yts; fun = e1 }, e2) -> 


let rec iter f e = (* 式をliftingするのを繰り返す *)
  Format.eprintf "iteration %d@." n;
  let e' = f e in
  if e = e' then e else
  iter f e'

let rec lifting e = 
  iter lifting_furmula (lifting_fun (Alpha.f e))
