open Asm

external gethi : float -> int32 = "gethi"
external getlo : float -> int32 = "getlo"
external internal_of_float : float -> int32 = "internal_of_float"

let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)
let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)

let get_ftable f =
  match f with
  | _ -> 0

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
let offset x = List.hd (locate x)
let stacksize () = align ((List.length !stackmap + 1))

let reg r =
  if is_reg r
  then String.sub r 1 (String.length r - 1)
  else r

let load_label r label =
  let r' = reg r in
  Printf.sprintf
  "\taddi\t%s, r0, %s\n" r' label


let load_globals_label r label =
  let r' = reg r in
  Printf.sprintf
  "\taddi\t%s, r0, %d\t\t\t\t# set %s\n" r' (M.find label Glbarray.table) label
(*  "\tlis\t%s, ha16(%s)\n\taddi\t%s, %s, lo16(%s)\n"
    r' label r' r' label
*)


(* 関数呼び出しのために引数を並べ替える(register shuffling) (caml2html: emit_shuffle) *)
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

type dest = Tail | NonTail of Id.t (* 末尾かどうかを表すデータ型 (caml2html: emit_dest) *)
let rec g oc = function (* 命令列のアセンブリ生成 (caml2html: emit_g) *)
  | dest, Ans(exp) -> g' oc (dest, exp)
  | dest, Let((x, t), exp, e) ->
      g' oc (NonTail(x), exp);
      g oc (dest, e)
