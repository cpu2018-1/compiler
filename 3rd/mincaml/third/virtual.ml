(* translation into PowerPC assembly with infinite number of virtual registers *)

open Asm

let print = ref false

let ftable = ref Ftable.empty

(* Ftableに値を設定 *)
let set_ftable () = 
ftable := Ftable.add_float 0.000000 !ftable;
ftable := Ftable.add_float 0.500000 !ftable;
ftable := Ftable.add_float 1.000000 !ftable;
ftable := Ftable.add_float 2.000000 !ftable;
ftable := Ftable.add_float 3.141593 !ftable;
ftable := Ftable.add_float 6.283185 !ftable;
ftable := Ftable.add_float 0.166667 !ftable;
ftable := Ftable.add_float 0.008333 !ftable;
ftable := Ftable.add_float 0.000196 !ftable;
ftable := Ftable.add_float 0.041664 !ftable;
ftable := Ftable.add_float 0.001370 !ftable;
ftable := Ftable.add_float (-1.000000) !ftable;
ftable := Ftable.add_float 1.570796 !ftable;
ftable := Ftable.add_float 0.785398 !ftable;
ftable := Ftable.add_float 3.141597 !ftable;
ftable := Ftable.add_float 1.570798 !ftable;
ftable := Ftable.add_float 0.785399 !ftable;
ftable := Ftable.add_float 0.333333 !ftable;
ftable := Ftable.add_float 0.200000 !ftable;
ftable := Ftable.add_float 0.142857 !ftable;
ftable := Ftable.add_float 0.111111 !ftable;
ftable := Ftable.add_float 0.089764 !ftable;
ftable := Ftable.add_float 0.060035 !ftable;
ftable := Ftable.add_float 4.375000 !ftable;
ftable := Ftable.add_float 2.437500 !ftable;
ftable := Ftable.add_float 0.017453 !ftable;
ftable := Ftable.add_float 200.000000 !ftable;
ftable := Ftable.add_float (-200.000000) !ftable;
ftable := Ftable.add_float (-0.200000) !ftable;
ftable := Ftable.add_float 0.010000 !ftable;
ftable := Ftable.add_float (-0.100000) !ftable;
ftable := Ftable.add_float 1000000000.000000 !ftable;
ftable := Ftable.add_float 100000000.000000 !ftable;
ftable := Ftable.add_float 0.000100 !ftable;
ftable := Ftable.add_float 15.000000 !ftable;
ftable := Ftable.add_float 30.000000 !ftable;
ftable := Ftable.add_float 0.150000 !ftable;
ftable := Ftable.add_float 255.000000 !ftable;
ftable := Ftable.add_float 0.300000 !ftable;
ftable := Ftable.add_float 10.000000 !ftable;
ftable := Ftable.add_float 0.250000 !ftable;
ftable := Ftable.add_float 0.050000 !ftable;
ftable := Ftable.add_float 20.000000 !ftable;
ftable := Ftable.add_float 0.003906 !ftable;
ftable := Ftable.add_float (-2.000000) !ftable;
ftable := Ftable.add_float 0.100000 !ftable;
ftable := Ftable.add_float (-150.000000) !ftable;
ftable := Ftable.add_float 150.000000 !ftable;
ftable := Ftable.add_float 0.900000 !ftable;
ftable := Ftable.add_float 128.000000 !ftable
(* ここまで *)

let data = ref [] (* 浮動小数点数の定数テーブル (caml2html: virtual_data) *)

let classify xts ini addf addi =
  List.fold_left
    (fun acc (x, t) ->
      match t with
      | Type.Unit -> acc
      | Type.Float -> addf acc x
      | _ -> addi acc x t)
    ini
    xts

let separate xts =
  classify
    xts
    ([], [])
    (fun (int, float) x -> (int, float @ [x]))
    (fun (int, float) x _ -> (int @ [x], float))

let expand xts ini addf addi =
  classify
    xts
    ini
    (fun (offset, acc) x ->
      let offset = align offset in
      (offset + 1, addf x offset acc))
    (fun (offset, acc) x t ->
      (offset + 1, addi x t offset acc))

let rec g env = function (* 式の仮想マシンコード生成 (caml2html: virtual_g) *)
  | Closure.Unit -> Ans(Nop)
  | Closure.Int(i) -> Ans(Li(i))
  | Closure.Float(d) ->
