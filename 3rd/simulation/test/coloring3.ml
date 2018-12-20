
let flag2 = 1 /10 in

let x = 100 / 10 in
  texture_color.(1) <-
    if x
    then (if flag2 then 255.0 else 0.0)
    else (if flag2 then 0.0 else 255.0)
