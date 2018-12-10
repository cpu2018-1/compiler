let rec print_int n =
(*
  if n < 0 then (
    print_char 45;
    print_uint (-n) 
  )
  else
    print_uint n 
*)    
  if (n < 0) then
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
  ) 
in 
print_int 32

