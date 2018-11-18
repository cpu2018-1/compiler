let rec g p = p 3 in
let rec f q = g (q 2) in
f (fun x y -> x + y)
