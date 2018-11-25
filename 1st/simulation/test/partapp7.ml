let rec h x y = x + y in
let rec g f = f 1 2 in
print_int (g h)
