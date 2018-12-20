let y = 100 / 10 in
let x = 
  if y < 3 then
    let z = 
      if y <= 3 then
        y 
      else 
        0 
    in
      z + 4
  else
    3
in
  print_int x
