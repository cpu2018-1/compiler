open Asm

let rec g env = function (* ̿�����16bit¨�ͺ�Ŭ�� (caml2html: simm13_g) *)
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), Li(i), e) when -32768 <= i && i < 32768 ->
      (* Format.eprintf "found simm16 %s = %d@." x i; *)
      let e' = g (M.add x i env) e in
      if List.mem x (fv e') then Let((x, t), Li(i), e') else
      ((* Format.eprintf "erased redundant Set to %s@." x; *)
       e')
  | Let(xt, Sll(y, C(i)), e) when M.mem y env -> (* for array access *)
      (* Format.eprintf "erased redundant Sll on %s@." x; *)
      g env (Let(xt, Li((M.find y env) lsl i), e))
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
and g' env = function (* ��̿���16bit¨�ͺ�Ŭ�� (caml2html: simm13_gprime) *)
  | Add(x, V(y)) when M.mem y env -> Add(x, C(M.find y env))
  | Add(x, V(y)) when M.mem x env -> Add(y, C(M.find x env))
  | Sub(x, V(y)) when M.mem y env && M.find y env != -32768 -> Sub(x, C(M.find y env))
  | Lwz(x, V(y)) when M.mem y env -> Lwz(x, C(M.find y env))
  | Stw(x, y, V(z)) when M.mem z env -> Stw(x, y, C(M.find z env))
  | FLw(x, V(y)) when M.mem y env -> FLw(x, C(M.find y env))
  | FSw(x, y, V(z)) when M.mem z env -> FSw(x, y, C(M.find z env))
  | IfEq(x, V(y), e1, e2) when M.mem y env && -16 <= M.find y env && M.find y env < 16 -> IfEq(x, C(M.find y env), g env e1, g env e2)
  | IfEq(x, V(y), e1, e2) -> IfEq(x, V(y), g env e1, g env e2)
  | IfLE(x, V(y), e1, e2) when M.mem y env && -16 <= M.find y env && M.find y env < 16 -> IfLE(x, C(M.find y env), g env e1, g env e2)
  | IfLE(x, V(y), e1, e2) -> IfLE(x, V(y), g env e1, g env e2)
  | IfGE(x, V(y), e1, e2) when M.mem y env && -16 <= M.find y env && M.find y env < 16 -> IfGE(x, C(M.find y env), g env e1, g env e2)
  | IfGE(x, V(y), e1, e2) -> IfGE(x, V(y), g env e1, g env e2)
  | IfEq(x, y', e1, e2) -> IfEq(x, y', g env e1, g env e2)
  | IfLE(x, y', e1, e2) -> IfLE(x, y', g env e1, g env e2)
  | IfGE(x, y', e1, e2) -> IfGE(x, y', g env e1, g env e2)
  | IfFEq(x, y, e1, e2) -> IfFEq(x, y, g env e1, g env e2)
  | IfFLE(x, y, e1, e2) -> IfFLE(x, y, g env e1, g env e2)
  | Sll(x, V(y)) when M.mem y env -> Sll(x, C(M.find y env))
  | Srl(x, V(y)) when M.mem y env -> Srl(x, C(M.find y env))
  | Sra(x, V(y)) when M.mem y env -> Sra(x, C(M.find y env))
  | e -> e

let h { name = l; args = xs; fargs = ys; body = e; ret = t } = (* �ȥåץ�٥�ؿ���16bit¨�ͺ�Ŭ�� *)
  { name = l; args = xs; fargs = ys; body = g M.empty e; ret = t }

let f (Prog(data, fundefs, e)) = (* �ץ�������Τ�16bit¨�ͺ�Ŭ�� *)
  Prog(data, List.map h fundefs, g M.empty e)
