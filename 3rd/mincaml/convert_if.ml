open Asm

let print = ref false

let rec insert a = function
  | Let((x, t), e, cont) ->
    Let((x, t), e, insert a cont)
  | Ans(e) ->
    (match e with
    | IfEq(b, c, e1, e2) -> Ans(IfEq(b, c, insert a e1, insert a e2))
    | IfLE(b, c, e1, e2) -> Ans(IfLE(b, c, insert a e1, insert a e2))
    | IfGE(b, c, e1, e2) -> Ans(IfGE(b, c, insert a e1, insert a e2))
    | IfFEq(b, c, e1, e2) -> Ans(IfFEq(b, c, insert a e1, insert a e2))
    | IfFLE(b, c, e1, e2) -> Ans(IfFLE(b, c, insert a e1, insert a e2))
    | _ -> Ans(Subst(a, e))
    )




let rec convert = function
  | Let((x, t), e, cont) ->
    let b, e' = 
    (match e with
    | IfEq(a, b, e1, e2) -> true, IfEq(a, b, insert (x, t) (convert e1), insert (x, t) (convert e2))
    | IfLE(a, b, e1, e2) -> true, IfLE(a, b, insert (x, t) (convert e1), insert (x, t) (convert e2))
    | IfGE(a, b, e1, e2) -> true, IfGE(a, b, insert (x, t) (convert e1), insert (x, t) (convert e2))
    | IfFEq(a, b, e1, e2) -> true, IfFEq(a, b, insert (x, t) (convert e1), insert (x, t) (convert e2))
    | IfFLE(a, b, e1, e2) -> true, IfFLE(a, b, insert (x, t) (convert e1), insert (x, t) (convert e2))
    | exp -> false, exp
    )
    in
    if (b) then
      Let((Id.gentmp Type.Unit, Type.Unit), e', convert cont)
    else 
      Let((x, t), e', convert cont)
  | Ans(e) -> 
    let e' = 
    (match e with
    | IfEq(a, b, e1, e2) -> IfEq(a, b, convert e1, convert e2)
    | IfLE(a, b, e1, e2) -> IfLE(a, b, convert e1, convert e2)
    | IfGE(a, b, e1, e2) -> IfGE(a, b, convert e1, convert e2)
    | IfFEq(a, b, e1, e2) -> IfFEq(a, b, convert e1, convert e2)
    | IfFLE(a, b, e1, e2) -> IfFLE(a, b, convert e1, convert e2)
    | exp -> exp
    )
    in Ans(e')


let rec convert_fun { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t } =
  { name = Id.L(x); args = ys; fargs = zs; body = convert e; ret = t }

let rec f (Prog(data, fundefs, e)) =
  let e = convert e in
  let fundefs = List.map convert_fun fundefs in
  if (!print) then (
    Printf.printf "Prog after convert_if\n";
    List.iter (fun f -> print_newline (); print_fundef f) fundefs;
    print_newline ();
    print_t 1 e
  );
  Prog(data, fundefs, e)
