let rec print_num n =
  putchar (n + 48)
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
  print_uint_keta n (keta n)
in


let rec print_int n =
  if n < 0 then (
    putchar 45;
    print_uint (-n) 
  )
  else
    print_uint n 
in 


let rec modulo_pi x =
  let pi = 3.14159265358979 in
  if pi < x then
    modulo_pi (x -. pi)
  else if x <= -.pi then
    modulo_pi (x +. pi)
  else
    x
in

let rec sin_body x =
  x -. 0.16666668 *. x *. x *. x +. 0.008332824 *. x *. x *. x *. x *. x 
  -. 0.00019587841 *. x *. x *. x *. x *. x *. x *. x
in

let rec cos_body x =
  1.0 -. 0.5 *. x *. x +. 0.04166368 *. x *. x *. x *. x  
  -. 0.0013695068 *. x *. x *. x *. x *. x *. x 
in

let rec sin x =
  let pi = 3.14159265358979 in
  let f = (if (x < 0.0) then -.1.0 else 1.0) in
  let x = modulo_pi x in
  (if x >= pi then
     let x = x -. pi in
     let f = (1.0 -. f) in
     ()
   else
     ());
  (if x >= pi /. 2.0 then
     let x = x -. pi in
     ()
   else
     ());
  if (x <= pi /. 4.0) then
    (sin_body x) *. f
  else
    (cos_body (pi /. 2.0 -. x)) *. f
in
  
let rec cos x =
  let pi = 3.14159265358979 in
  let f = 
  (if x < 0.0 then
    1
   else 
    0)
  in
  let x = modulo_pi x in
  (if x >= pi then
     let x = x -. pi in
     let f = (1 - f) in
     ()
   else
     ());
  (if x >= pi /. 2.0 then
     let x = x -. pi in
     let f = (1 - f) in
     ()
   else
     ());
  if (x <= pi /. 4.0) then
    cos_body x
  else
    sin_body (pi /. 2.0 -. x)
in

let rec atan_body x =
  x -. 0.3333333 *. x *. x *. x +. 0.2 *. x *. x *. x *. x *. x
    -. 0.142857142 *. x *. x *. x *. x *. x *. x *. x +. 0.111111104 *. x *. x *. x *. x *. x *. x *. x *. x *. x
    -. 0.08976446 *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x
    +. 0.060035485 *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x *. x
in

let rec atan x =
  let pi = 3.14159265358979 in
  let f = (if x < 0.0 then -.1.0 else 1.0) in
  let x = x *. f in
  if x < 4.375 then
    atan_body x
  else if x < 2.4375 then
    (pi /. 4.0 +. atan_body ((x -. 1.0) /. (x +. 1.0))) *. f
  else
    (pi /. 2.0 +. atan_body (1.0 /. x)) *. f
in

let rec floor x =
  let y = itof (ftoi x) in
  if x < y then
    y -. 1.0
  else
    y

in


(*print_float (sin 121.2);
print_float (cos 121.2);
print_float (atan 121.2);
*)
print_int 32
