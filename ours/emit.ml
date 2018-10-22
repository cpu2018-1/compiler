open Asm

external gethi : float -> int32 = "gethi"
external getlo : float -> int32 = "getlo"
external internal_of_float : float -> int32 = "internal_of_float"

let stackset = ref S.empty (* ���Ǥ�Save���줿�ѿ��ν��� (caml2html: emit_stackset) *)
let stackmap = ref [] (* Save���줿�ѿ��Ρ������å��ˤ�������� (caml2html: emit_stackmap) *)

let save x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let savef x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    (let pad =
      if List.length !stackmap mod 2 = 0 then [] else [Id.gentmp Type.Int] in
    stackmap := !stackmap @ pad @ [x; x])
let locate x =
  let rec loc = function
    | [] -> []
    | y :: zs when x = y -> 0 :: List.map succ (loc zs)
    | y :: zs -> List.map succ (loc zs) in
  loc !stackmap
let offset x = 4 * List.hd (locate x)
let stacksize () = align ((List.length !stackmap + 1) * 4)

let reg r =
  if is_reg r
  then String.sub r 1 (String.length r - 1)
  else r

let load_label r label =
  let r' = reg r in
  Printf.sprintf
  "\tlis\t%s, ha16(%s)\n\taddi\t%s, %s, lo16(%s)\n"
    r' label r' r' label


