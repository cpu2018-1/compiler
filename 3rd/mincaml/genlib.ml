
(* float (1) *)
(* fequal -> 使われていない(正直良くわからない) *)
(* fless -> 型推論で整数演算にみなされるので
            アセンブリ書いた *)


let rec fispos x = x > 0.0 in
let rec fisneg x = x < 0.0 in
let rec fiszero x = (x = 0.0) in


(* int -> 特に実装するところはなさそう *)


(* logic *)
let rec xor x y =
  x <> y
in

(* not -> パースでなんとかできる *)
(* float (2) *)
let rec fhalf x = x *. 0.5 in
let rec fsqr x = x *. x in

let rec fabs a =
  asm_out (48);
  if (a < 0.0) then
    (-.a)
  else
    a
in

(* いろいろめんどくさい問題が起きたのでアセンブリ直接書いた
let rec fneg a =
  (-.a)
in
*)


(* sqrt -> 直接アセンブリ書いた *)


let rec int_of_float a = 
(*
  if (a = 0.0) then
    0
  else if (a >= 0.0) then
    asm_ftoi (a -. 0.5)
  else
    asm_ftoi (a +. 0.5)
    *)
  asm_ftoi a
in

let rec float_of_int a =
  asm_itof a
in

let rec floor x =
  let y = float_of_int (int_of_float x) in
  if x < y then
    y -. 1.0
  else
    y
in

(* sin / cos / atan *)
let rec modulo_2pi x =
  let pi = 3.141593 in
  let p = 2.0 *. pi in
  let rec hoge x y = 
    if x >= y then
      hoge x (2. *. y) 
    else
      y
  in
    let p = hoge x p in
    let rec fuga x y z =
      if x >= z *. 2.0 then
        if x >= y then
          fuga (x -. y) (y /. 2.0) z
        else
          fuga x (y /. 2.0) z
      else
        x
    in
      fuga x p pi
in


let rec sin_body x =
(*  x *. (1.0 -. x *. x *. (0.16666668 -. x *. x *. (0.008332824 -. 0.00019587841 *. x *. x)))*) (* こっちは命令数が増える *)
(*
  x -. 0.16666668 *. x *. x *. x
    +. 0.008332824 *. x *. x *. x *. x *. x
    -. 0.00019587841 *. x *. x *. x *. x *. x *. x *. x 
*)
  let y = x *. x in
  x -. 0.16666668 *. x *. y
    +. 0.008332824 *. x *. y *. y
    -. 0.00019587841 *. x *. y *. y *. y

in

let rec cos_body x =
  let y = x *. x in
  1.0 -. y *. (0.5 -. y *. (0.04166368 -. y *. 0.0013695068))
(*  1.0 -. x *. x *. (0.5 -. x *. x *. (0.04166368 -. x *. x *. 0.0013695068)) *)
(*  1.0 -. 0.5 *. x *. x +. 0.04166368 *. x *. x *. x *. x -. 0.0013695068 *. x *. x *. x *. x *. x *. x  *) (* こっちは命令数が増える *)
in

let rec abs_float a =
  if (a < 0.0) then
    (-.a)
  else
    a
in

let rec sin x =
  let pi = 3.141593 in
  let f = (if (x < 0.0) then -.1.0 else 1.0) in
  let x = modulo_2pi (abs_float x) in
  if x >= pi then 
    let x = x -. pi in
    let f = (-.f) in
    if (x >= pi /. 2.0) then
      let x = pi -. x in
      if (x <= pi /. 4.0) then
        sin_body(x) *. f
      else
        cos_body (pi /. 2.0 -. x) *. f
    else
      if (x <= pi /. 4.0) then
        sin_body(x) *. f
      else
        cos_body (pi /. 2.0 -. x) *. f
   else
    if (x >= pi /. 2.0) then
      let x = pi -. x in
      if (x <= pi /. 4.0) then
        sin_body(x) *. f
      else
        cos_body (pi /. 2.0 -. x) *. f
    else
      if (x <= pi /. 4.0) then
        sin_body(x) *. f
      else
        cos_body (pi /. 2.0 -. x) *. f
in
  
let rec cos x =
  let pi = 3.141593 in
  let f = 1.0 in
  let x = modulo_2pi (abs_float x) in
  if x >= pi then 
    let x = x -. pi in
    let f = (-.f) in
    if (x >= pi /. 2.0) then
      let x = pi -. x in
      let f = (-.f) in
      if (x <= pi /. 4.0) then
        cos_body(x) *. f
      else
        sin_body (pi /. 2.0 -. x) *. f
    else
      if (x <= pi /. 4.0) then
        cos_body(x) *. f
      else
        sin_body (pi /. 2.0 -. x) *. f
  else
    if (x >= pi /. 2.0) then
      let x = pi -. x in
      let f = (-.f) in
      if (x <= pi /. 4.0) then
        cos_body(x) *. f
      else
        sin_body (pi /. 2.0 -. x) *. f
    else
      if (x <= pi /. 4.0) then
        cos_body(x) *. f
      else
        sin_body (pi /. 2.0 -. x) *. f
in



let rec atan_body x =
(*  x *. (1.0 -. x *. x *. (0.3333333 -. x *. x *. (0.2 -. x *. x *. 
       (0.142857142 -. x *. x *. (0.111111104 -. x *. x *. (0.08976446 -. x *. x *. (0.060035485 *. x *. x)))))))*)
  x -. 0.3333333   *. x *. x *. x 
    +. 0.2         *. x *. x *. x *. x *. x
    -. 0.142857142 *. x *. x *. x *. x *. x *. x *. x 
    +. 0.111111104 *. x *. x *. x *. x *. x *. x *. x *. x *. x
    -. 0.08976446  *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x 
    +. 0.060035485 *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x
