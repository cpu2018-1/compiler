(* PowerPC assembly with a few virtual instructions *)

type id_or_imm = V of Id.t | C of int
type t = (* 命令の列 (caml2html: sparcasm_t) *)
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
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
  | Slw of Id.t * id_or_imm
  | Lwz of Id.t * id_or_imm
  | Stw of Id.t * Id.t * id_or_imm
  | FMr of Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | Lfd of Id.t * id_or_imm
  | Stfd of Id.t * Id.t * id_or_imm
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t (* 左右対称ではないので必要 *)
  | IfFEq of Id.t * Id.t * t * t
  | IfFLE of Id.t * Id.t * t * t
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 (caml2html: sparcasm_save) *)
  | Restore of Id.t (* スタック変数から値を復元 (caml2html: sparcasm_restore) *)
type fundef = { name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }
(* プログラム全体 = 浮動小数点数テーブル + トップレベル関数 + メインの式 (caml2html: sparcasm_prog) *)
type prog = Prog of (Id.l * float) list * fundef list * t

let fletd(x, e1, e2) = Let((x, Type.Float), e1, e2)
let seq(e1, e2) = Let((Id.gentmp Type.Unit ,Type.Unit), e1, e2) (** 順に実行 **)

let regs = (* Array.init 27 (fun i -> Printf.sprintf "_R_%d" i) *)
  [| "%r1"; "%r2"; "%r5"; "%r6"; "%r7"; "%r8"; "%r9"; "%r10";
     "%r11"; "%r12"; "%r13"; "%r14"; "%r15"; "%r16"; "%r17"; "%r18";
     "%r19"; "%r20"; "%r21"; "%r22"; "%r23"; "%r24"; "%r25"; "%r26";
     "%r27"; "%r28"; "%r29" |]
let fregs = 
[| "%f1"; "%f2"; "%f3"; "%f4"; "%f5"; "%f6"; "%f7"; "%f8"; "%f9"; "%f10";   
   "%f11"; "%f12"; "%f13"; "%f14"; "%f15"; "%f16"; "%f17"; "%f18"; "%f19";       
   "%f20"; "%f21"; "%f22"; "%f23"; "%f24"; "%f25"; "%f26"; "%f27"; "%f28";
   "%f29"; "%f30"; "%f31"|]
let allregs = Array.to_list regs
let allfregs = Array.to_list fregs
let reg_cl = regs.(Array.length regs - 1) (* closure address (caml2html: sparcasm_regcl) *)
let reg_sw = regs.(Array.length regs - 2) (* temporary for swap *)
let reg_fsw = fregs.(Array.length fregs - 1) (* temporary for swap *)
let reg_sp = "%r3" (* stack pointer *)
let reg_hp = "%r4" (* heap pointer (caml2html: sparcasm_reghp) *)
let reg_tmp = "%r30" (* [XX] ad hoc *)
let reg_lr = "%r31"
let is_reg x = (x.[0] = '%')

(* super-tenuki *)
let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

(* free variables in the order of use (for spilling) (caml2html: sparcasm_fv) *)
let fv_id_or_imm = function V(x) -> [x] | _ -> []
let rec fv_exp = function
  | Nop | Li(_) | FLi(_) | SetL(_) | Comment(_) | Restore(_) -> []
  | Mr(x) | Neg(x) | FMr(x) | FNeg(x) | Save(x, _) -> [x]
  | Add(x, y') | Sub(x, y') | Slw(x, y') | Lfd(x, y') | Lwz(x, y') -> x :: fv_id_or_imm y'
  | Stw(x, y, z') | Stfd(x, y, z') -> x :: y :: fv_id_or_imm z'
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) ->  x :: fv_id_or_imm y' @ remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | IfFEq(x, y, e1, e2) | IfFLE(x, y, e1, e2) -> x :: y :: remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | CallCls(x, ys, zs) -> x :: ys @ zs
  | CallDir(_, ys, zs) -> ys @ zs
and fv = function
  | Ans(exp) -> fv_exp exp
  | Let((x, t), exp, e) ->
      fv_exp exp @ remove_and_uniq (S.singleton x) (fv e)
let fv e = remove_and_uniq S.empty (fv e)

let rec concat e1 xt e2 =
  match e1 with
  | Ans(exp) -> Let(xt, exp, e2)
  | Let(yt, exp, e1') -> Let(yt, exp, concat e1' xt e2)

let align i = (if i mod 8 = 0 then i else i + 4)




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

let rec print_t i = function
  | Ans e -> print_exp i e
  | Let ((x, t), exp, e) -> 
        print_indent i;
        print_endline "LET";
        print_indent (i + 1); Id.print_id x; print_endline " = ";
        print_exp (i + 1) exp;
        print_indent i; print_endline "IN";
        print_t (i + 1) e
and print_exp i exp = (* 一つ一つの命令に対応する式 (caml2html: sparcasm_exp) *)
  print_indent i;
  match exp with
  | Nop -> ()
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
  | Slw (x, a) ->
          print_endline "Slw"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Lwz (x, a) ->
          print_endline "Lwz";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Stw (x, y, a) ->
          print_endline "Stw"; 
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
  | Lfd (x, a) -> 
          print_endline "Lfd"; 
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); print_id_or_imm a; print_newline ()
  | Stfd (x, y, a) -> 
          print_endline "Lfd"; 
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
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ();
          print_indent i; print_endline "then";
          print_t (i + 1) e1;
          print_indent i; print_endline "else";
          print_t (i + 1) e2
  | IfFLE (x, y, e1, e2) ->
          print_endline "IfFLE";
          print_indent (i + 1); Id.print_id x; print_newline ();
          print_indent (i + 1); Id.print_id y; print_newline ();
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
