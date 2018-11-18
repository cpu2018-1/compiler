(* type inference/reconstruction *)

open Syntax

exception Unify of Type.t * Type.t * debug
exception Error of t * Type.t * Type.t

let extenv = ref M.empty

(* for pretty printing (and type normalization) *)

(* 部分適用のために作ったが，不要(むしろ邪魔)でした
let rec uncurrying = function
  | Type.Fun(t1s, t2) -> 
    (match t2 with
     | Type.Fun(t1s', t2') -> uncurrying (Type.Fun(t1s @ t1s', t2'))
     | Type.Tuple(ts) -> Type.Tuple(List.map uncurrying ts)
     | Type.Array(t) -> Type.Array(uncurrying t)
     | t -> (Type.Fun(t1s, t2))
    )
  | Type.Tuple(ts) -> Type.Tuple(List.map uncurrying ts)
  | Type.Array(t) -> Type.Array(uncurrying t)
  | t -> t
*)

let rec deref_typ = function (* 型変数を中身でおきかえる関数 (caml2html: typing_deref) *)
  | Type.Fun(t1s, t2) -> Type.Fun(List.map deref_typ t1s, deref_typ t2)
  | Type.Tuple(ts) -> Type.Tuple(List.map deref_typ ts)
  | Type.Array(t) -> Type.Array(deref_typ t)
  | Type.Var({ contents = None } as r) ->
      Format.eprintf "uninstantiated type variable detected; assuming int@.";
      r := Some(Type.Int);
      Type.Int
  | Type.Var({ contents = Some(t) } as r) ->
      let t' = deref_typ t in
      r := Some(t');
      t'
  | t -> t
let rec deref_id_typ (x, t) = (x, deref_typ t)
let rec deref_term = function
  | Not(e, d) -> Not(deref_term e, d)
  | Neg(e, d) -> Neg(deref_term e, d)
  | Add(e1, e2, d) -> Add(deref_term e1, deref_term e2, d)
  | Sub(e1, e2, d) -> Sub(deref_term e1, deref_term e2, d)
  | Eq(e1, e2, d) -> Eq(deref_term e1, deref_term e2, d)
  | LE(e1, e2, d) -> LE(deref_term e1, deref_term e2, d)
  | FNeg(e, d) -> FNeg(deref_term e, d)
  | FAdd(e1, e2, d) -> FAdd(deref_term e1, deref_term e2, d)
  | FSub(e1, e2, d) -> FSub(deref_term e1, deref_term e2, d)
  | FMul(e1, e2, d) -> FMul(deref_term e1, deref_term e2, d)
  | FDiv(e1, e2, d) -> FDiv(deref_term e1, deref_term e2, d)
  | If(e1, e2, e3, d) -> If(deref_term e1, deref_term e2, deref_term e3, d)
  | Let(xt, e1, e2, d) -> Let(deref_id_typ xt, deref_term e1, deref_term e2, d)
  | LetRec({ name = xt; args = yts; body = e1; deb = d }, e2, d2) ->
      LetRec({ name = deref_id_typ xt;
               args = List.map deref_id_typ yts;
               body = deref_term e1;
               deb = d
             },
             deref_term e2, d2)
  | App(e, es, d) -> App(deref_term e, List.map deref_term es, d)
  | Tuple(es, d) -> Tuple(List.map deref_term es, d)
  | LetTuple(xts, e1, e2, d) -> LetTuple(List.map deref_id_typ xts, deref_term e1, deref_term e2, d)
  | Array(e1, e2, d) -> Array(deref_term e1, deref_term e2, d)
  | Get(e1, e2, d) -> Get(deref_term e1, deref_term e2, d)
  | Put(e1, e2, e3, d) -> Put(deref_term e1, deref_term e2, deref_term e3, d)
  | Sll(e1, e2, d) -> Sll(deref_term e1, deref_term e2, d)
  | Srl(e1, e2, d) -> Srl(deref_term e1, deref_term e2, d)
  | Sra(e1, e2, d) -> Sra(deref_term e1, deref_term e2, d)
  | Fun(xs, e, d) -> Fun(List.map deref_id_typ xs, deref_term e, d)
  | e -> e

let rec occur r1 = function (* occur check (caml2html: typing_occur) *)
  | Type.Fun(t2s, t2) -> List.exists (occur r1) t2s || occur r1 t2
  | Type.Tuple(t2s) -> List.exists (occur r1) t2s
  | Type.Array(t2) -> occur r1 t2
  | Type.Var(r2) when r1 == r2 -> true
  | Type.Var({ contents = None }) -> false
  | Type.Var({ contents = Some(t2) }) -> occur r1 t2
  | _ -> false


let rec currying = function
  | Type.Fun(t2s, t2) -> 
    (match t2s with 
    | [x] -> Type.Fun([x], currying t2)
    | x :: xs -> Type.Fun([x], currying (Type.Fun(xs, t2)))
    )
  | t -> t

let rec head_n l n = 
  match l with
  | [] -> []
  | _ when n = 0 -> []
  | x :: xs -> x :: (head_n xs (n - 1))

let rec elm_head_n l n =
  match l with
  | [] -> []
  | ls when n = 0 -> ls
  | x :: xs -> elm_head_n xs (n - 1)

let rec unify t1 t2 d = (* 型が合うように、型変数への代入をする (caml2html: typing_unify) *)
  match t1, t2 with
  | Type.Unit, Type.Unit | Type.Bool, Type.Bool | Type.Int, Type.Int | Type.Bool, Type.Int | Type.Int, Type.Bool | Type.Float, Type.Float -> ()
  | Type.Fun(t1s, t1'), Type.Fun(t2s, t2') when List.length t1s > List.length t2s -> (* 部分的にカリー化 *)
    unify (Type.Fun(head_n t1s (List.length t2s), Type.Fun(elm_head_n t1s (List.length t2s), t1'))) (Type.Fun(t2s, t2')) d
  | Type.Fun(t1s, t1'), Type.Fun(t2s, t2') when List.length t1s < List.length t2s ->
    unify (Type.Fun(head_n t2s (List.length t1s), Type.Fun(elm_head_n t2s (List.length t1s), t2'))) (Type.Fun(t1s, t1')) d
  | Type.Fun(t1s, t1'), Type.Fun(t2s, t2') ->
      (try List.iter2 (fun x y -> unify x y d) (t1s) (t2s)
      with Invalid_argument(_) -> raise (Unify(t1, t2, d)));
      unify t1' t2' d
  | Type.Tuple(t1s), Type.Tuple(t2s) ->
      (try List.iter2 (fun x y -> unify x y d) t1s t2s
      with Invalid_argument(_) -> raise (Unify(t1, t2, d)))
  | Type.Array(t1), Type.Array(t2) -> unify t1 t2 d
  | Type.Var(r1), Type.Var(r2) when r1 == r2 -> ()
  | Type.Var({ contents = Some(t1') }), _ -> unify t1' t2 d
  | _, Type.Var({ contents = Some(t2') }) -> unify t1 t2' d
  | Type.Var({ contents = None } as r1), _ -> (* 一方が未定義の型変数の場合 (caml2html: typing_undef) *)
      if occur r1 t2 then raise (Unify(t1, t2, d));
      r1 := Some(t2)
  | _, Type.Var({ contents = None } as r2) ->
      if occur r2 t1 then raise (Unify(t1, t2, d));
      r2 := Some(t1)
  | _, _ -> raise (Unify(t1, t2, d))


let rec sprint_type_list = function
  | [] -> ""
  | [x] -> sprint_type (deref_typ x)
  | x :: xs -> (sprint_type (deref_typ x))^(" * ")^(sprint_type_list xs)
and
sprint_type t =
  match t with
  | Type.Unit -> "unit" 
  | Type.Bool -> "bool" 
  | Type.Int -> "int" 
  | Type.Float -> "float" 
  | Type.Fun (tl, t) -> "fun ("^(sprint_type_list tl)^" -> "^(sprint_type t)^")"  (* arguments are uncurried *)
  | Type.Tuple tl -> "tuple "^(sprint_type_list tl)
  | Type.Array t -> ("array ")^(sprint_type t)
  | Type.Var t -> "var"

let rec print_type t = 
  print_string (sprint_type t)



let rec g env e = (* 型推論ルーチン (caml2html: typing_g) *)
  try
    match e with
    | Unit(d) -> Type.Unit
    | Bool(_, d) -> Type.Bool
    | Int(_, d) -> Type.Int
    | Float(_, d) -> Type.Float
    | Not(e, d) ->
        unify Type.Bool (g env e) d;
        Type.Bool
    | Neg(e, d) ->
        unify Type.Int (g env e) d;
        Type.Int
    | Add(e1, e2, d) | Sub(e1, e2, d) -> (* 足し算（と引き算）の型推論 (caml2html: typing_add) *)
        unify Type.Int (g env e1) d;
        unify Type.Int (g env e2) d;
        Type.Int
    | FNeg(e, d) ->
        unify Type.Float (g env e) d;
        Type.Float
    | FAdd(e1, e2, d) | FSub(e1, e2, d) | FMul(e1, e2, d) | FDiv(e1, e2, d) ->
        unify Type.Float (g env e1) d;
        unify Type.Float (g env e2) d;
        Type.Float
    | Eq(e1, e2, d) | LE(e1, e2, d) ->
        unify (g env e1) (g env e2) d;
        Type.Bool
    | If(e1, e2, e3, d) ->
        unify (g env e1) Type.Bool d;
        let t2 = g env e2 in
        let t3 = g env e3 in
        unify t2 t3 d;
        t2
    | Let((x, t), e1, e2, d) -> (* letの型推論 (caml2html: typing_let) *)
        unify t (g env e1) d;
        g (M.add x t env) e2
    | Var(x, d) when M.mem x env -> M.find x env (* 変数の型推論 (caml2html: typing_var) *)
    | Var(x, d) when M.mem x !extenv -> M.find x !extenv
    | Var(x, d) -> (* 外部変数の型推論 (caml2html: typing_extvar) *)
        Format.eprintf "free variable %s assumed as external@." x;
        let t = Type.gentyp () in
        extenv := M.add x t !extenv;
        t
    | LetRec({ name = (x, t); args = yts; body = e1; deb = d }, e2, d2) -> (* let recの型推論 (caml2html: typing_letrec) *)
        let env = M.add x t env in
        unify t (Type.Fun(List.map snd yts, g (M.add_list yts env) e1)) d;
        g env e2
    | App(e, es, d) -> (* 関数適用の型推論 (caml2html: typing_app) *)
        let t = Type.gentyp () in
        unify (g env e) (Type.Fun(List.map (g env) es, t)) d;
        t
    | Tuple(es, d) -> Type.Tuple(List.map (g env) es)
    | LetTuple(xts, e1, e2, d) ->
        unify (Type.Tuple(List.map snd xts)) (g env e1) d;
        g (M.add_list xts env) e2
    | Array(e1, e2, d) -> (* must be a primitive for "polymorphic" typing *)
        unify (g env e1) Type.Int d;
        Type.Array(g env e2)
    | Get(e1, e2, d) ->
        let t = Type.gentyp () in
        unify (Type.Array(t)) (g env e1) d;
        unify Type.Int (g env e2) d;
        t
    | Put(e1, e2, e3, d) ->
        let t = g env e3 in
        unify (Type.Array(t)) (g env e1) d;
        unify Type.Int (g env e2) d;
        Type.Unit
    | Sll (e1, e2, d) | Srl(e1, e2, d) | Sra(e1, e2, d) -> (* 算術シフトの型推論 *)
        unify Type.Int (g env e1) d;
        unify Type.Int (g env e2) d;
        Type.Int
    | Fun (xs, e, d) ->
        let t = g (M.add_list xs env) e in
        Type.Fun(List.map snd xs, t) 

  with Unify(t1, t2, d) -> 
        Printf.printf "Typing error!! line %d near character %d-%d\n" d.lnum d.bchar d.echar; 
        Printf.printf "Cannot unify type \"%s\" and \"%s\"\n" 
          (sprint_type t1) (sprint_type t2); 
        raise (Error(deref_term e, deref_typ t1, deref_typ t2))

let f e =
  extenv := M.empty;

  (match deref_typ (g M.empty e) with
  | Type.Unit -> ()
  | _ -> Format.eprintf "warning: final result does not have type unit@.");

  (try unify Type.Unit (g M.empty e) { lnum = 0; bchar = 0; echar = 0 }
  with Unify _ -> Format.eprintf "top level does not have type unit");(*failwith "top level does not have type unit");*)
  extenv := M.map deref_typ !extenv;
  deref_term e




