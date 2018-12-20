let rec f x =
  let rec g y = 
    let rec h z = y + z in h 1
  in g 2
in 
  print_int (f 3)