(* �ؿ��ƤӽФ��Τ���˰������¤��ؤ���(register shuffling) (caml2html: emit_shuffle) *)
let rec shuffle sw xys =
  (* remove identical moves *)
  let _, xys = List.partition (fun (x, y) -> x = y) xys in
  (* find acyclic moves *)
  match List.partition (fun (_, y) -> List.mem_assoc y xys) xys with
  | [], [] -> []
  | (x, y) :: xys, [] -> (* no acyclic moves; resolve a cyclic move *)
      (y, sw) :: (x, y) :: shuffle sw (List.map
                                         (function
                                           | (y', z) when y = y' -> (sw, z)
                                           | yz -> yz)
                                         xys)
  | xys, acyc -> acyc @ shuffle sw xys

type dest = Tail | NonTail of Id.t (* �������ɤ�����ɽ���ǡ����� (caml2html: emit_dest) *)
let rec g oc = function (* ̿����Υ�����֥����� (caml2html: emit_g) *)
  | dest, Ans(exp) -> g' oc (dest, exp)
  | dest, Let((x, t), exp, e) ->
      g' oc (NonTail(x), exp);
      g oc (dest, e)
and g' oc = function (* ��̿��Υ�����֥����� (caml2html: emit_gprime) *)
  (* �����Ǥʤ��ä���׻���̤�dest�˥��å� (caml2html: emit_nontail) *)
  | NonTail(_), Nop -> ()
  | NonTail(x), Li(i) when -32768 <= i && i < 32768 -> Printf.fprintf oc "\taddi\t%s, r0, %d\t\t\t\t# li\t%s, %d\n" (reg x) i (reg x) i   (**)
  | NonTail(x), Li(i) ->                                                                        (**)
      let n = i lsr 16 in
      let m = (i lsl 48) lsr 48 in
      let r = reg x in
      Printf.fprintf oc "\taddi\t%s, r0, %d\n" r m;
      Printf.fprintf oc "\tlui\t%s, %s, %d\n" r r n
  | NonTail(x), FLi(d) ->
(*      let s = load_label (reg reg_tmp) l in
      Printf.fprintf oc "%s\tlfd\t%s, 0(%s)\n" s (reg x) (reg reg_tmp)
*)
      Printf.fprintf oc "\taddi\t%s, r0, %ld\t# to load float\t\t%f\n" (reg reg_tmp) (internal_of_float d) d;
      Printf.fprintf oc "\tfmvfr\t%s, %s\n" (reg x) (reg reg_tmp)
  | NonTail(x), SetL(Id.L(y)) ->
      let s = load_label x y in
      Printf.fprintf oc "%s" s
  | NonTail(x), Mr(y) when x = y -> ()                                                          (*******************)
  | NonTail(x), Mr(y) -> Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t# mr\t%s, %s\n" (reg x) (reg y) (reg x) (reg y)   (*******************)
  | NonTail(x), Neg(y) -> Printf.fprintf oc "\tsub\t%s, r0, %s\n" (reg x) (reg y)  (* x <- sub 0 y *)
  | NonTail(x), Add(y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg x) (reg y) (reg z) (**)
  | NonTail(x), Add(y, C(z)) -> Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg x) (reg y) z      (**)
  | NonTail(x), Sub(y, V(z)) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg x) (reg y) (reg z) (**)
  | NonTail(x), Sub(y, C(z)) -> Printf.fprintf oc "\taddi\t%s, r0, %d\n\tsub\t%s, %s, %s\n" (reg x) z (reg x) (reg y) (reg x) (* x <- addi 0 z; x <- sub y x *)
  | NonTail(x), Slw(y, V(z)) -> Printf.fprintf oc "\tsll\t%s, %s, %s\n" (reg x) (reg y) (reg z) 
  | NonTail(x), Slw(y, C(z)) -> Printf.fprintf oc "\tadd\t%s, r0, %d\n" (reg reg_tmp) z;                  (** ��ö�쥸�����˳�Ǽ **)
                                Printf.fprintf oc "\tsll\t%s, %s, %s\n" (reg x) (reg y) (reg reg_tmp)      
  | NonTail(x), Lwz(y, V(z)) -> Printf.fprintf oc "\tlwzx\t%s, %s, %s\n" (reg x) (reg y) (reg z)                       (** �ɤ����뤫̤�� **)
  | NonTail(x), Lwz(y, C(z)) -> Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) z (reg y)        (**)
  | NonTail(_), Stw(x, y, V(z)) -> Printf.fprintf oc "\tstwx\t%s, %s, %s\n" (reg x) (reg y) (reg z)                    (** �ɤ����뤫̤�� **)
  | NonTail(_), Stw(x, y, C(z)) -> Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg x) z (reg y)    (**)
  | NonTail(x), FMr(y) when x = y -> ()                                                         (*****************)
  | NonTail(x), FMr(y) -> Printf.fprintf oc "\tfadd\t%s, f0, %s\t\t\t\t# fmr\t%s, %s\n" (reg x) (reg y) (reg x) (reg y)       (*****************)
  | NonTail(x), FNeg(y) -> Printf.fprintf oc "\tfneg\t%s, %s\n" (reg x) (reg y)                 (**)
  | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\tfadd\t%s, %s, %s\n" (reg x) (reg y) (reg z)  (**)
  | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\tfsub\t%s, %s, %s\n" (reg x) (reg y) (reg z)  (**)
  | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\tfmul\t%s, %s, %s\n" (reg x) (reg y) (reg z)  (**)
  | NonTail(x), FDiv(y, z) -> Printf.fprintf oc "\tfdiv\t%s, %s, %s\n" (reg x) (reg y) (reg z)  (**)
  | NonTail(x), Lfd(y, V(z)) -> Printf.fprintf oc "\tlfdx\t%s, %s, %s\n" (reg x) (reg y) (reg z)                       (** �ɤ����뤫̤�� **)
  | NonTail(x), Lfd(y, C(z)) -> Printf.fprintf oc "\tlw\t%s, %d(%s)\t\t\t\t#lfd\t%s, %d(%s)\n" (reg reg_tmp) z (reg y) (reg x) z (reg y);
                                Printf.fprintf oc "\tfmvfr\t%s, %s\n" (reg x) (reg reg_tmp)
  | NonTail(_), Stfd(x, y, V(z)) -> Printf.fprintf oc "\tstfdx\t%s, %s, %s\n" (reg x) (reg y) (reg z)                  (** �ɤ����뤫̤�� **)
  | NonTail(_), Stfd(x, y, C(z)) -> Printf.fprintf oc "\tfmvtr\t%s, %s\n" (reg reg_tmp) (reg x);
                                    Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_tmp) z (reg y)
  | NonTail(_), Comment(s) -> Printf.fprintf oc "#\t%s\n" s
  (* ����β���̿��μ��� (caml2html: emit_save) *)
  | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y;
      Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
  | NonTail(_), Save(x, y) when List.mem x allfregs && not (S.mem y !stackset) ->
      savef y;
      Printf.fprintf oc "\tfmvtr\t%s, %s\n" (reg reg_tmp) (reg x);
      Printf.fprintf oc "\tsw\t%s, %d(%s)\t\t\t\t#stfd\t%s, %d(%s)\n" (reg reg_tmp) (offset y) (reg reg_sp) (reg x) (offset y) (reg reg_sp)
  | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); ()
  (* �����β���̿��μ��� (caml2html: emit_restore) *)
  | NonTail(x), Restore(y) when List.mem x allregs ->
      Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
  | NonTail(x), Restore(y) ->
      assert (List.mem x allfregs);
      Printf.fprintf oc "\tlw\t%s, %d(%s)\t\t\t\t#lfd\t%s, %d(%s)\n" (reg reg_tmp) (offset y) (reg reg_sp) (reg x) (offset y) (reg reg_sp);
      Printf.fprintf oc "\tfmvfr\t%s, %s\n" (reg x) (reg reg_tmp)
  (* �������ä���׻���̤����쥸�����˥��åȤ��ƥ꥿���� (caml2html: emit_tailret) *)
  | Tail, (Nop | Stw _ | Stfd _ | Comment _ | Save _ as exp) ->
      g' oc (NonTail(Id.gentmp Type.Unit), exp);
      Printf.fprintf oc "\tjalr\t%s\t\t\t\t#\tblr\n" (reg reg_lr);
  | Tail, (Li _ | SetL _ | Mr _ | Neg _ | Add _ | Sub _ | Slw _ | Lwz _ as exp) ->
      g' oc (NonTail(regs.(0)), exp);
      Printf.fprintf oc "\tjalr\t%s\t\t\t\t#\tblr\n" (reg reg_lr);
  | Tail, (FLi _ | FMr _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ | Lfd _ as exp) ->
      g' oc (NonTail(fregs.(0)), exp);
      Printf.fprintf oc "\tjalr\t%s\t\t\t\t#\tblr\n" (reg reg_lr);
  | Tail, (Restore(x) as exp) ->
      (match locate x with
      | [i] -> g' oc (NonTail(regs.(0)), exp)
      | [i; j] when i + 1 = j -> g' oc (NonTail(fregs.(0)), exp)
      | _ -> assert false);
      Printf.fprintf oc "\tjalr\t%s\t\t\t\t#\tblr\n" (reg reg_lr);
  | Tail, IfEq(x, V(y), e1, e2) -> (**)
      g'_tail_if oc e1 e2 "beq" "bne" x y
