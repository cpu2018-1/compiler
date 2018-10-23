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
let rec print_uint n =
  if (n < 10) then
    print_num n
  else
    let a = keta n in
    let b = iter_div10 n (a - 1) in
    print_num b;
    print_uint (n - (iter_mul10 b (a - 1)))
in
let rec print_int n =
  if n < 0 then
    putchar 45;
    print_uint (-n)
  else
    print_uint n
in 
print_int 32
