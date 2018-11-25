let rec g p = p 3 in
let rec f q = g (q 2) in
print_int (f (fun x y -> x + y))