and g' oc = function (* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  | NonTail(_), Nop -> ()
  | NonTail(x), Li(i) when -32768 <= i && i < 32768 -> Printf.fprintf oc "\taddi\t%s, r0, %d\n" (reg x) i
  | NonTail(x), Li(i) ->                                                                        (**)
      let n = i lsr 16 in
      let m = (i lsl 47) lsr 47 in
      let r = reg x in
      Printf.fprintf oc "\taddi\t%s, r0, %d\n" r m;
      Printf.fprintf oc "\tlui\t%s, %s, %d\n" r r n
  | NonTail(x), FLi(d) ->
      if (Ftable.mem d (!Virtual.ftable)) then
        Printf.fprintf oc "\tflup\t%s, %d\t\t# fli\t%s, %f\n" (reg x) (Ftable.find d (!Virtual.ftable)) (reg x) (d)
      else (
        let f = internal_of_float d in
        let n = (Int32.shift_right_logical (Int32.shift_left f 16) 16) in        (** 15かも? **)
        let m = Int32.shift_right_logical f 16 in
        Printf.fprintf oc "\taddi\t%s, r0, %ld\n" (reg reg_tmp) n;
        Printf.fprintf oc "\tlui\t%s, %s, %ld\t# to load float\t\t%f\n" (reg reg_tmp) (reg reg_tmp) m d;
        Printf.fprintf oc "\tfmvfr\t%s, %s\n" (reg x) (reg reg_tmp)
      )
  | NonTail(x), SetL(Id.L(y)) ->
      let s = load_label x y in
      Printf.fprintf oc "%s" s
  | NonTail(x), SetGlb(Id.L(y)) ->
      let s = load_globals_label x y in
      Printf.fprintf oc "%s" s
  | NonTail(x), Mr(y) when x = y -> ()
  | NonTail(x), Mr(y) -> Printf.fprintf oc "\tadd\t%s, r0, %s\n" (reg x) (reg y)
  | NonTail(x), Neg(y) -> Printf.fprintf oc "\tsub\t%s, r0, %s\n" (reg x) (reg y)
  | NonTail(x), Add(y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), Add(y, C(z)) -> Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg x) (reg y) z
  | NonTail(x), Sub(y, V(z)) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), Sub(y, C(z)) -> Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg x) (reg y) (-z)
  | NonTail(x), Lw(y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg reg_tmp) (reg y) (reg z);
                                Printf.fprintf oc "\tlw\t%s, 0(%s)\n" (reg x) (reg reg_tmp)
  | NonTail(x), Lw(y, C(z)) -> Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) z (reg y)
  | NonTail(_), Sw(x, y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg reg_tmp) (reg y) (reg z);
                                   Printf.fprintf oc "\tsw\t%s, 0(%s)\n" (reg x) (reg reg_tmp)   
  | NonTail(_), Sw(x, y, C(z)) -> Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg x) z (reg y)
  | NonTail(x), FMr(y) when x = y -> ()
  | NonTail(x), FMr(y) -> Printf.fprintf oc "\tfadd\t%s, f0, %s\n" (reg x) (reg y)
  | NonTail(x), FNeg(y) -> Printf.fprintf oc "\tfneg\t%s, %s\n" (reg x) (reg y)
  | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\tfadd\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\tfsub\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\tfmul\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), FDiv(y, z) -> Printf.fprintf oc "\tfdiv\t%s, %s, %s\n" (reg x) (reg y) (reg z)
  | NonTail(x), FLw(y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg reg_tmp) (reg y) (reg z);
                                Printf.fprintf oc "\tflw\t%s, 0(%s)\n" (reg x) (reg reg_tmp)
  | NonTail(x), FLw(y, C(z)) -> Printf.fprintf oc "\tflw\t%s, %d(%s)\n" (reg x) z (reg y)
  | NonTail(_), FSw(x, y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg reg_tmp) (reg y) (reg z);
                                    Printf.fprintf oc "\tfsw\t%s, 0(%s)\n" (reg x) (reg reg_tmp)
  | NonTail(_), FSw(x, y, C(z)) -> Printf.fprintf oc "\tfsw\t%s, %d(%s)\n" (reg x) z (reg y)
  | NonTail(_), Comment(s) -> Printf.fprintf oc "#\t%s\n" s
  (* 退避の仮想命令の実装 (caml2html: emit_save) *)
  | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y;
      Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
  | NonTail(_), Save(x, y) when List.mem x allfregs && not (S.mem y !stackset) ->
      savef y;
      Printf.fprintf oc "\tfsw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
  | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); ()
  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
  | NonTail(x), Restore(y) when List.mem x allregs ->
      Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
  | NonTail(x), Restore(y) ->
      assert (List.mem x allfregs);
      Printf.fprintf oc "\tflw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
  (* 末尾だったら計算結果を第一レジスタにセットしてリターン (caml2html: emit_tailret) *)
  | Tail, (Nop | Sw _ | FSw _ | Comment _ | Save _ as exp) ->
      g' oc (NonTail(Id.gentmp Type.Unit), exp);
      Printf.fprintf oc "\tjr\t%s\t\t\t\t#\n" (reg reg_lr);
  | Tail, (Li _ | SetL _ | Mr _ | Neg _ | Add _ | Sub _ | Lw _ | Sra _ | Sll _ | Srl _ | In _ | Out _ | ItoF _ as exp) ->
      g' oc (NonTail(regs.(0)), exp);
      Printf.fprintf oc "\tjr\t%s\t\t\t\t#\n" (reg reg_lr);
  | Tail, (FLi _ | FMr _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ | FLw _ | FSqrt _ | FtoI _ as exp) ->
      g' oc (NonTail(fregs.(0)), exp);
      Printf.fprintf oc "\tjr\t%s\t\t\t\t#\n" (reg reg_lr);
  | Tail, (Restore(x) as exp) ->
      (match locate x with
      | [i] -> g' oc (NonTail(regs.(0)), exp)
      | [i; j] when i + 1 = j -> g' oc (NonTail(fregs.(0)), exp)
      | _ -> assert false);
      Printf.fprintf oc "\tjr\t%s\t\t\t\t#\n" (reg reg_lr);
  | Tail, IfEq(x, V(y), e1, e2) -> (**)
      g'_tail_if oc e1 e2 "beq" x y
  | Tail, IfEq(x, C(y), e1, e2) ->
      g'_tail_if_i oc e1 e2 "beq" x y

  | Tail, IfLE(x, V(y), e1, e2) -> (**)
      g'_tail_if oc e1 e2 "ble" x y
  | Tail, IfLE(x, C(y), e1, e2) ->
      g'_tail_if_i oc e1 e2 "ble" x y

  | Tail, IfGE(x, V(y), e1, e2) -> (**)
      g'_tail_if oc e2 e1 "blt" x y
  | Tail, IfGE(x, C(y), e1, e2) ->
      g'_tail_if_i oc e1 e2 "bge" x y

  | Tail, IfFEq(x', y', e1, e2) -> (**)
      (match x', y' with
      | V(x), V(y) -> g'_tail_if_f oc e1 e2 "feq" x y
      | FC(0.0), V(y) -> g'_tail_if_f oc e1 e2 "feq" "%f0" y
      | V(x), FC(0.0) -> g'_tail_if_f oc e1 e2 "feq" x "%f0"
      | FC(0.0), FC(0.0) -> g'_tail_if_f oc e1 e2 "feq" "%f0" "%f0"
      | _ -> failwith ("something along IfFEq went wrong")
      )
  | Tail, IfFLE(x', y', e1, e2) -> (**)
      (match x', y' with
      | V(x), V(y) -> g'_tail_if_f oc e1 e2 "fle" x y
      | FC(0.0), V(y) -> g'_tail_if_f oc e1 e2 "fle" "%f0" y
      | V(x), FC(0.0) -> g'_tail_if_f oc e1 e2 "fle" x "%f0"
      | FC(0.0), FC(0.0) -> g'_tail_if_f oc e1 e2 "fle" "%f0" "%f0"
      | _ -> failwith ("something along IfFLE went wrong")
      )
  | NonTail(z), IfEq(x, V(y), e1, e2) -> (**)
      g'_non_tail_if oc (NonTail(z)) e1 e2 "beq" x y
  | NonTail(z), IfEq(x, C(y), e1, e2) ->
      g'_non_tail_if_i oc (NonTail(z)) e1 e2 "beq" x y
  | NonTail(z), IfLE(x, V(y), e1, e2) -> (**)
      g'_non_tail_if oc (NonTail(z)) e1 e2 "ble" x y
  | NonTail(z), IfLE(x, C(y), e1, e2) ->
      g'_non_tail_if_i oc (NonTail(z)) e1 e2 "ble" x y
  | NonTail(z), IfGE(x, V(y), e1, e2) -> (**)
      g'_non_tail_if oc (NonTail(z)) e1 e2 "bge" x y
  | NonTail(z), IfGE(x, C(y), e1, e2) ->
      g'_non_tail_if_i oc (NonTail(z)) e1 e2 "bge" x y
  | NonTail(z), IfFEq(x', y', e1, e2) -> (**)
      (match x', y' with
      | V(x), V(y) -> g'_non_tail_if_f oc (NonTail(z)) e1 e2 "feq" x y
      | FC(0.0), V(y) -> g'_non_tail_if_f oc (NonTail(z)) e1 e2 "feq" "%f0" y
      | V(x), FC(0.0) -> g'_non_tail_if_f oc (NonTail(z)) e1 e2 "feq" x "%f0"
      | FC(0.0), FC(0.0) -> g'_non_tail_if_f oc (NonTail(z)) e1 e2 "feq" "%f0" "%f0"
      | _ -> failwith ("something along IfFEq went wrong")
      )
  | NonTail(z), IfFLE(x', y', e1, e2) -> (**)
      (match x', y' with
      | V(x), V(y) -> g'_non_tail_if_f oc (NonTail(z)) e1 e2 "fle" x y
      | FC(0.0), V(y) -> g'_non_tail_if_f oc (NonTail(z)) e1 e2 "fle" "%f0" y
      | V(x), FC(0.0) -> g'_non_tail_if_f oc (NonTail(z)) e1 e2 "fle" x "%f0"
      | FC(0.0), FC(0.0) -> g'_non_tail_if_f oc (NonTail(z)) e1 e2 "fle" "%f0" "%f0"
      | _ -> failwith ("something along IfFLE went wrong")
      )
  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
  | Tail, CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      g'_args oc [(x, reg_cl)] ys zs;
      Printf.fprintf oc "\tlw\t%s, 0(%s)\n" (reg reg_sw) (reg reg_cl);
      Printf.fprintf oc "\tjr\t%s\n" (reg reg_sw);
