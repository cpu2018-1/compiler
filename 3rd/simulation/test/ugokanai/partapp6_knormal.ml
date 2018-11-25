let rec
  g p =
    let
      i6 =
         3
    in
        p i6 
in
  let rec
    f q =
      let
        f5 =
          let
            i4 =
               2
          in
              q i4 
      in
          g f5 
  in
    let
      i3 =
        let
          f2 =
            let rec
              f1 x y =
                x + y
            in
              f1
        in
            f f2 
    in
      print_int
        i3
