(* give names to intermediate values (K-normalization) *)

type t = (* K正規化後の式 (caml2html: knormal_t) *)
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
  | IfEq of Id.t * Id.t * t * t (* 比較 + 分岐 (caml2html: knormal_branch) *)
  | IfLE of Id.t * Id.t * t * t (* 比較 + 分岐 *)
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | LetRec of fundef * t
  | App of Id.t * Id.t list
  | Tuple of Id.t list
  | LetTuple of (Id.t * Type.t) list * Id.t * t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.t
  | ExtFunApp of Id.t * Id.t list
<<<<<<< HEAD
  | Sll of Id.t * Id.t
  | Srl of Id.t * Id.t
  | Sra of Id.t * Id.t
=======
>>>>>>> 61ac9c2cc2f4e8691b9c56204d8674ef40355a1e
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

let rec fv = function (* 式に出現する（自由な）変数 (caml2html: knormal_fv) *)
  | Unit | Int(_) | Float(_) | ExtArray(_) -> S.empty
  | Neg(x) | FNeg(x) -> S.singleton x
<<<<<<< HEAD
  | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | Get(x, y) | Sll(x, y) | Srl(x, y) | Sra(x, y) -> S.of_list [x; y]
=======
  | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | Get(x, y) -> S.of_list [x; y]
