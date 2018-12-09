type id_or_imm = V of Id.t | C of int | FC of float
type t =
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
and exp =
  | Nop
  | Li of int
  | FLi of float
  | SetL of Id.l
  | Mr of Id.t
  | Neg of Id.t
  | Add of Id.t * id_or_imm
  | Sub of Id.t * id_or_imm
  | Lwz of Id.t * id_or_imm
  | Stw of Id.t * Id.t * id_or_imm
  | FMr of Id.t 
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | FLw of Id.t * id_or_imm
  | FSw of Id.t * Id.t * id_or_imm
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t
  | IfFEq of id_or_imm * id_or_imm * t * t
  | IfFLE of id_or_imm * id_or_imm * t * t
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 *)
  | Restore of Id.t (* スタック変数から値を復元 *)
  | Sll of Id.t * id_or_imm
  | Srl of Id.t * id_or_imm
  | Sra of Id.t * id_or_imm
  | In of Id.t
  | Out of Id.t
  | FSqrt of Id.t
  | FtoI of Id.t
  | ItoF of Id.t
  | SetGlb of Id.l
type fundef = { name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }
type prog = Prog of (Id.l * float) list * fundef list * t

val fletd : Id.t * exp * t -> t (* shorthand of Let for float *)
val seq : exp * t -> t (* shorthand of Let for unit *)

val regs : Id.t array
val fregs : Id.t array
val allregs : Id.t list
val allfregs : Id.t list
val reg_cl : Id.t
val reg_sw : Id.t
val reg_fsw : Id.t
val reg_hp : Id.t
val reg_sp : Id.t
val reg_tmp : Id.t
val reg_lr : Id.t
val is_reg : Id.t -> bool

val fv : t -> Id.t list
val fv_exp : exp -> Id.t list
val concat : t -> Id.t * Type.t -> t -> t

val align : int -> int

val print_t : int -> t -> unit
val print_fundef : fundef -> unit