(*      Printf.fprintf oc "\tmtctr\t%s\n\tbctr\n" (reg reg_sw);*)
  | Tail, CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      g'_args oc [] ys zs;
      Printf.fprintf oc "\tj\t%s\n" x
(*      Printf.fprintf oc "\tb\t%s\n" x*) (* 単なるジャンプ ble r0 r31 で代用 *)
  | NonTail(a), CallCls(x, ys, zs) ->
(*      Printf.fprintf oc "\taddi\t%s, %s, 0\t\t\t\t#mflr\t%s\n" (reg reg_tmp) (reg reg_lr) (reg reg_tmp); *)
      g'_args oc [(x, reg_cl)] ys zs;
      let ss = stacksize () in
(*      Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 1) (reg reg_sp); *)
      Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_lr) (ss - 1) (reg reg_sp); 
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tlw\t%s, 0(%s)\n" (reg reg_tmp) (reg reg_cl);
      Printf.fprintf oc "\tjalr\t%s\n" (reg reg_tmp);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) (-ss);
(*      Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 1) (reg reg_sp); *)
      Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_lr) (ss - 1) (reg reg_sp);
      if List.mem a allregs && a <> regs.(0) then
        Printf.fprintf oc "\tadd\t%s, r0, %s\n" (reg a) (reg regs.(0))
      else if List.mem a allfregs && a <> fregs.(0) then
        Printf.fprintf oc "\tfadd\t%s, f0, %s\n" (reg a) (reg fregs.(0))
