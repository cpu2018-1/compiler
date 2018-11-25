let rec loop x =
  if (x >= -10000) then
    (
    print_int (x); print_newline ();
    print_float (float_of_int x);
    print_newline ();
    loop (x - 1)
    )
  else
    ()

in

loop (10000)
