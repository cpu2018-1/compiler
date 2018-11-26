(* 浮動小数点用のテーブル *)

type 'a t = (float * 'a) list

let empty = []


let counter = ref (-1)

let add key value table =
  (key, value) :: table

(* 等価判定 *)
let is_equal k key =
  (abs_float (k -. key)) < 0.00001

let rec mem key table =
  match table with
  | [] -> false
  | (k, v) :: ls when is_equal k key -> true
  | e :: ls -> mem key ls

 
let rec find key table =
  match table with
  | [] -> raise Not_found
  | (k, v) :: ls when is_equal k key -> v
  | e :: ls -> find key ls


let add_float f table = incr counter; add f !counter table


let rec iter f table =
  match table with
  | [] -> ()
  | (k, v) :: xs -> f k v; iter f xs
