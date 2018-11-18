type debug = { lnum : int; bchar : int; echar : int }

type t = (* MinCamlの構文を表現するデータ型 (caml2html: syntax_t) *)
         (* 型エラーの行数とその行の何文字目からかをもたせる *)
  | Unit of debug
  | Bool of bool * debug
  | Int of int * debug
  | Float of float * debug
  | Not of t * debug
  | Neg of t * debug
  | Add of t * t * debug
  | Sub of t * t * debug
  | FNeg of t * debug
  | FAdd of t * t * debug
  | FSub of t * t * debug
  | FMul of t * t * debug
  | FDiv of t * t * debug
  | Eq of t * t * debug
  | LE of t * t * debug
  | If of t * t * t * debug
  | Let of (Id.t * Type.t) * t * t * debug
  | Var of Id.t * debug
  | LetRec of fundef * t * debug
  | App of t * t list * debug
  | Tuple of t list * debug
  | LetTuple of (Id.t * Type.t) list * t * t * debug
  | Array of t * t * debug
  | Get of t * t * debug
  | Put of t * t * t * debug
  | Sll of t * t * debug    (* shift left logical *)
  | Srl of t * t * debug    (* shift right logical *)
  | Sra of t * t * debug    (* shift right arithmetical *)
  | Fun of (Id.t * Type.t) list * t * debug 
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t;
               deb : debug }


(* インデント幅 *)
let indent = 2
  
(* 幅nのインデントを出力 *)
let rec print_indent_sub n =
  if n = 0 then
    ()
  else (
    print_string " "; print_indent_sub (n - 1)
  )

(* (インデント幅) * (インデントの深さ)のインデントを出力 *)
let print_indent n =
  print_indent_sub (indent * n)

(* スペースを出力/後々にスペースを変えたい時用に定義したが不要な感じがする *)
let print_space () = print_string " "

(* 実質の出力を行う *)
let rec print_syntax_sub t i =
  print_indent i;
  match t with
  | Unit (_) -> print_endline "()"
  | Bool (b, _) -> print_endline (if b = true then "TRUE" else "FALSE")
  | Int (n, _) -> print_string "INT"; print_space (); 
                        print_int n; 
                        print_newline ()
  | Float (f, _) -> print_string "FLOAT"; print_space (); 
                          print_float f; 
                          print_newline ()
  | Not (b, _) -> print_endline "NOT"; 
                        print_syntax_sub b (i + 1); 
  | Neg (n, _) -> print_endline "NEG"; 
                        print_syntax_sub n (i + 1); 
                        print_newline ()
  | Add (n, m, _) -> print_endline "ADD"; 
                           print_syntax_sub n (i + 1); 
                           print_syntax_sub m (i + 1)
  | Sub (n, m, _) -> print_endline "SUB"; 
                           print_syntax_sub n (i + 1); 
                           print_syntax_sub m (i + 1)
  | FNeg (f, _) -> print_endline "FNEG";
                         print_syntax_sub f (i + 1)
  | FAdd (f, g, _) -> print_endline "FADD"; 
                            print_syntax_sub f (i + 1); 
                            print_syntax_sub g (i + 1)
  | FSub (f, g, _) -> print_endline "FSUB"; 
                            print_syntax_sub f (i + 1); 
                            print_syntax_sub g (i + 1)
  | FMul (f, g, _) -> print_endline "FMUL"; 
                            print_syntax_sub f (i + 1); 
                            print_syntax_sub g (i + 1)
  | FDiv (f, g, _) -> print_endline "FDIV"; 
                            print_syntax_sub f (i + 1); 
                            print_syntax_sub g (i + 1)
  | Eq (a, b, _) -> print_endline "EQ"; 
                          print_syntax_sub a (i + 1);
                          print_syntax_sub b (i + 1);
  | LE (a, b, _) -> print_endline "LE"; 
                          print_syntax_sub a (i + 1); 
                          print_syntax_sub b (i + 1); 
  | If (a, b, c, _) -> print_endline "IF"; 
                             print_syntax_sub a (i + 1);
                             print_indent i; print_endline "THEN";
                             print_syntax_sub b (i + 1);
                             print_indent i; print_endline "ELSE";
                             print_syntax_sub c (i + 1)
  | Let ((x, a), t1, t2, _) -> print_endline "LET";
                            print_indent (i + 1); print_endline (x ^ " =");
                            print_syntax_sub t1 (i + 2);
                            print_indent (i + 1); print_endline "IN";
                            print_syntax_sub t2 (i + 2)
  | Var (x, _) -> print_string "VAR"; print_space (); 
                        print_endline x; 
  | LetRec (f, t, _) -> print_endline "LETREC";
                     print_indent (i + 1); Id.print_id (fst f.name);
                     List.iter (fun x -> print_string " ";
                                         Id.print_id x;
                                         ) (List.map fst (f.args));
                     print_endline " =";
                     print_syntax_sub f.body (i + 2);
                     print_indent (i + 1); print_endline "IN";
                     print_syntax_sub t (i + 2)
  | App (t, tl, _) -> print_endline "APP";
                   print_syntax_sub t (i + 1);
                   print_syntax_sub_list tl (i + 1)
  | Tuple (tl, _) -> print_endline "TUPLE";
                print_syntax_sub_list tl (i + 1)
  | LetTuple (idtyl, t1, t2, deb) -> print_endline "LETTUPLE";
                            print_syntax_sub_list (List.map (fun x -> Var ((fst x), deb)) idtyl) (i + 1);
                            print_syntax_sub t1 (i + 1);
                            print_syntax_sub t2 (i + 2)
  | Array (t1, t2, _) -> print_endline "ARRAY";
                      print_syntax_sub t1 (i + 1);
                      print_syntax_sub t2 (i + 1)
  | Get (t1, t2, _) -> print_endline "GET";
                    print_syntax_sub t1 (i + 1);
                    print_syntax_sub t2 (i + 1)
  | Put (t1, t2, t3, _) -> print_endline "PUT";
                        print_syntax_sub t1 (i + 1);
                        print_syntax_sub t2 (i + 1);
                        print_syntax_sub t3 (i + 1)
  | Sll (t1, t2, _) ->  print_endline "SLL";
                        print_syntax_sub t1 (i + 1);
                        print_syntax_sub t2 (i + 1)
  | Srl (t1, t2, _) ->  print_endline "SRL";
                        print_syntax_sub t1 (i + 1);
                        print_syntax_sub t2 (i + 1)
  | Sra (t1, t2, _) ->  print_endline "SRA";
                        print_syntax_sub t1 (i + 1);
                        print_syntax_sub t2 (i + 1)
  | Fun (xs, t, _) -> print_endline "FUN";
                      print_indent (i + 1); 
                      List.iter (fun x -> print_string " ";
                                         Id.print_id x;
                                         ) (List.map fst (xs));
                      print_newline (); print_indent (i); print_endline "->";
                      print_syntax_sub t (i + 1)
and 
(* リストに対する出力 *)
print_syntax_sub_list tl i = 
  List.iter ((fun j x -> print_syntax_sub x j) i) tl


(* 呼び出される関数 *)
let print_syntax t =
  print_syntax_sub t 0

