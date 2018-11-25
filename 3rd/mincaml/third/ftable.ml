(* 浮動小数点用のテーブル *)

module Ftable =
  Map.Make
    (struct
      type t = float
      let compare = compare
    end)
include Ftable

let counter = ref (-1)

let add_float f table = incr counter; add f !counter table
