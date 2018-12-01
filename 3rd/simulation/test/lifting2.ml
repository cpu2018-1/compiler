let rec f x = 
  let z = x + x in
  let rec g y = x + y + z in
  g 3 in
print_int (f 2)
