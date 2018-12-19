open Num_asm

let rec find f fundefs =
  match fundefs with
  | [] -> false, Type.Unit
  | { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t } :: xs ->
    print_endline x;
    if Id.L(x) = f then
      true, t
    else
      find f xs

let rec convert fundefs e =
  match e with
  | Let((x, t), e', i, cont) ->
    (match e' with
    | IfEq(x, y', e1, e2) -> Let((x, t), IfEq(x, y', convert fundefs e1, convert fundefs e2), i, convert fundefs cont)
    | IfLE(x, y', e1, e2) -> Let((x, t), IfLE(x, y', convert fundefs e1, convert fundefs e2), i, convert fundefs cont)
    | IfGE(x, y', e1, e2) -> Let((x, t), IfGE(x, y', convert fundefs e1, convert fundefs e2), i, convert fundefs cont)
    | IfFEq(x', y', e1, e2) -> Let((x, t), IfFEq(x', y', convert fundefs e1, convert fundefs e2), i, convert fundefs cont)
    | IfFLE(x', y', e1, e2) -> Let((x, t), IfFLE(x', y', convert fundefs e1, convert fundefs e2), i, convert fundefs cont)
    | _ -> Let((x, t), e', i, convert fundefs cont)
    )
  | Ans(e', i) ->
    (match e' with
    | CallDir(x, ys, zs) -> 
      (match find x fundefs with
      | false, _ -> Ans(e', i)
      | _, Type.Float -> let y = Id.gentmp Type.Float in Let((y, Type.Float), e', i, Ans(FMr(y), (incr counter; !counter)))
      | _, t -> let y = Id.gentmp t in Let((y, t), e', i, Ans(Mr(y), (incr counter; !counter)))
      ) 
    | IfEq(x, y', e1, e2) -> Ans(IfEq(x, y', convert fundefs e1, convert fundefs e2), i)
    | IfLE(x, y', e1, e2) -> Ans(IfLE(x, y', convert fundefs e1, convert fundefs e2), i)
    | IfGE(x, y', e1, e2) -> Ans(IfGE(x, y', convert fundefs e1, convert fundefs e2), i)
    | IfFEq(x', y', e1, e2) -> Ans(IfFEq(x', y', convert fundefs e1, convert fundefs e2), i)
    | IfFLE(x', y', e1, e2) -> Ans(IfFLE(x', y', convert fundefs e1, convert fundefs e2), i)
    | _ -> Ans(e', i)
    )


let convert_fun fundefs { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t } =
  { name = Id.L(x); args = ys; fargs = zs; body = convert fundefs e; ret = t }


let main (Prog(data, fundefs, e)) =
  Prog(data, List.map (convert_fun fundefs) fundefs, convert fundefs e)
