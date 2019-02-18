type closure = { entry : Id.l; actual_fv : Id.t list }
type t = (* クロージャ変換後の式 (caml2html: closure_t) *)
  | Unit
  | Int of int
  | Float of float
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | IfEq of Id.t * Id.t * t * t
  | IfLE of Id.t * Id.t * t * t
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | MakeCls of (Id.t * Type.t) * closure * t
  | AppCls of Id.t * Id.t list
  | AppDir of Id.l * Id.t list
  | Tuple of Id.t list
  | LetTuple of (Id.t * Type.t) list * Id.t * t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.l
  | Sll of Id.t * Id.t
  | Srl of Id.t * Id.t
  | Sra of Id.t * Id.t
  | In of Id.t
  | Out of Id.t
  | FSqrt of Id.t
  | FtoI of Id.t
  | ItoF of Id.t
  | HP 
  | FHP 
  | Incr_hp
  | Store_hp of Id.t
  | FStore_hp of Id.t
type fundef = { name : Id.l * Type.t;
                args : (Id.t * Type.t) list;
                formal_fv : (Id.t * Type.t) list;
                body : t }
type prog = Prog of fundef list * t

let rec fv = function
  | Unit | Int(_) | Float(_) | ExtArray(_) | HP | FHP | Incr_hp -> S.empty
  | Neg(x) | FNeg(x) | In(x) | Out(x) | FSqrt(x) | FtoI(x) | ItoF(x) | Store_hp(x) | FStore_hp(x) -> S.singleton x
  | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | Get(x, y) | Sll(x, y) | Srl(x, y) | Sra(x, y) -> S.of_list [x; y]
  | IfEq(x, y, e1, e2)| IfLE(x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let((x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | MakeCls((x, t), { entry = l; actual_fv = ys }, e) -> S.remove x (S.union (S.of_list ys) (fv e))
  | AppCls(x, ys) -> S.of_list (x :: ys)
  | AppDir(_, xs) | Tuple(xs) -> S.of_list xs
  | LetTuple(xts, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xts)))
  | Put(x, y, z) -> S.of_list [x; y; z]

let toplevel : fundef list ref = ref []

let rec g env known = function (* クロージャ変換ルーチン本体 (caml2html: closure_g) *)
  | KNormal.Unit -> Unit
  | KNormal.Int(i) -> Int(i)
  | KNormal.Float(d) -> Float(d)
  | KNormal.Neg(x) -> Neg(x)
  | KNormal.Add(x, y) -> Add(x, y)
  | KNormal.Sub(x, y) -> Sub(x, y)
  | KNormal.FNeg(x) -> FNeg(x)
  | KNormal.FAdd(x, y) -> FAdd(x, y)
  | KNormal.FSub(x, y) -> FSub(x, y)
  | KNormal.FMul(x, y) -> FMul(x, y)
  | KNormal.FDiv(x, y) -> FDiv(x, y)
  | KNormal.IfEq(x, y, e1, e2) -> IfEq(x, y, g env known e1, g env known e2)
  | KNormal.IfLE(x, y, e1, e2) -> IfLE(x, y, g env known e1, g env known e2)
  | KNormal.Let((x, t), e1, e2) -> Let((x, t), g env known e1, g (M.add x t env) known e2)
  | KNormal.Var(x) -> Var(x)
  | KNormal.LetRec({ KNormal.name = (x, t); KNormal.args = yts; KNormal.body = e1 }, e2) -> (* 関数定義の場合 (caml2html: closure_letrec) *)
      (* 関数定義let rec x y1 ... yn = e1 in e2の場合は、
         xに自由変数がない(closureを介さずdirectに呼び出せる)
         と仮定し、knownに追加してe1をクロージャ変換してみる *)
      let toplevel_backup = !toplevel in
      let env' = M.add x t env in
      let known' = S.add x known in
      let e1' = g (M.add_list yts env') known' e1 in
      (* 本当に自由変数がなかったか、変換結果e1'を確認する *)
      (* 注意: e1'にx自身が変数として出現する場合はclosureが必要!
         (thanks to nuevo-namasute and azounoman; test/cls-bug2.ml参照) *)
      let zs = S.diff (fv e1') (S.of_list (List.map fst yts)) in
      let known', e1' =
        if S.is_empty zs then known', e1' else
        (* 駄目だったら状態(toplevelの値)を戻して、クロージャ変換をやり直す *)
        (Format.eprintf "free variable(s) %s found in function %s@." (Id.pp_list (S.elements zs)) x;
         Format.eprintf "function %s cannot be directly applied in fact@." x;
         toplevel := toplevel_backup;
         let e1' = g (M.add_list yts env') known e1 in
         known, e1') in
      let zs = S.elements (S.diff (fv e1') (S.add x (S.of_list (List.map fst yts)))) in (* 自由変数のリスト *)
      let zts = List.map (fun z -> print_endline ("attempt to find "^z); (z, M.find z env')) zs in (* ここで自由変数zの型を引くために引数envが必要 *)
      toplevel := { name = (Id.L(x), t); args = yts; formal_fv = zts; body = e1' } :: !toplevel; (* トップレベル関数を追加 *)
      let e2' = g env' known' e2 in
      if S.mem x (fv e2') then (* xが変数としてe2'に出現するか *)
        (Format.eprintf "create closure(s) %s@." x;
        MakeCls((x, t), { entry = Id.L(x); actual_fv = zs }, e2') (* 出現していたら削除しない *))
      else
        (Format.eprintf "eliminating closure(s) %s@." x;
         e2') (* 出現しなければMakeClsを削除 *)
  | KNormal.App(x, ys) when S.mem x known -> (* 関数適用の場合 (caml2html: closure_app) *)
      Format.eprintf "directly applying %s@." x;
      AppDir(Id.L(x), ys)
  | KNormal.App(f, xs) -> AppCls(f, xs)
  | KNormal.Tuple(xs) -> Tuple(xs)
  | KNormal.LetTuple(xts, y, e) -> LetTuple(xts, y, g (M.add_list xts env) known e)
  | KNormal.Get(x, y) -> Get(x, y)
  | KNormal.Put(x, y, z) -> Put(x, y, z)
  | KNormal.ExtArray(x) -> ExtArray(Id.L(x))
  | KNormal.ExtFunApp(x, ys) -> AppDir(Id.L("lib_"^x), ys)
  | KNormal.Sll(x, y) -> Sll(x, y)
  | KNormal.Srl(x, y) -> Srl(x, y)
  | KNormal.Sra(x, y) -> Sra(x, y)
  | KNormal.In(x) -> In(x)
  | KNormal.Out(x) -> Out(x)
  | KNormal.FSqrt(x) -> FSqrt(x)
  | KNormal.FtoI(x) -> FtoI(x)
  | KNormal.ItoF(x) -> ItoF(x)
  | KNormal.HP -> HP
  | KNormal.FHP -> FHP
  | KNormal.Incr_hp -> Incr_hp
  | KNormal.Store_hp(x) -> Store_hp(x)
  | KNormal.FStore_hp(x) -> FStore_hp(x)

let rec print_indent n =
  if n = 0 then
    ()
  else (
    print_string ". "; print_indent (n - 1)
  )



let print_space () = print_string " "


let rec print_closure_sub t i =
  print_indent i;
  match t with
  | Unit -> print_string "()"; print_newline ()
  | Int n -> print_string "INT"; print_space (); print_int n; print_newline ()
  | Float f -> print_string "FLOAT"; print_space (); print_float f; print_newline ()
  | Neg n -> print_string "NEG"; Id.print_id n; print_newline ()
  | Add (n, m) -> print_string "ADD"; print_space (); Id.print_id n; print_space (); Id.print_id m; print_newline ()
  | Sub (n, m) -> print_string "SUB"; print_space (); Id.print_id n; print_space (); Id.print_id m; print_newline ()
  | FNeg f -> print_string "FNEG"; print_space (); Id.print_id f; print_newline ()
  | FAdd (f, g) -> print_string "FADD"; print_space (); Id.print_id f; print_space (); Id.print_id g; print_newline ()
  | FSub (f, g) -> print_string "FSUB"; print_space (); Id.print_id f; print_space (); Id.print_id g; print_newline ()
  | FMul (f, g) -> print_string "FMUL"; print_space (); Id.print_id f; print_space (); Id.print_id g; print_newline ()
  | FDiv (f, g) -> print_string "FDIV"; print_space (); Id.print_id f; print_space (); Id.print_id g; print_newline ()
  | IfEq (x, y, a, b) -> print_endline "IFEQ"; 
                print_indent (i + 1); Id.print_id x; print_newline ();
                print_indent (i + 1); Id.print_id y; print_newline ();
                print_indent i; print_endline "THEN";
                print_closure_sub a (i + 1);
                print_indent i; print_endline "ELSE";
                print_closure_sub b (i + 1)
  | IfLE (x, y, a, b) -> print_endline "IFLE"; 
                print_indent (i + 1); Id.print_id x; print_newline ();
                print_indent (i + 1); Id.print_id y; print_newline ();
                print_indent i; print_endline "THEN";
                print_closure_sub a (i + 1);
                print_indent i; print_endline "ELSE";
                print_closure_sub b (i + 1)
  | Let ((x, a), t1, t2) -> print_endline "LET";
                            print_indent (i + 1); print_endline ("(" ^ x ^ ", " ^ (Typing.sprint_type a) ^ ") = ");
                            print_closure_sub t1 (i + 2);
                            print_indent (i); print_endline "IN";
                            print_closure_sub t2 (i + 1)
  | Var x -> print_string "VAR"; print_space (); print_string x; print_newline ()
  | MakeCls((x, t), c, e) -> print_endline "MAKECLS";
                            print_indent (i + 1); Id.print_id x; print_newline ()
  | AppCls (t, tl) -> print_endline "APPCLS";
                   print_indent (i + 1);
                   Id.print_id t; print_space ();
                   Id.print_id_list tl " ";
                   print_newline ()
  | AppDir (Id.L(t), tl) -> print_endline "APPDIR";
                   print_indent (i + 1);
                   Id.print_id t; print_space ();
                   Id.print_id_list tl " ";
                   print_newline ()
  | Tuple tl -> print_endline "TUPLE";
                print_indent (i + 1);
                Id.print_id_list tl " ";
                print_newline ()
  | LetTuple (idtyl, t1, t2) -> print_endline "LETTUPLE";
                                print_closure_sub_list (List.map (fun x -> Var (fst x)) idtyl) (i + 1);
                                print_indent (i + 2); Id.print_id t1;
                                print_closure_sub t2 (i + 2)
  | Get (t1, t2) -> print_endline "GET";
                    print_indent (i + 1); Id.print_id t1; print_newline ();
                    print_indent (i + 1); Id.print_id t2; print_newline ()
  | Put (t1, t2, t3) -> print_endline "PUT";
                    print_indent (i + 1); Id.print_id t1; print_newline ();
                    print_indent (i + 1); Id.print_id t2; print_newline ();
                    print_indent (i + 1); Id.print_id t3; print_newline ()
  | ExtArray Id.L(t) -> print_endline "EXTARRAY";
                  Id.print_id t; print_newline ()
  | Sll (n, m) -> print_string "SLL"; print_space (); Id.print_id n; print_space (); Id.print_id m; print_newline ()
  | Srl (n, m) -> print_string "SRL"; print_space (); Id.print_id n; print_space (); Id.print_id m; print_newline ()
  | Sra (n, m) -> print_string "SRA"; print_space (); Id.print_id n; print_space (); Id.print_id m; print_newline ()
  | In n -> print_string "IN"; print_space (); Id.print_id n; print_newline ()
  | Out n -> print_string "OUT"; print_space (); Id.print_id n; print_newline ()
  | FSqrt f -> print_string "FSQRT"; print_space (); Id.print_id f; print_newline ()
  | FtoI f -> print_string "FTOI"; print_space (); Id.print_id f; print_newline ()
  | ItoF n -> print_string "ITOF"; print_space (); Id.print_id n; print_newline ()
  | HP -> print_endline "HP"
  | FHP -> print_endline "FHP"
  | Incr_hp -> print_endline "INCR_HP"
  | Store_hp(x) -> print_string "STORE_HP"; print_space (); Id.print_id x; print_newline ()
  | FStore_hp(x) -> print_string "FSTORE_HP"; print_space (); Id.print_id x; print_newline ()
and 
print_closure_sub_list tl i = 
  List.iter ((fun j x -> print_closure_sub x j) i) tl


let print_closure t =
  print_closure_sub t 0


let f e =
  toplevel := [];
  let e' = g M.empty S.empty e in
  print_endline "closure.ml was done";
  Prog(List.rev !toplevel, e')
