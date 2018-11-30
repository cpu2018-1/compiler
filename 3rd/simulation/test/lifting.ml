let f = 3 in
let rec h x = 
  let rec g y = x + y + f in g 2 
in 
  h 1
