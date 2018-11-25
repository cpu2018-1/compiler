let rec loop x =
  if (x >= -3.0) then
    (
    print_float (x); print_newline ();
    print_int (int_of_float x);
    print_newline ();
    loop (x -. 0.01)
    )
  else
    ()

in

loop (3.0)
