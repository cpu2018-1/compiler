open Asm

let print = ref false

let rec g env aenv = function
  | Ans(exp) -> Ans(g' env aenv exp)
  | Let((x, t), Li(i), e) when -32768 <= i && i < 32768 ->
      (* Format.eprintf "found simm16 %s = %d@." x i; *)
      let e' = g (M.add x i env) aenv e in
      if List.mem x (fv e') then Let((x, t), Li(i), e') else
      ((* Format.eprintf "erased redundant Set to %s@." x; *)
       e')
  | Let((x, t), SetGlb(Id.L(a)), e) ->
      let e' = g env (M.add x a aenv) e in
      if List.mem x (fv e') then Let((x, t), SetGlb(Id.L(a)), e') else e'
  | Let(xt, exp, e) -> Let(xt, g' env aenv exp, g env aenv e)

and g' env aenv = function (* 各命令の16bit即値最適化 (caml2html: simm13_gprime) *)
  | Lw(x, V(y)) when M.mem x aenv && M.mem y env -> Lw(Asm.reg_zero, C(M.find (M.find x aenv) Glbarray.table + M.find y env))
  | Sw(x, y, V(z)) when M.mem y aenv && M.mem z env -> Sw(x, Asm.reg_zero, C(M.find (M.find y aenv) Glbarray.table + M.find z env))
  | FLw(x, V(y)) when M.mem x aenv && M.mem y env -> FLw(Asm.reg_zero, C(M.find (M.find x aenv) Glbarray.table + M.find y env))
  | FSw(x, y, V(z)) when M.mem y aenv && M.mem z env -> FSw(x, Asm.reg_zero, C(M.find (M.find y aenv) Glbarray.table + M.find z env))
  | IfEq(x, y', e1, e2) -> IfEq(x, y', g env aenv e1, g env aenv e2)
  | IfLE(x, y', e1, e2) -> IfLE(x, y', g env aenv e1, g env aenv e2)
  | IfGE(x, y', e1, e2) -> IfGE(x, y', g env aenv e1, g env aenv e2)
  | IfFEq(x', y', e1, e2) -> IfFEq(x', y', g env aenv e1, g env aenv e2)
  | IfFLE(x', y', e1, e2) -> IfFLE(x', y', g env aenv e1, g env aenv e2)
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