(*      Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t#mtlr\t%s\n" (reg reg_lr) (reg reg_tmp) (reg reg_tmp) *)
  | (NonTail(a), CallDir(Id.L(x), ys, zs)) ->
(*      Printf.fprintf oc "\taddi\t%s, %s, 0\t\t\t\t#mflr\t%s\n" (reg reg_tmp) (reg reg_lr) (reg reg_tmp); *)
      g'_args oc [] ys zs;
      let ss = stacksize () in
(*      Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 1) (reg reg_sp); *)
      Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_lr) (ss - 1) (reg reg_sp);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tjal\t%s\t\t\t\t\n" x;
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) (-ss);
(*      Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 1) (reg reg_sp); *)
      Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_lr) (ss - 1) (reg reg_sp);
      if List.mem a allregs && a <> regs.(0) then
        Printf.fprintf oc "\tadd\t%s, r0, %s\n" (reg a) (reg regs.(0))
      else if List.mem a allfregs && a <> fregs.(0) then
        Printf.fprintf oc "\tfadd\t%s, f0, %s\n" (reg a) (reg fregs.(0))
(*      Printf.fprintf oc "\tadd\t%s, r0, %s\t\t\t\t#mtlr\t%s\n" (reg reg_lr) (reg reg_tmp) (reg reg_tmp) *)
  | NonTail(x), Sll(y, V(z)) -> Printf.fprintf oc "\tsll\t%s, %s, %s\n" (reg x) (reg y) (reg z) (**)
  | NonTail(x), Sll(y, C(z)) -> Printf.fprintf oc "\tslli\t%s, %s, %d\n" (reg x) (reg y) z      (**)
  | NonTail(x), Srl(y, V(z)) -> Printf.fprintf oc "\tsrl\t%s, %s, %s\n" (reg x) (reg y) (reg z) (**)
  | NonTail(x), Srl(y, C(z)) -> Printf.fprintf oc "\tsrli\t%s, %s, %d\n" (reg x) (reg y) z      (**)
  | NonTail(x), Sra(y, V(z)) -> Printf.fprintf oc "\tsra\t%s, %s, %s\n" (reg x) (reg y) (reg z) (**)
  | NonTail(x), Sra(y, C(z)) -> Printf.fprintf oc "\tsrai\t%s, %s, %d\n" (reg x) (reg y) z      (**)
  | NonTail(_), In(x) -> Printf.fprintf oc "\tin\t%s\n" (reg x)     (**)
  | NonTail(_), Out(x) -> Printf.fprintf oc "\tout\t%s\n" (reg x)     (**)
  | NonTail(x), FSqrt(y) -> Printf.fprintf oc "\tfsqrt\t%s, %s\n" (reg x) (reg y)    (**)
  | NonTail(x), FtoI(y) -> Printf.fprintf oc "\tftoi\t%s, %s\n" (reg x) (reg y)    (**)
  | NonTail(x), ItoF(y) -> Printf.fprintf oc "\titof\t%s, %s\n" (reg x) (reg y)    (**)
  | _ -> failwith("something went wrong")
and g'_tail_if oc e1 e2 b x y =
  let b_then = Id.genid (b ^ "_then") in
  Printf.fprintf oc "\t%s\t%s, %s, %s\n" b (reg x) (reg y) b_then;
  let stackset_back = !stackset in
  g oc (Tail, e2);
  Printf.fprintf oc "%s:\n" b_then;
  stackset := stackset_back;
  g oc (Tail, e1)
and g'_tail_if_i oc e1 e2 b x y =
  let b_then = Id.genid (b ^ "_then") in
  Printf.fprintf oc "\t%s\t%d, %s, %s\n" (b^"i") y (reg x) b_then;
  let stackset_back = !stackset in
  g oc (Tail, e2);
  Printf.fprintf oc "%s:\n" b_then;
  stackset := stackset_back;
  g oc (Tail, e1)