(*
  let y = x *. x in
  let z = y *. y in
  let w = z *. z in
  x -. 0.3333333 *. x *. y +. 0.2 *. x *. z
    -. 0.142857142 *. x *. y *. z +. 0.111111104 *. x *. z *. z
    -. 0.08976446 *. x *. y *. w
    +. 0.060035485 *. x *. z *. w
*)
in

let rec atan x =
  let pi = 3.1415927 in
  let f = (if x < 0.0 then -.1.0 else 1.0) in
  let x = x *. f in
  if x < 4.375 then
    atan_body x
  else if x < 2.4375 then
    (pi /. 4.0 +. atan_body ((x -. 1.0) /. (x +. 1.0))) *. f
  else
    (pi /. 2.0 +. atan_body (1.0 /. x)) *. f
in

(* create_array -> 直接アセンブリ書いた *)


(* I/O *)
let rec print_num n =
  print_char (n + 48)
in 

let rec mul10 n =
  let a = n << 3 in
  let b = n << 1 in
  a + b
in

let rec div10_sub n l r = 
  let k = (l + r)/2 in
  if (10 * k > n) then
    div10_sub n l k
  else if 10 * k + 9 < n then
    div10_sub n k r
  else
    k
in


let rec div10 n =
  div10_sub n 0 n 
 (* 
  ((n << 7) + (n << 6) + (n << 3) + (n << 2) + n) >> 11
  *)
in

let rec iter_mul10 n k =
  if k = 0 then
    n
  else 
    iter_mul10 (mul10 n) (k - 1)
in

let rec iter_div10 n k =
  if k = 0 then
    n
  else 
    iter_div10 (div10 n) (k - 1)
in

let rec keta_sub n k =
  if n < 10 then 
    k + 1
  else
    let a = div10 n in
    keta_sub a (k + 1)
in 

let rec keta n =
  keta_sub n 0
in

let rec print_uint_keta n k =
  if (k = 1) then
    print_num n
  else (
    if (n < iter_mul10 1 (k - 1)) then
      (
      print_num 0;
      print_uint_keta n (k - 1)
      )
    else (
      let b = iter_div10 n (k - 1) in
      print_num b;
      print_uint_keta (n - (iter_mul10 b (k - 1))) (k - 1)
    )
  )
in


let rec print_uint n =
  if (n < 10) then
    print_num n
  else (
    let a = div10 n in
    print_uint a;
    print_num (n - (mul10 a))
  )
in


let rec print_int n =
  if n < 0 then (
    print_char 45;
    print_uint (-n) 
  )
  else
    print_uint n 
(*  if (n < 0) then
    print_char 45;
    print_int (-n)
  else (
    if n < 10 then
      print_num(n)
    else (
      if n < 100 then
        let a = ((n << 7) + (n << 6) + (n << 3) + (n << 2) + n) >> 11 in (* a <- n /10 *)
        print_num(a);
        print_num(n - ((a << 3) + (a << 1)))
      else (
        let b = ((n << 7) + (n << 5) + (n << 2)) >> 14 in (* a <- n / 100 *)
        let n = n - ((b << 6) + (b << 5) + (b << 2)) in (* n <- nの下2桁 *)
        let a = ((n << 7) + (n << 6) + (n << 3) + (n << 2) + n) >> 11 in (* a <- n /10 *)
        print_num(b);
        print_num(a);
        print_num(n - ((a << 3) + (a << 1)))
      )
    )
  )*) 
in 


(*
let rec read_token in_token =
  let c = read_char () in
  if c = 32 then
    if in_token then 
      ()
    else 
      read_token 0
  else if c = 9 then
      if in_token then 
        ()
      else
      read_token 0
  else if c = 13 then
    if in_token then 
      ()
    else
      read_token 0
  else if c = 10 then
    if in_token then 
      ()
    else
      read_token 0
  else if c = 26 then
    ()
  else (
    buffer_add_char c;
    read_token 1
  )
in


let rec read_int_ascii x =
  buffer_clear ();
  let _ = read_token 0 in
  buffer_to_int ()
in

let rec iter_div10_float a b =
  if b = 0 then a else iter_div10_float (a /. 10.0) (b - 1)
in

let rec read_float_ascii x =
  buffer_clear ();
  let _ = read_token 0 in
  let c = buffer_get 0 in
  let i = buffer_to_int_of_float () in
  let d = buffer_to_dec_of_float () in
  let k = buffer_to_ika_keta_of_float () in (* 小数点以下の桁 *)
  if (c = 45) then
    (-.1.0) *. (float_of_int i +. (iter_div10_float (float_of_int d) k))
  else
    float_of_int i +. (iter_div10_float (float_of_int d) k)
in
*)




(** 色々 **)
let rec truncate a = 
  int_of_float (a)
in


let rec print_dec x =
  if (x = 0.0) then
    ()
  else (
    let y = 10.0 *. x in
    print_int (int_of_float y);
    print_dec (y -. float_of_int (int_of_float y))
  )
in


let rec print_ufloat x =
  print_int (int_of_float x);
  print_char (46);
  print_dec (x -. (floor x))
in

let rec print_float x =
  if x < 0.0 then (
    print_char 45;
    print_ufloat (-.x) 
  )
  else
    print_ufloat x 
in 



print_int 32;
print_float (floor (3.1))
