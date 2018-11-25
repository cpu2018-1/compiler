
let
  z =
    let rec
      f11 u5 u4 =
        let
          f15 =
            let rec
              f13 a b c =
                let
                  i14 =
                    a + b
                in
                  i14 + c
            in
              f13
        in
          let
            i16 =
               6
          in
              f15 i16 u5 u4 
    in
      f11
in
  let
    i20 =
      let
        f18 =
          let
            i17 =
              8
          in
            
              z i17 
      in
        let
          i19 =
            3
        in
            f18 i19 
  in
      print_int
      i20 
