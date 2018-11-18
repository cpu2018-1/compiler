exception Error of Syntax.t * Type.t * Type.t
val extenv : Type.t M.t ref
val f : Syntax.t -> Syntax.t

val sprint_type : Type.t -> string
val print_type : Type.t -> unit
