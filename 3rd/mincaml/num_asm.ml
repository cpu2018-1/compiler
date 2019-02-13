
let print_b = ref false
let print_a = ref false
let counter = ref 0

type id_or_imm = V of Id.t | C of int | FC of float
type t = (* 命令の列 (caml2html: sparcasm_t) *)
  | Ans of exp * int
  | Let of (Id.t * Type.t) * exp * int * t
and exp = (* 一つ一つの命令に対応する式 (caml2html: sparcasm_exp) *)
  | Nop
  | Li of int
(*  | FLi of Id.l*)
  | FLi of float
  | SetL of Id.l
  | Mr of Id.t
  | Neg of Id.t
  | Add of Id.t * id_or_imm
  | Sub of Id.t * id_or_imm
  | Lw of Id.t * id_or_imm
  | Sw of Id.t * Id.t * id_or_imm
  | FMr of Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | FLw of Id.t * id_or_imm
  | FSw of Id.t * Id.t * id_or_imm
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t (* 左右対称ではないので必要 *)
  | IfFEq of id_or_imm * id_or_imm * t * t
  | IfFLE of id_or_imm * id_or_imm * t * t
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 (caml2html: sparcasm_save) *)
  | Restore of Id.t (* スタック変数から値を復元 (caml2html: sparcasm_restore) *)
  | Sll of Id.t * id_or_imm
  | Srl of Id.t * id_or_imm
  | Sra of Id.t * id_or_imm
  | In of Id.t
  | Out of Id.t
  | FSqrt of Id.t
  | FtoI of Id.t
  | ItoF of Id.t
  | SetGlb of Id.l
  | Subst of (Id.t * Type.t) * exp (* 代入構文 *)
  | Incr_hp 
  | Store_hp of Id.t
  | FStore_hp of Id.t
type fundef = { name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }

let seq (e1, e2) = incr counter; Let((Id.gentmp Type.Unit, Type.Unit), e1, !counter, e2) (** 順に実行 **)

let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