>>>>>>> 61ac9c2cc2f4e8691b9c56204d8674ef40355a1e
  | IfEq(x, y, e1, e2) | IfLE(x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let((x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
      let zs = S.diff (fv e1) (S.of_list (List.map fst yts)) in
      S.diff (S.union zs (fv e2)) (S.singleton x)
  | App(x, ys) -> S.of_list (x :: ys)
  | Tuple(xs) | ExtFunApp(_, xs) -> S.of_list xs
  | Put(x, y, z) -> S.of_list [x; y; z]
  | LetTuple(xs, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xs)))

let insert_let (e, t) k = (* letを挿入する補助関数 (caml2html: knormal_insert) *)
  match e with
  | Var(x) -> k x
  | _ ->
      let x = Id.gentmp t in
      let e', t' = k x in
      Let((x, t), e, e'), t'

let rec g env t=(*= function (* K正規化ルーチン本体 (caml2html: knormal_g) *)*)
(*
print_string "hoge!\n";
Syntax.print_syntax t;
*)
match t with
  | Syntax.Unit(d) -> Unit, Type.Unit
  | Syntax.Bool(b, d) -> Int(if b then 1 else 0), Type.Int (* 論理値true, falseを整数1, 0に変換 (caml2html: knormal_bool) *)
  | Syntax.Int(i, d) -> Int(i), Type.Int
  | Syntax.Float(d, d2) -> Float(d), Type.Float
  | Syntax.Not(e, d) -> g env (Syntax.If(e, Syntax.Bool(false, d), Syntax.Bool(true, d), d))
  | Syntax.Neg(e, d) ->
      insert_let (g env e)
        (fun x -> Neg(x), Type.Int)
  | Syntax.Add(e1, e2, d) -> (* 足し算のK正規化 (caml2html: knormal_add) *)
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Add(x, y), Type.Int))
  | Syntax.Sub(e1, e2, d) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Sub(x, y), Type.Int))
  | Syntax.FNeg(e, d) ->
      insert_let (g env e)
        (fun x -> FNeg(x), Type.Float)
  | Syntax.FAdd(e1, e2, d) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FAdd(x, y), Type.Float))
  | Syntax.FSub(e1, e2, d) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FSub(x, y), Type.Float))
  | Syntax.FMul(e1, e2, d) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FMul(x, y), Type.Float))
  | Syntax.FDiv(e1, e2, d) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FDiv(x, y), Type.Float))
  | Syntax.Eq(_, _, d) | Syntax.LE(_, _, d) as cmp ->
      g env (Syntax.If(cmp, Syntax.Bool(true, d), Syntax.Bool(false, d), d))
  | Syntax.If(Syntax.Not(e1, _), e2, e3, d) -> g env (Syntax.If(e1, e3, e2, d)) (* notによる分岐を変換 (caml2html: knormal_not) *)
  | Syntax.If(Syntax.Eq(e1, e2, _), e3, e4, d) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y ->
              let e3', t3 = g env e3 in
              let e4', t4 = g env e4 in
              IfEq(x, y, e3', e4'), t3))
  | Syntax.If(Syntax.LE(e1, e2, _), e3, e4, d) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y ->
              let e3', t3 = g env e3 in
              let e4', t4 = g env e4 in
              IfLE(x, y, e3', e4'), t3))
  | Syntax.If(e1, e2, e3, d) -> g env (Syntax.If(Syntax.Eq(e1, Syntax.Bool(false, d), d), e3, e2, d)) (* 比較のない分岐を変換 (caml2html: knormal_if) *)
  | Syntax.Let((x, t), e1, e2, d) ->
      let e1', t1 = g env e1 in
      let e2', t2 = g (M.add x t env) e2 in
      Let((x, t), e1', e2'), t2
  | Syntax.Var(x, d) when M.mem x env -> Var(x), M.find x env
  | Syntax.Var(x, d) -> (* 外部配列の参照 (caml2html: knormal_extarray) *)
      (match M.find x !Typing.extenv with
      | Type.Array(_) as t -> ExtArray x, t
      | _ -> failwith (Printf.sprintf "external variable %s does not have an array type" x))
  | Syntax.LetRec({ Syntax.name = (x, t); Syntax.args = yts; Syntax.body = e1; Syntax.deb = d }, e2, d2) ->
      let env' = M.add x t env in
      let e2', t2 = g env' e2 in
      let e1', t1 = g (M.add_list yts env') e1 in
      LetRec({ name = (x, t); args = yts; body = e1' }, e2'), t2
  | Syntax.App(Syntax.Var(f, _), e2s, d) when not (M.mem f env) -> (* 外部関数の呼び出し (caml2html: knormal_extfunapp) *)
      (match M.find f !Typing.extenv with
      | Type.Fun(_, t) ->
          let rec bind xs = function (* "xs" are identifiers for the arguments *)
            | [] -> ExtFunApp(f, xs), t
            | e2 :: e2s ->
                insert_let (g env e2)
                  (fun x -> bind (xs @ [x]) e2s) in
          bind [] e2s (* left-to-right evaluation *)
      | _ -> assert false)
  | Syntax.App(e1, e2s, d) ->
      (match g env e1 with
      | _, Type.Fun(_, t) as g_e1 ->
          insert_let g_e1
            (fun f ->
              let rec bind xs = function (* "xs" are identifiers for the arguments *)
                | [] -> App(f, xs), t
                | e2 :: e2s ->
                    insert_let (g env e2)
                      (fun x -> bind (xs @ [x]) e2s) in
              bind [] e2s) (* left-to-right evaluation *)
      | _ -> assert false)
  | Syntax.Tuple(es, d) ->
      let rec bind xs ts = function (* "xs" and "ts" are identifiers and types for the elements *)
        | [] -> Tuple(xs), Type.Tuple(ts)
        | e :: es ->
            let _, t as g_e = g env e in
            insert_let g_e
              (fun x -> bind (xs @ [x]) (ts @ [t]) es) in
      bind [] [] es
  | Syntax.LetTuple(xts, e1, e2, d) ->
      insert_let (g env e1)
        (fun y ->
          let e2', t2 = g (M.add_list xts env) e2 in
          LetTuple(xts, y, e2'), t2)
  | Syntax.Array(e1, e2, d) ->
      insert_let (g env e1)
        (fun x ->
          let _, t2 as g_e2 = g env e2 in
          insert_let g_e2
            (fun y ->
              let l =
                match t2 with
                | Type.Float -> "create_float_array"
                | _ -> "create_array" in
              ExtFunApp(l, [x; y]), Type.Array(t2)))
  | Syntax.Get(e1, e2, d) ->
      (match g env e1 with
      |        _, Type.Array(t) as g_e1 ->
          insert_let g_e1
            (fun x -> insert_let (g env e2)
                (fun y -> Get(x, y), t))
      | _ -> assert false)
  | Syntax.Put(e1, e2, e3, d) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> insert_let (g env e3)
                (fun z -> Put(x, y, z), Type.Unit)))
<<<<<<< HEAD
  | Syntax.Sll(e1, e2, d) -> (* 論理シフト *)
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Sll(x, y), Type.Int))
  | Syntax.Srl(e1, e2, d) -> (* 論理シフト *)
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Srl(x, y), Type.Int))
  | Syntax.Sra(e1, e2, d) -> (* 算術シフト *)
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Sra(x, y), Type.Int))
=======
>>>>>>> 61ac9c2cc2f4e8691b9c56204d8674ef40355a1e