(*  | Tail, IfEq(x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d\n" (reg x) y;
      g'_tail_if oc e1 e2 "beq" "bne"
*)
  | Tail, IfLE(x, V(y), e1, e2) -> (**)
      g'_tail_if oc e1 e2 "ble" "bgt" x y
(* | Tail, IfLE(x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d\n" (reg x) y;
      g'_tail_if oc e1 e2 "ble" "bgt"
*)
  | Tail, IfGE(x, V(y), e1, e2) -> (**)
      g'_tail_if oc e1 e2 "bge" "blt" x y
(* | Tail, IfGE(x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d\n" (reg x) y;
      g'_tail_if oc e1 e2 "bge" "blt"
*)
  | Tail, IfFEq(x, y, e1, e2) -> (**)
      g'_tail_if oc e1 e2 "beq" "bne" x y
  | Tail, IfFLE(x, y, e1, e2) -> (**)
      g'_tail_if oc e1 e2 "ble" "bgt" x y
  | NonTail(z), IfEq(x, V(y), e1, e2) -> (**)
      g'_non_tail_if oc (NonTail(z)) e1 e2 "beq" "bne" x y
(* | NonTail(z), IfEq(x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d\n" (reg x) y;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "beq" "bne"
*)
  | NonTail(z), IfLE(x, V(y), e1, e2) -> (**)
      g'_non_tail_if oc (NonTail(z)) e1 e2 "ble" "bgt" x y
(* | NonTail(z), IfLE(x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d\n" (reg x) y;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "ble" "bgt"
*)
  | NonTail(z), IfGE(x, V(y), e1, e2) -> (**)
      g'_non_tail_if oc (NonTail(z)) e1 e2 "bge" "blt" x y
(* | NonTail(z), IfGE(x, C(y), e1, e2) ->
      Printf.fprintf oc "\tcmpwi\tcr7, %s, %d\n" (reg x) y;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "bge" "blt"
*)
  | NonTail(z), IfFEq(x, y, e1, e2) -> (**)
      g'_non_tail_if oc (NonTail(z)) e1 e2 "beq" "bne" x y
  | NonTail(z), IfFLE(x, y, e1, e2) -> (**)
      g'_non_tail_if oc (NonTail(z)) e1 e2 "ble" "bgt" x y
  (* �ؿ��ƤӽФ��β���̿��μ��� (caml2html: emit_call) *)
  | Tail, CallCls(x, ys, zs) -> (* �����ƤӽФ� (caml2html: emit_tailcall) *)
      g'_args oc [(x, reg_cl)] ys zs;
      Printf.fprintf oc "\tlw\t%s, 0(%s)\n" (reg reg_sw) (reg reg_cl);
      Printf.fprintf oc "\tjalr\t%s\n" (reg reg_sw);
(*      Printf.fprintf oc "\tmtctr\t%s\n\tbctr\n" (reg reg_sw);*)                  (***** ����������ؤǤ��Ƥ��뤫������ *****)
  | Tail, CallDir(Id.L(x), ys, zs) -> (* �����ƤӽФ� *)
      g'_args oc [] ys zs;
      Printf.fprintf oc "\tble\tr0, r0, %s\n" x
(*      Printf.fprintf oc "\tb\t%s\n" x*) (* ñ�ʤ른���� ble r0 r31 ������ *)
  | NonTail(a), CallCls(x, ys, zs) ->
      Printf.fprintf oc "\taddi\t%s, %s, 0\t\t\t\t#mflr\t%s\n" (reg reg_tmp) (reg reg_lr) (reg reg_tmp);
      g'_args oc [(x, reg_cl)] ys zs;
      let ss = stacksize () in
      Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 4) (reg reg_sp);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tlw\t%s, 0(%s)\n" (reg reg_tmp) (reg reg_cl);
      Printf.fprintf oc "\tjalr\t%s\n" (reg reg_tmp);   (** ������äƤ���󤯤ʤ����������� **)
(*    Printf.fprintf oc "\tmtctr\t%s\n" (reg reg_tmp);*)
(*      Printf.fprintf oc "\tbctrl\n";*)
      Printf.fprintf oc "\taddi\t%s, r0, %d\n" (reg reg_tmp) ss;
      Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg reg_sp) (reg reg_sp) (reg reg_tmp);
      Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 4) (reg reg_sp);
      if List.mem a allregs && a <> regs.(0) then
        Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t# mr\t%s, %s\n" (reg a) (reg regs.(0)) (reg a) (reg regs.(0))
      else if List.mem a allfregs && a <> fregs.(0) then
        Printf.fprintf oc "\tfadd\t%s, f0, %s\t\t\t\t# fmr\t%s, %s\n" (reg a) (reg fregs.(0)) (reg a) (reg fregs.(0));
      Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t#mtlr\t%s\n" (reg reg_lr) (reg reg_tmp) (reg reg_tmp)
  | (NonTail(a), CallDir(Id.L(x), ys, zs)) ->
      Printf.fprintf oc "\taddi\t%s, %s, 0\t\t\t\t#mflr\t%s\n" (reg reg_tmp) (reg reg_lr) (reg reg_tmp);
      g'_args oc [] ys zs;
      let ss = stacksize () in
      Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 4) (reg reg_sp);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tjal\t%s\t\t\t\t#\tbl\t%s\n" x x;
      Printf.fprintf oc "\taddi\t%s, r0, %d\n" (reg reg_tmp) ss;
      Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg reg_sp) (reg reg_sp) (reg reg_tmp);
      Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 4) (reg reg_sp);
      if List.mem a allregs && a <> regs.(0) then
        Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t# mr\t%s, %s\n" (reg a) (reg regs.(0)) (reg a) (reg regs.(0))
      else if List.mem a allfregs && a <> fregs.(0) then
        Printf.fprintf oc "\tfadd\t%s, f0, %s\t\t\t\t# fmr\t%s, %s\n" (reg a) (reg fregs.(0)) (reg a) (reg fregs.(0));
      Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t#mtlr\t%s\n" (reg reg_lr) (reg reg_tmp) (reg reg_tmp)