let fv_id_or_imm = function V(x) -> [x] | _ -> []
let rec fv_exp = function
  | Nop | Li(_) | FLi(_) | SetL(_) | Comment(_) | Restore(_) | SetGlb(_) -> []
  | Mr(x) | Neg(x) | FMr(x) | FNeg(x) | Save(x, _) | In(x) | Out(x) | FSqrt(x) | FtoI(x) | ItoF(x) -> [x]
  | Add(x, y') | Sub(x, y') | FLw(x, y') | Lw(x, y') | Sll(x, y') | Srl(x, y') | Sra(x, y') -> x :: fv_id_or_imm y'
  | Sw(x, y, z') | FSw(x, y, z') -> x :: y :: fv_id_or_imm z'
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) ->  x :: fv_id_or_imm y' @ remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | IfFEq(x, y', e1, e2) | IfFLE(x, y', e1, e2) -> fv_id_or_imm x @ fv_id_or_imm y' @ remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | CallCls(x, ys, zs) -> x :: ys @ zs
  | CallDir(_, ys, zs) -> ys @ zs
  | Subst ((x, t), e) -> fv_exp e
and fv = function
  | Ans(exp, i) -> fv_exp exp
  | Let((x, t), exp, i, e) ->
      fv_exp exp @ remove_and_uniq (S.singleton x) (fv e)
let fv e = remove_and_uniq S.empty (fv e)



type prog =
  Prog of (Id.l * float) list * fundef list * t


let rec convert_id_or_imm = function
  | Asm.V(x) -> V(x)
  | Asm.C(i) -> C(i)
  | Asm.FC(d) -> FC(d)

let rec convert_exp e =
  match e with
  | Asm.IfEq(a, b, e1, e2) -> IfEq(a, convert_id_or_imm b, convert_t e1, convert_t e2) 
  | Asm.IfLE(a, b, e1, e2) -> IfLE(a, convert_id_or_imm b, convert_t e1, convert_t e2)
  | Asm.IfGE(a, b, e1, e2) -> IfGE(a, convert_id_or_imm b, convert_t e1, convert_t e2)
  | Asm.IfFEq(a, b, e1, e2) -> IfFEq(convert_id_or_imm a, convert_id_or_imm b, convert_t e1, convert_t e2)
  | Asm.IfFLE(a, b, e1, e2) -> IfFLE(convert_id_or_imm a, convert_id_or_imm b, convert_t e1, convert_t e2)
  | Asm.Nop -> Nop
  | Asm.Li(i) -> Li(i)
  | Asm.FLi(d) -> FLi(d)
  | Asm.SetL(l) -> SetL(l)
  | Asm.Mr(x) -> Mr(x)
  | Asm.Neg(x) -> Neg(x)
  | Asm.Add(x, a) -> Add(x, convert_id_or_imm a)
  | Asm.Sub(x, a) -> Sub(x, convert_id_or_imm a)
  | Asm.Lw(x, a) -> Lw(x, convert_id_or_imm a)
  | Asm.Sw(x, y, a) -> Sw(x, y, convert_id_or_imm a)
  | Asm.FMr(x) -> FMr(x)
  | Asm.FNeg(x) -> FNeg(x)
  | Asm.FAdd(x, y) -> FAdd(x, y)
  | Asm.FSub(x, y) -> FSub(x, y)
  | Asm.FMul(x, y) -> FMul(x, y)
  | Asm.FDiv(x, y) -> FDiv(x, y)
  | Asm.FLw(x, a) -> FLw(x, convert_id_or_imm a)
  | Asm.FSw(x, y, a) -> FSw(x, y, convert_id_or_imm a)
  | Asm.Comment(s) -> Comment(s)
  | Asm.CallCls(x, xs, ys) -> CallCls(x, xs, ys)
  | Asm.CallDir(x, xs, ys) -> CallDir(x, xs, ys)
  | Asm.Save(x, y) -> Save(x, y)
  | Asm.Restore(x) -> Restore(x)
  | Asm.Sll(x, a) -> Sll(x, convert_id_or_imm a)
  | Asm.Srl(x, a) -> Srl(x, convert_id_or_imm a)
  | Asm.Sra(x, a) -> Sra(x, convert_id_or_imm a)
  | Asm.In(x) -> In(x)
  | Asm.Out(x) -> Out(x)
  | Asm.FSqrt(x) -> FSqrt(x)
  | Asm.FtoI(x) -> FtoI(x)
  | Asm.ItoF(x) -> ItoF(x)
  | Asm.SetGlb(x) -> SetGlb(x)
  | Asm.Subst(xt, e') -> Subst(xt, convert_exp e')
  | Asm.Incr_hp -> Incr_hp
  | Asm.Store_hp(x) -> Store_hp(x)
  | Asm.FStore_hp(x) -> FStore_hp(x)
and convert_t t = 
  incr counter;
  let i = !counter in
  match t with
  | Asm.Let((x, t), e, cont) ->
    Let((x, t), convert_exp e, i, convert_t cont)
  | Asm.Ans(e) -> Ans(convert_exp e, i)

let rec convert_fun { Asm.name = x; Asm.args = xs; Asm.fargs = ys; Asm.body = e; Asm.ret = t} =
  { name = x; args = xs; fargs = ys; body = convert_t e; ret = t}

(* インデント幅 *)
let indent = ". "
  
(* 幅nのインデントを出力 *)
let rec print_indent n =
  if n = 0 then
    ()
  else (
    print_string indent; print_indent (n - 1)
  )

(* (インデント幅) * (インデントの深さ)のインデントを出力 *)

(* スペースを出力/後々にスペースを変えたい時用に定義したが不要な感じがする *)
let print_space () = print_string " "

let rec print_id_or_imm = function
  | V s -> Id.print_id s
  | C a -> print_int a
  | FC f -> print_float f

let rec print_t i = function
  | Ans (e, j) ->
        print_indent i; print_endline "ANS";
        print_indent i; print_string "instruction number : ";
        print_int j; print_newline ();
        print_exp i e
  | Let ((x, t), exp, j, e) -> 
        print_indent i;
        print_string "instruction number : "; print_int j; print_newline ();
        print_indent i;
        print_endline "LET";
        print_indent (i + 1); print_string "("; Id.print_id x; print_string ", "; Typing.print_type t; print_endline ") = ";
        print_exp (i + 1) exp;
        print_indent i; print_endline "IN";
        print_t (i + 1) e
and print_exp i exp = (* 一つ一つの命令に対応する式 (caml2html: sparcasm_exp) *)
  print_indent i;
  match exp with
  | Nop -> print_endline "Nop";
  | Li n -> print_string "Li "; print_int n; print_newline () 
  | FLi (d) -> print_string ("FLi "); print_float d; print_newline ()
  | SetL (Id.L s) -> print_endline ("SetL "^s)
  | Mr x -> print_string "Mr "; Id.print_id x; print_newline ();
  | Neg x -> print_string "Neg "; Id.print_id x; print_newline ();
  | Add (x, a) -> 
          print_endline "Add"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Sub (x, a) -> 
          print_endline "Sub"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Lw (x, a) ->
          print_endline "Lw";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Sw (x, y, a) ->
          print_endline "Sw"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | FMr x -> print_string "FMr "; Id.print_id x; print_newline ();
  | FNeg x -> print_string "FNeg "; Id.print_id x; print_newline ();
  | FAdd (x, y) -> 
          print_endline "FAdd";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ()
  | FSub (x, y) -> 
          print_endline "FSub";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ()
  | FMul (x, y) -> 
          print_endline "FMul";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ()
  | FDiv (x, y) -> 
          print_endline "FDiv";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ()
  | FLw (x, a) -> 
          print_endline "FLw"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | FSw (x, y, a) -> 
          print_endline "FSw"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Comment s -> print_endline ("Comment "^s)
  (* virtual instructions *)
  | IfEq (x, y, e1, e2) ->
          print_endline "IfEq";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm y; print_newline ();
          print_indent i; print_endline "then";
          print_t (i + 1) e1;
          print_indent i; print_endline "else";
          print_t (i + 1) e2
  | IfLE (x, y, e1, e2) ->
          print_endline "IfLE";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm y; print_newline ();
          print_indent i; print_endline "then";
          print_t (i + 1) e1;
          print_indent i; print_endline "else";
          print_t (i + 1) e2
  | IfGE (x, y, e1, e2) ->
          print_endline "IfGE";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm y; print_newline ();
          print_indent i; print_endline "then";
          print_t (i + 1) e1;
          print_indent i; print_endline "else";
          print_t (i + 1) e2
  | IfFEq (x, y, e1, e2) ->
          print_endline "IfFEq";
          print_indent (i + 1); print_id_or_imm x; print_newline ();
          print_indent (i + 1); print_id_or_imm y; print_newline ();
          print_indent i; print_endline "then";
          print_t (i + 1) e1;
          print_indent i; print_endline "else";
          print_t (i + 1) e2
  | IfFLE (x, y, e1, e2) ->
          print_endline "IfFLE";
          print_indent (i + 1); print_id_or_imm x; print_newline ();
          print_indent (i + 1); print_id_or_imm y; print_newline ();
          print_indent i; print_endline "then";
          print_t (i + 1) e1;
          print_indent i; print_endline "else";
          print_t (i + 1) e2
  (* closure address, integer arguments, and float arguments *)
  | CallCls (f, x, fx) -> 
          print_endline "CallCls";
          print_indent (i + 1); Id.print_id f; print_newline ();
          print_indent (i + 1); Id.print_id_list x " "; print_newline ();
          print_indent (i + 1); Id.print_id_list fx " "; print_newline ()
  | CallDir (Id.L f, x, fx) -> 
          print_endline "CallDir";
          print_indent (i + 1); Id.print_id f; print_newline ();
          print_indent (i + 1); Id.print_id_list x " "; print_newline ();
          print_indent (i + 1); Id.print_id_list fx " "; print_newline ()
  | Save (x, y) -> (* レジスタ変数の値をスタック変数へ保存 (caml2html: sparcasm_save) *)
          print_endline "Save";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ();
  | Restore x -> (* スタック変数から値を復元 (caml2html: sparcasm_restore) *)
          print_endline "Restore";
          print_indent (i + 1); Id.print_id x; print_newline ();
  | Sll (x, a) -> 
          print_endline "Sll"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Srl (x, a) -> 
          print_endline "Srl"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Sra (x, a) -> 
          print_endline "Sra"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | In (x) -> 
          print_endline "In";
          print_indent (i + 1); Id.print_id x; print_newline ()
  | Out (x) -> 
          print_endline "Out";
          print_indent (i + 1); Id.print_id x; print_newline ()
  | FSqrt (x) -> 
          print_endline "FSqrt";
          print_indent (i + 1); Id.print_id x; print_newline ()
  | FtoI (x) -> 
          print_endline "FtoI";
          print_indent (i + 1); Id.print_id x; print_newline ()
  | ItoF (x) -> 
          print_endline "ItoF";
          print_indent (i + 1); Id.print_id x; print_newline ()
  | SetGlb (Id.L s) -> print_endline ("SetGlb "^s)
  | Subst ((x, t), e') -> 
          print_endline "Subst";
          print_indent (i + 1); print_string "("; Id.print_id x; print_string ", "; Typing.print_type t; print_string ")"; print_newline ();
          print_exp (i + 1) e'
  | Incr_hp ->
          print_endline "Incr_hp"
  | Store_hp(x) ->
          print_endline "Store_hp";
          print_indent (i + 1); Id.print_id x; print_newline ()
  | FStore_hp(x) ->
          print_endline "FStore_hp";
          print_indent (i + 1); Id.print_id x; print_newline ()

let rec print_fundef { name = Id.L(f); args = xs; fargs = ys; body = e; ret = ty } =
  print_endline ("function name : "^f);
  let arguments = List.fold_left (fun x s -> x ^ " " ^ s) "" (xs @ ys) in
  print_endline ("arguments : "^arguments);
  print_endline ("body : ");
  print_t 1 e
  

let rec invert_id_or_imm = function
  | V(x) -> Asm.V(x)
  | C(i) -> Asm.C(i)
  | FC(d) -> Asm.FC(d)

(* Asm.expに戻す *)
let rec invert_exp e =
  match e with
  | IfEq(a, b, e1, e2) -> Asm.IfEq(a, invert_id_or_imm b, invert_t e1, invert_t e2) 
  | IfLE(a, b, e1, e2) -> Asm.IfLE(a, invert_id_or_imm b, invert_t e1, invert_t e2)
  | IfGE(a, b, e1, e2) -> Asm.IfGE(a, invert_id_or_imm b, invert_t e1, invert_t e2)
  | IfFEq(a, b, e1, e2) -> Asm.IfFEq(invert_id_or_imm a, invert_id_or_imm b, invert_t e1, invert_t e2)
  | IfFLE(a, b, e1, e2) -> Asm.IfFLE(invert_id_or_imm a, invert_id_or_imm b, invert_t e1, invert_t e2)
  | Nop -> Asm.Nop
  | Li(i) -> Asm.Li(i)
  | FLi(d) -> Asm.FLi(d)
  | SetL(l) -> Asm.SetL(l)
  | Mr(x) -> Asm.Mr(x)
  | Neg(x) -> Asm.Neg(x)
  | Add(x, a) -> Asm.Add(x, invert_id_or_imm a)
  | Sub(x, a) -> Asm.Sub(x, invert_id_or_imm a)
  | Lw(x, a) -> Asm.Lw(x, invert_id_or_imm a)
  | Sw(x, y, a) -> Asm.Sw(x, y, invert_id_or_imm a)
  | FMr(x) -> Asm.FMr(x)
  | FNeg(x) -> Asm.FNeg(x)
  | FAdd(x, y) -> Asm.FAdd(x, y)
  | FSub(x, y) -> Asm.FSub(x, y)
  | FMul(x, y) -> Asm.FMul(x, y)
  | FDiv(x, y) -> Asm.FDiv(x, y)
  | FLw(x, a) -> Asm.FLw(x, invert_id_or_imm a)
  | FSw(x, y, a) -> Asm.FSw(x, y, invert_id_or_imm a)
  | Comment(s) -> Asm.Comment(s)
  | CallCls(x, xs, ys) -> Asm.CallCls(x, xs, ys)
  | CallDir(x, xs, ys) -> Asm.CallDir(x, xs, ys)
  | Save(x, y) -> Asm.Save(x, y)
  | Restore(x) -> Asm.Restore(x)
  | Sll(x, a) -> Asm.Sll(x, invert_id_or_imm a)
  | Srl(x, a) -> Asm.Srl(x, invert_id_or_imm a)
  | Sra(x, a) -> Asm.Sra(x, invert_id_or_imm a)
  | In(x) -> Asm.In(x)
  | Out(x) -> Asm.Out(x)
  | FSqrt(x) -> Asm.FSqrt(x)
  | FtoI(x) -> Asm.FtoI(x)
  | ItoF(x) -> Asm.ItoF(x)
  | SetGlb(x) -> Asm.SetGlb(x)
  | Subst(xt, e') -> Asm.Subst(xt, invert_exp e')
  | Incr_hp -> Asm.Incr_hp
  | Store_hp(x) -> Asm.Store_hp(x)
  | FStore_hp(x) -> Asm.FStore_hp(x)
and invert_t t =
  match t with
  | Let((x, t), e, i, cont) -> Asm.Let((x, t), invert_exp e, invert_t cont)
  | Ans(e, i) -> Asm.Ans(invert_exp e)


let rec invert_fun { name = x; args = xs; fargs = ys; body = e; ret = t} =
  { Asm.name = x; Asm.args = xs; Asm.fargs = ys; Asm.body = invert_t e; Asm.ret = t}


let rec g (Prog(data, fundefs, e)) =
  (if (!print_a) then (
    Printf.printf ("Prog before register allocation\n");
    List.iter (fun f -> print_newline (); print_fundef f) fundefs;
    print_newline ();
    print_t 1 e
  )
  else ()
  )
  ;
  let e = invert_t e in
  let fundefs = List.map invert_fun fundefs in 
  Asm.Prog(data, fundefs, e)



let rec f (Asm.Prog(data, fundefs, e)) =
  let e = convert_t e in
  let fundefs = List.map convert_fun fundefs in 
  (if (!print_b) then (
    Printf.printf ("Prog before register allocation\n");
    List.iter (fun f -> print_newline (); print_fundef f) fundefs;
    print_newline ();
    print_t 1 e
  )
  else ()
  )
  ;
  Prog(data, fundefs, e)