let f e = fst (g M.empty e)





let indent = 2
  
let rec print_indent_sub n =
  if n = 0 then
    ()
  else (
    print_string " "; print_indent_sub (n - 1)
  )

let print_indent n =
  print_indent_sub (indent * n)


let print_space () = print_string " "


let rec print_kNormal_sub t i =
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
                print_kNormal_sub a (i + 1);
                print_indent i; print_endline "ELSE";
                print_kNormal_sub b (i + 1)
  | IfLE (x, y, a, b) -> print_endline "IFLE"; 
                print_indent (i + 1); Id.print_id x; print_newline ();
                print_indent (i + 1); Id.print_id y; print_newline ();
                print_indent i; print_endline "THEN";
                print_kNormal_sub a (i + 1);
                print_indent i; print_endline "ELSE";
                print_kNormal_sub b (i + 1)
  | Let ((x, a), t1, t2) -> print_endline "LET";
                            print_indent (i + 1); print_endline (x ^ " =");
                            print_kNormal_sub t1 (i + 2);
                            print_indent (i + 1); print_endline "IN";
                            print_kNormal_sub t2 (i + 2)
  | Var x -> print_string "VAR"; print_space (); print_string x; print_newline ()
  | LetRec (f, t) -> print_endline "LETREC";
                     print_indent (i + 1); Id.print_id (fst f.name);
                     List.iter (fun x -> print_string " ";
                                         Id.print_id x;
                                         ) (List.map fst (f.args));
                     print_endline " =";
                     print_kNormal_sub f.body (i + 2);
                     print_indent (i + 1); print_endline "IN";
                     print_kNormal_sub t (i + 2)
  | App (t, tl) -> print_endline "APP";
                   print_indent (i + 1);
                   Id.print_id t; print_space ();
                   Id.print_id_list tl " ";
                   print_newline ()
  | Tuple tl -> print_endline "TUPLE";
                print_indent (i + 1);
                Id.print_id_list tl " ";
                print_newline ()
  | LetTuple (idtyl, t1, t2) -> print_endline "LETTUPLE";
                                print_kNormal_sub_list (List.map (fun x -> Var (fst x)) idtyl) (i + 1);
                                print_indent (i + 2); Id.print_id t1;
                                print_kNormal_sub t2 (i + 2)
  | Get (t1, t2) -> print_endline "GET";
                    print_indent (i + 1); Id.print_id t1; print_newline ();
                    print_indent (i + 1); Id.print_id t2; print_newline ()
  | Put (t1, t2, t3) -> print_endline "PUT";
                    print_indent (i + 1); Id.print_id t1; print_newline ();
                    print_indent (i + 1); Id.print_id t2; print_newline ();
                    print_indent (i + 1); Id.print_id t3; print_newline ()
  | ExtArray t -> print_endline "EXTARRAY";
                  Id.print_id t; print_newline ()
  | ExtFunApp (t, tl) -> print_endline "EXTFUNAPP";
                         print_indent (i + 1); Id.print_id t; print_newline ();
                         print_indent (i + 1); Id.print_id_list tl " "; print_newline ()
and 
print_kNormal_sub_list tl i = 
  List.iter ((fun j x -> print_kNormal_sub x j) i) tl



let print_kNormal t =
  print_kNormal_sub t 0

