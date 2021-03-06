open KNormal




let is_small e =
  match e with
  | Add(_, _)  | Sub(_, _)  | Neg _ 
  | FAdd(_, _) | FSub(_, _) | FMul(_, _) | FDiv(_, _) | FNeg _ -> true
  | _ -> false

let comp_formula e ex =
  e = ex

let rec search e l =
  match l with
  | [] -> e
  | (x, ex) :: ls ->
    if (comp_formula e ex) then
      (Var x)
    else
      search e ls
  
let rec elm e forml_env =
  match e with
  | IfEq(x, y, e1, e2) -> IfEq(x, y, elm e1 forml_env, elm e2 forml_env)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, elm e1 forml_env, elm e2 forml_env)
  | Let ((x, t), e1, e2) -> 
      Let ((x, t), 
           (elm e1 forml_env), 
           (elm e2 ((if (is_small e1) then [(x, e1)] else []) @ (forml_env)))
          )
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) -> 
      LetRec({ name = (x, t); args = yts; body = (elm e1 forml_env) },
               elm e2 forml_env) 
  | LetTuple(xts, y, e) -> LetTuple(xts, y, elm e forml_env)
  | e -> search e forml_env


let commelm e =
  elm e []