and g'_non_tail_if oc dest e1 e2 b x y = 
  let b_then = Id.genid (b ^ "_then") in
  let b_cont = Id.genid (b ^ "_cont") in
  Printf.fprintf oc "\t%s\t%s, %s, %s\n" b (reg x) (reg y) b_then;
  let stackset_back = !stackset in
  g oc (dest, e2);
  let stackset1 = !stackset in
  Printf.fprintf oc "\tj\t%s\n" b_cont;
  Printf.fprintf oc "%s:\n" b_then;
  stackset := stackset_back;
  g oc (dest, e1);
  Printf.fprintf oc "%s:\n" b_cont;
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2
and g'_non_tail_if_i oc dest e1 e2 b x y = 
  let b_then = Id.genid (b ^ "_then") in
  let b_cont = Id.genid (b ^ "_cont") in
  Printf.fprintf oc "\t%s\t%d, %s, %s\n" (b^"i") y (reg x) b_then;
  let stackset_back = !stackset in
  g oc (dest, e2);
  let stackset1 = !stackset in
  Printf.fprintf oc "\tj\t%s\n" b_cont;
  Printf.fprintf oc "%s:\n" b_then;
  stackset := stackset_back;
  g oc (dest, e1);
  Printf.fprintf oc "%s:\n" b_cont;
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2
and g'_tail_if_f oc e1 e2 b x y =
  let b_else = Id.genid (b ^ "_else") in
  Printf.fprintf oc "\t%s\t%s, %s, %s\n" b (reg reg_tmp) (reg x) (reg y);
  Printf.fprintf oc "\tbeq\tr0, %s, %s\n" (reg reg_tmp) b_else;
  let stackset_back = !stackset in
  g oc (Tail, e1);
  Printf.fprintf oc "%s:\n" b_else;
  stackset := stackset_back;
  g oc (Tail, e2)
and g'_non_tail_if_f oc dest e1 e2 b x y = 
  let b_else = Id.genid (b ^ "_else") in
  let b_cont = Id.genid (b ^ "_cont") in
  Printf.fprintf oc "\t%s\t%s, %s, %s\n" b (reg reg_tmp) (reg x) (reg y);
  Printf.fprintf oc "\tbeq\tr0, %s, %s\n" (reg reg_tmp) b_else;
  let stackset_back = !stackset in
  g oc (dest, e1);
  let stackset1 = !stackset in
  Printf.fprintf oc "\tj\t%s\n" b_cont;
  Printf.fprintf oc "%s:\n" b_else;
  stackset := stackset_back;
  g oc (dest, e2);
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
    (fun (y, r) -> Printf.fprintf oc "\tadd\t%s, r0, %s\n" (reg r) (reg y))
    (shuffle reg_sw yrs);
  let (d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  List.iter
    (fun (z, fr) -> Printf.fprintf oc "\tfadd\t%s, f0, %s\n" (reg fr) (reg z))
    (shuffle reg_fsw zfrs)

let h oc { name = Id.L(x); args = _; fargs = _; body = e; ret = _ } =
  Printf.fprintf oc "%s:\n" x;
  stackset := S.empty;
  stackmap := [];
  g oc (Tail, e)

let cat ic oc =
  let rec cat_sub () =
    output_char oc (input_char ic);
    cat_sub ()
  in
    try cat_sub () with End_of_file -> close_in ic


let f oc (Prog(data, fundefs, e)) =
  let lib = open_in "lib.s" in
  let init = open_in "init.s" in
  Format.eprintf "generating assembly...@.";
  (*
  if data <> [] then
    (Printf.fprintf oc "\t.data\n\t.literal8\n";
     List.iter
       (fun (Id.L(x), d) ->
         Printf.fprintf oc "\t.align 3\n";
         Printf.fprintf oc "%s:\t # %f\n" x d;
         Printf.fprintf oc "\t.long\t%ld\n" (gethi d);
         Printf.fprintf oc "\t.long\t%ld\n" (getlo d))
       data);
    
  *)
  Printf.fprintf oc "\t.text\n";
  Printf.fprintf oc "\t.globl _min_caml_start\n";
  cat lib oc;
  Printf.fprintf oc "# library ends\n";
(*  Printf.fprintf oc "\t.align 2\n";*)
  List.iter (fun fundef -> h oc fundef) fundefs;
  Printf.fprintf oc "_R_0:\n";
  Printf.fprintf oc "_min_caml_start: # main entry point\n";
(*  Printf.fprintf oc "\tadd\tr0, r0, %s\t\t\t\t#mflr\tr0\n" (reg reg_lr);
  Printf.fprintf oc "\tstmw\tr30, -8(r1)\n";
  Printf.fprintf oc "\tsw\tr0, 8(r1)\n";
  Printf.fprintf oc "\tsw\tr1, -96(r1)\n"; (*Printf.fprintf oc "\tswu\tr1, -96(r1)\n";*)
*)
  cat init oc;
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
  Printf.fprintf oc "\tjalr\t%s\t\t\t\t#\n" (reg reg_lr)
*)
