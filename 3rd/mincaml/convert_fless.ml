open Syntax 


let rec f exp =
  match exp with
  | Unit(d) -> Unit(d) 
  | Bool(b, d) -> Bool(b, d)
  | Int(i, d) -> Int(i, d)
  | Float(fl, d) -> Float(fl, d)
  | Not(b, d) -> Not(f b, d)
  | Neg(b, d) -> Neg(f b, d)
  | Add(a, b, d) -> Add(f a, f b, d)
  | Sub(a, b, d) -> Sub(f a, f b, d)
  | FNeg(a, d) -> FNeg(f a, d)
  | FAdd(a, b, d) -> FAdd(f a, f b, d)
  | FSub(a, b, d) -> FSub(f a, f b, d)
  | FMul(a, b, d) -> FMul(f a, f b, d)
  | FDiv(a, b, d) -> FDiv(f a, f b, d)
  | Eq(a, b, d) -> Eq(f a, f b, d)
  | LE(a, b, d) -> LE(f a, f b, d)
  | If(a, e1, e2, d) -> If(f a, f e1, f e2, d)
  | Let((x, t), e1, e2, d) ->
    Let((x, t), f e1, f e2, d)
  | Var(t, d) -> Var(t, d)
  | LetRec({ name = (x, t); args = xs; body = e1; deb = deb }, e2, d) as exp ->
    if x = "fless" then
      exp
    else
      (
      LetRec({ name = (x, t); args = xs; body = f e1; deb = deb }, f e2, d)
      )
  | App(f, xs, d) ->
    if varname f = Some "fless" then
      Not(LE(List.hd (List.tl xs), List.hd xs, d), d)
    else
      App(f, xs, d)
  | Tuple(xs, d) -> 
    Tuple(List.map f xs, d)
  | LetTuple(xts, e1, e2, d) ->
    LetTuple(xts, f e1, f e2, d)
  | Array(a, b, d) -> Array(f a, f b, d)
  | Get(a, b, d) -> Get(f a, f b, d)
  | Put(a, b, c, d) -> Put(f a, f b, f c, d)
  | Sll(a, b, d) -> Sll(f a, f b, d)
  | Srl(a, b, d) -> Srl(f a, f b, d)
  | Sra(a, b, d) -> Sra(f a, f b, d)
  | _ -> failwith("something went wrong")

