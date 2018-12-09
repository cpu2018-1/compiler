(* customized version of Set *)

module Int_S =
  Set.Make
    (struct
      type t = int
      let compare = compare
    end)
include Int_S

let of_list l = List.fold_left (fun s e -> add e s) empty l