(*      let l =
        try
          (* すでに定数テーブルにあったら再利用 *)
          let (l, _) = List.find (fun (_, d') -> d = d') !data in
          l
        with Not_found ->
          let l = Id.L(Id.genid "l") in
          data := (l, d) :: !data;
(*          ftable := Ftable.add_float d !ftable; *)
          l in
*)
      Ans(FLi(d))
  | Closure.Neg(x) -> Ans(Neg(x))
  | Closure.Add(x, y) -> Ans(Add(x, V(y)))
  | Closure.Sub(x, y) -> Ans(Sub(x, V(y)))
  | Closure.FNeg(x) -> Ans(FNeg(x))
  | Closure.FAdd(x, y) -> Ans(FAdd(x, y))
  | Closure.FSub(x, y) -> Ans(FSub(x, y))
  | Closure.FMul(x, y) -> Ans(FMul(x, y))
  | Closure.FDiv(x, y) -> Ans(FDiv(x, y))
  | Closure.IfEq(x, y, e1, e2) ->
      (match M.find x env with
      | Type.Bool | Type.Int -> Ans(IfEq(x, V(y), g env e1, g env e2))
      | Type.Float -> Ans(IfFEq(V(x), V(y), g env e1, g env e2))
      | _ -> failwith "equality supported only for bool, int, and float")
  | Closure.IfLE(x, y, e1, e2) ->
      (match M.find x env with
      | Type.Bool | Type.Int -> Ans(IfLE(x, V(y), g env e1, g env e2))
      | Type.Float -> Ans(IfFLE(V(x), V(y), g env e1, g env e2))
      | _ -> failwith "inequality supported only for bool, int, and float")
  | Closure.Let((x, t1), e1, e2) ->
      let e1' = g env e1 in
      let e2' = g (M.add x t1 env) e2 in
      concat e1' (x, t1) e2'
  | Closure.Var(x) ->
      (match M.find x env with
      | Type.Unit -> Ans(Nop)
      | Type.Float -> Ans(FMr(x))
      | _ -> Ans(Mr(x)))
  | Closure.MakeCls((x, t), { Closure.entry = l; Closure.actual_fv = ys }, e2) -> (* クロージャの生成 (caml2html: virtual_makecls) *)
      print_endline x;
      (* Closureのアドレスをセットしてから、自由変数の値をストア *)
      let e2' = g (M.add x t env) e2 in
      let offset, store_fv =
        expand
          (List.map (fun y -> (y, M.find y env)) ys)
          (1, e2')
          (fun y offset store_fv -> seq(FSw(y, x, C(offset)), store_fv))
          (fun y _ offset store_fv -> seq(Stw(y, x, C(offset)), store_fv)) in
      Let((x, t), Mr(reg_hp),
          Let((reg_hp, Type.Int), Add(reg_hp, C(align offset)),
              let z = Id.genid "l" in
              Let((z, Type.Int), SetL(l),
                  seq(Stw(z, x, C(0)),
                      store_fv))))
  | Closure.AppCls(x, ys) ->
      let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
      Ans(CallCls(x, int, float))
  | Closure.AppDir(Id.L(x), ys) ->
      let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
      Ans(CallDir(Id.L(x), int, float))
  | Closure.Tuple(xs) -> (* 組の生成 (caml2html: virtual_tuple) *)
      let y = Id.genid "t" in
      let (offset, store) =
        expand
          (List.map (fun x -> (x, M.find x env)) xs)
          (0, Ans(Mr(y)))
          (fun x offset store -> seq(FSw(x, y, C(offset)), store))
          (fun x _ offset store -> seq(Stw(x, y, C(offset)), store))  in
      Let((y, Type.Tuple(List.map (fun x -> M.find x env) xs)), Mr(reg_hp),
          Let((reg_hp, Type.Int), Add(reg_hp, C(align offset)),
              store))
  | Closure.LetTuple(xts, y, e2) ->
      let s = Closure.fv e2 in
      let (offset, load) =
        expand
          xts
          (0, g (M.add_list xts env) e2)
          (fun x offset load ->
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            fletd(x, FLw(y, C(offset)), load))
          (fun x t offset load ->
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            Let((x, t), Lwz(y, C(offset)), load)) in
      load
  | Closure.Get(x, y) -> (* 配列の読み出し (caml2html: virtual_get) *)
      (match M.find x env with
      | Type.Array(Type.Unit) -> Ans(Nop)
      | Type.Array(Type.Float) ->
              Ans(FLw(x, V(y)))
      | Type.Array(_) ->
              Ans(Lwz(x, V(y)))
      | _ -> assert false)
  | Closure.Put(x, y, z) ->
      (match M.find x env with
      | Type.Array(Type.Unit) -> Ans(Nop)
      | Type.Array(Type.Float) ->
              Ans(FSw(z, x, V(y)))
      | Type.Array(_) ->
              Ans(Stw(z, x, V(y)))
      | _ -> assert false)
  | Closure.ExtArray(Id.L(x)) -> Ans(SetGlb(Id.L("min_caml_" ^ x)))
  | Closure.Sll(x, y) -> Ans(Sll(x, V(y)))
  | Closure.Srl(x, y) -> Ans(Srl(x, V(y)))
  | Closure.Sra(x, y) -> Ans(Sra(x, V(y)))
  | Closure.In(x) -> Ans(In(x))
  | Closure.Out(x) -> Ans(Out(x))
  | Closure.FSqrt(x) -> Ans(FSqrt(x))
  | Closure.FtoI(x) -> Ans(FtoI(x))
  | Closure.ItoF(x) -> Ans(ItoF(x))

(* 関数の仮想マシンコード生成 (caml2html: virtual_h) *)
let h { Closure.name = (Id.L(x), t); Closure.args = yts; Closure.formal_fv = zts; Closure.body = e } =
  let (int, float) = separate yts in
  let (offset, load) =
    expand
      zts
      (1, g (M.add x t (M.add_list yts (M.add_list zts M.empty))) e)
      (fun z offset load -> fletd(z, FLw(x, C(offset)), load))
      (fun z t offset load -> Let((z, t), Lwz(x, C(offset)), load)) in
  match t with
  | Type.Fun(_, t2) ->
      { name = Id.L(x); args = int; fargs = float; body = load; ret = t2 }
  | _ -> assert false

(* プログラム全体の仮想マシンコード生成 (caml2html: virtual_f) *)
let f (Closure.Prog(fundefs, e)) =
 data := [];
  set_ftable ();
  let fundefs = List.map h fundefs in
  let e = g M.empty e in
  (if (!print) then (
    Printf.printf ("Prog before register allocation\n");
    List.iter (fun f -> print_newline (); Asm.print_fundef f) fundefs;
    print_newline ();
    Asm.print_t 1 e
  )
  else ()
  )
  ;
  Prog(!data, fundefs, e)