and g'_tail_if oc e1 e2 b bn x y =
  let b_then = Id.genid (b ^ "_then") in
  Printf.fprintf oc "\t%s\t%s, %s, %s\n" b (reg x) (reg y) b_then;
  let stackset_back = !stackset in
  g oc (Tail, e2);
  Printf.fprintf oc "%s:\n" b_then;
  stackset := stackset_back;
  g oc (Tail, e1)
and g'_non_tail_if oc dest e1 e2 b bn x y = 
  let b_then = Id.genid (b ^ "_then") in
  let b_cont = Id.genid (b ^ "_cont") in
  Printf.fprintf oc "\t%s\t%s, %s, %s\n" b (reg x) (reg y) b_then;
  let stackset_back = !stackset in
  g oc (dest, e2);
  let stackset1 = !stackset in
  Printf.fprintf oc "\tble\tr0, r31, %s\n" b_cont;
  Printf.fprintf oc "%s:\n" b_then;
  stackset := stackset_back;
  g oc (dest, e1);
  Printf.fprintf oc "%s:\n" b_cont;
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2
and g'_args oc x_reg_cl ys zs =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
  List.iter
    (fun (y, r) -> Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t# mr\t%s, %s\n" (reg r) (reg y) (reg r) (reg y))
    (shuffle reg_sw yrs);
  let (d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  List.iter
    (fun (z, fr) -> Printf.fprintf oc "\tfadd\t%s, f0, %s\t\t\t\t# fmr\t%s, %s\n" (reg fr) (reg z) (reg fr) (reg z))
    (shuffle reg_fsw zfrs)

let h oc { name = Id.L(x); args = _; fargs = _; body = e; ret = _ } =
  Printf.fprintf oc "%s:\n" x;
  stackset := S.empty;
  stackmap := [];
  g oc (Tail, e)

let f oc (Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
(*  if data <> [] then
    (Printf.fprintf oc "\t.data\n\t.literal8\n";
     List.iter
       (fun (Id.L(x), d) ->
         Printf.fprintf oc "\t.align 3\n";
         Printf.fprintf oc "%s:\t # %f\n" x d;
         Printf.fprintf oc "\t.long\t%ld\n" (gethi d);
         Printf.fprintf oc "\t.long\t%ld\n" (getlo d))
       data);
  Printf.fprintf oc "\t.text\n";
  Printf.fprintf oc "\t.globl _min_caml_start\n";
*)
(*  Printf.fprintf oc "\t.align 2\n";*)
  List.iter (fun fundef -> h oc fundef) fundefs;
  Printf.fprintf oc "_min_caml_start: # main entry point\n";
(*  Printf.fprintf oc "\tadd\tr0, r0, %s\t\t\t\t#mflr\tr0\n" (reg reg_lr);
  Printf.fprintf oc "\tstmw\tr30, -8(r1)\n";
  Printf.fprintf oc "\tsw\tr0, 8(r1)\n";
  Printf.fprintf oc "\tsw\tr1, -96(r1)\n"; (*Printf.fprintf oc "\tswu\tr1, -96(r1)\n";*)
*)
  Printf.fprintf oc "#\tmain program starts\n";
  stackset := S.empty;
  stackmap := [];
  g oc (NonTail("_R_0"), e);
(*  Printf.fprintf oc "#\tmain program ends\n";
  (* Printf.fprintf oc "\tmr\tr3, %s\n" regs.(0); *)
  Printf.fprintf oc "\tlw\tr1, 0(r1)\n";
  Printf.fprintf oc "\tlw\tr0, 8(r1)\n";
  Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t#mtlr\tr0\n" (reg reg_lr);
(*  Printf.fprintf oc "\tlmw\tr30, -8(r1)\n";*)
*)
(*
  Printf.fprintf oc "\tjalr\t%s\t\t\t\t#\tblr\n" (reg reg_lr)
*)
