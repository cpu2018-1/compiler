(* MINE 
let true = 1 in
 MINE *)
(*let x = (fun y -> y + 3) in
let z = ((fun a b c -> a + b + c) 6) 7 in
let w = ((fun b a c -> if b then a else c) true) in
print_int (x 4 + z 8 + (w 2 3))
*)
let w = ((fun b a c -> if b then a else c) true) in
(*print_int *)(w 1 2 + 45)
