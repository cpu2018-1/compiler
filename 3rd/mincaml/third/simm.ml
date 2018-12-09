open Asm

let print = ref false

let rec g env fenv = function (* 命令列の16bit即値最適化 (caml2html: simm13_g) *)
  | Ans(exp) -> Ans(g' env fenv exp)
  | Let((x, t), Li(i), e) when -32768 <= i && i < 32768 ->
      (* Format.eprintf "found simm16 %s = %d@." x i; *)
      let e' = g (M.add x i env) fenv e in
      if List.mem x (fv e') then Let((x, t), Li(i), e') else
      ((* Format.eprintf "erased redundant Set to %s@." x; *)
       e')
  | Let((x, t), FLi(f), e) when f = 0.0 ->
      (* Format.eprintf "found simm16 %s = %d@." x i; *)
      let e' = g  env (M.add x f fenv) e in
      if List.mem x (fv e') then Let((x, t), FLi(f), e') else
      ((* Format.eprintf "erased redundant Set to %s@." x; *)
       e')
  | Let(xt, Sll(y, C(i)), e) when M.mem y env -> (* for array access *)
      (* Format.eprintf "erased redundant Sll on %s@." x; *)
      g env fenv (Let(xt, Li((M.find y env) lsl i), e))
  | Let(xt, exp, e) -> Let(xt, g' env fenv exp, g env fenv e)
and g' env fenv = function (* 各命令の16bit即値最適化 (caml2html: simm13_gprime) *)
  | Add(x, V(y)) when M.mem y env -> Add(x, C(M.find y env))
  | Add(x, V(y)) when M.mem x env -> Add(y, C(M.find x env))
  | Sub(x, V(y)) when M.mem y env && M.find y env != -32768 -> Sub(x, C(M.find y env))
  | Lwz(x, V(y)) when M.mem y env -> Lwz(x, C(M.find y env))
  | Stw(x, y, V(z)) when M.mem z env -> Stw(x, y, C(M.find z env))
  | FLw(x, V(y)) when M.mem y env -> FLw(x, C(M.find y env))
  | FSw(x, y, V(z)) when M.mem z env -> FSw(x, y, C(M.find z env))
  | IfEq(x, V(y), e1, e2) when M.mem y env && -16 <= M.find y env && M.find y env < 16 -> IfEq(x, C(M.find y env), g env fenv e1, g env fenv e2)
  | IfEq(x, V(y), e1, e2) when M.mem x env && -16 <= M.find x env && M.find x env < 16 -> IfEq(y, C(M.find x env), g env fenv e1, g env fenv e2)
  | IfEq(x, V(y), e1, e2) -> IfEq(x, V(y), g env fenv e1, g env fenv e2)
  | IfLE(x, V(y), e1, e2) when M.mem y env && -16 <= M.find y env && M.find y env < 16 -> IfLE(x, C(M.find y env), g env fenv e1, g env fenv e2)
  | IfLE(x, V(y), e1, e2) -> IfLE(x, V(y), g env fenv e1, g env fenv e2)
  | IfGE(x, V(y), e1, e2) when M.mem y env && -16 <= M.find y env && M.find y env < 16 -> IfGE(x, C(M.find y env), g env fenv e1, g env fenv e2)
  | IfGE(x, V(y), e1, e2) -> IfGE(x, V(y), g env fenv e1, g env fenv e2)
  | IfEq(x, y', e1, e2) -> IfEq(x, y', g env fenv e1, g env fenv e2)
  | IfLE(x, y', e1, e2) -> IfLE(x, y', g env fenv e1, g env fenv e2)
  | IfGE(x, y', e1, e2) -> IfGE(x, y', g env fenv e1, g env fenv e2)
  | IfFEq(V(x), y, e1, e2) when M.mem x fenv -> g' env fenv (IfFEq(FC(M.find x fenv), y, e1, e2))
  | IfFLE(V(x), y, e1, e2) when M.mem x fenv -> g' env fenv (IfFLE(FC(M.find x fenv), y, e1, e2))
  | IfFEq(x', V(y), e1, e2) when M.mem y fenv -> IfFEq(x', FC(M.find y fenv), g env fenv e1, g env fenv e2)
  | IfFLE(x', V(y), e1, e2) when M.mem y fenv -> IfFLE(x', FC(M.find y fenv), g env fenv e1, g env fenv e2)
  | IfFEq(x', y', e1, e2) -> IfFEq(x', y', g env fenv e1, g env fenv e2)
  | IfFLE(x', y', e1, e2) -> IfFLE(x', y', g env fenv e1, g env fenv e2)
  | Sll(x, V(y)) when M.mem y env -> Sll(x, C(M.find y env))
  | Srl(x, V(y)) when M.mem y env -> Srl(x, C(M.find y env))
  | Sra(x, V(y)) when M.mem y env -> Sra(x, C(M.find y env))
  | e -> e

let h { name = l; args = xs; fargs = ys; body = e; ret = t } = (* トップレベル関数の16bit即値最適化 *)
  { name = l; args = xs; fargs = ys; body = g M.empty M.empty e; ret = t }

let f (Prog(data, fundefs, e)) = (* プログラム全体の16bit即値最適化 *)
  let fundefs = List.map h fundefs in
  let e = g M.empty M.empty e in
  (if (!print) then (
    Printf.printf ("Prog after simm\n");
    List.iter (fun f -> print_newline (); Asm.print_fundef f) fundefs;
    print_newline ();
    Asm.print_t 1 e
  )
  else ()
  )
  ;
  Prog(data, fundefs, e)
