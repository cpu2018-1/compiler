(* customized version of Map *)

module Int_M =
  Map.Make
    (struct
      type t = int
      let compare = compare
    end)
include Int_M

let add_list xys env = List.fold_left (fun env (x, y) -> add x y env) env xys
let add_list2 xs ys env = List.fold_left2 (fun env x y -> add x y env) env xs ys
