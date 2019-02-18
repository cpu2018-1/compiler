open KNormal

let rec g env exp =
  match exp with
  | LetRec({ name = (x, t); args = xs; body = e1}, e2) ->
    LetRec({ name = (x, t); args = xs; body = g env e1}, g (S.add x env) e2)
  | Let((x, t), e1, e2) -> 
    Let((x, t), g' env e1, g env e2)
  | _ -> g' env exp
and 
g' env exp =
  match exp with
  | IfEq(x, y, e1, e2) ->
    IfEq(x, y, g env e1, g env e2)
  | IfLE(x, y, e1, e2) ->
    IfLE(x, y, g env e1, g env e2)
  | ExtFunApp(x, xs) ->
    if S.mem x env then
      ExtFunApp(x, xs)
    else
      (match x with
      | "fneg" -> FNeg(List.hd xs)
      | "sqrt" -> FSqrt(List.hd xs)
      | "asm_in" -> In(List.hd xs)
      | "asm_out" -> Out(List.hd xs)
      | "asm_ftoi" -> FtoI(List.hd xs)
      | "asm_itof" -> ItoF(List.hd xs)
      (*
      | "create_array" -> 
      *)
      | _ -> ExtFunApp(x, xs)
      )
  | _ -> exp
      
let f e = g S.empty (Assoc.f e)
