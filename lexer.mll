{
(* lexerが利用する変数、関数、型などの定義 *)
open Parser
open Type

let set_pos lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  lexbuf.Lexing.lex_curr_p <- { pos with
  Lexing.pos_lnum = pos.Lexing.pos_lnum + 1;
  Lexing.pos_bol = pos.Lexing.pos_cnum; }
}

(* 正規表現の略記 *)
let space = [' ' '\t']
let digit = ['0'-'9']
let lower = ['a'-'z']
let upper = ['A'-'Z']

rule token = parse
| space+
    { token lexbuf }
| "(*"
    { comment lexbuf; (* ネストしたコメントのためのトリック *)
      token lexbuf }
| '('
    { LPAREN }
| ')'
    { RPAREN }
(*
| "true"
    { BOOL(true) }
| "false"
    { BOOL(false) }
    *)
| "not"
    { NOT }
| digit+ (* 整数を字句解析するルール (caml2html: lexer_int) *)
    { INT(int_of_string (Lexing.lexeme lexbuf)) }
| digit+ ('.' digit*)? (['e' 'E'] ['+' '-']? digit+)?
    { FLOAT(float_of_string (Lexing.lexeme lexbuf)) }
| '-' (* -.より後回しにしなくても良い? 最長一致? *)
    { MINUS }
| '+' (* +.より後回しにしなくても良い? 最長一致? *)
    { PLUS }
| '*'
    { AST }
| '/'
    { SLASH }
| "-."
    { MINUS_DOT }
| "+."
    { PLUS_DOT }
| "*."
    { AST_DOT }
| "/."
    { SLASH_DOT }
| '='
    { EQUAL }
| "<>"
    { LESS_GREATER }
| "<="
    { LESS_EQUAL }
| ">="
    { GREATER_EQUAL }
| '<'
    { LESS }
| '>'
    { GREATER }
| "if"
    { IF }
| "then"
    { THEN }
| "else"
    { ELSE }
| "let"
    { LET }
| "in"
    { IN }
| "rec"
    { REC }
| ','
    { COMMA }
| '_'
    { IDENT(Id.gentmp Type.Unit) }
| "Array.create" | "Array.make" | "create_array" (* [XX] ad hoc *)
    { ARRAY_CREATE }
| '.'
    { DOT }
| "<-"
    { LESS_MINUS }
| ';'
    { SEMICOLON }
| eof
    { EOF }
| lower (digit|lower|upper|'_')* (* 他の「予約語」より後でないといけない *)
    { IDENT(Lexing.lexeme lexbuf) }
| '\n'
    { set_pos lexbuf; token lexbuf }
| '\r'
    { set_pos lexbuf; token lexbuf }
| _
    { failwith
        (Printf.sprintf "unknown token %s near characters %d-%d"
           (Lexing.lexeme lexbuf)
           (Lexing.lexeme_start lexbuf)
           (Lexing.lexeme_end lexbuf)) }
and comment = parse
| "*)"
    { () }
| "(*"
    { comment lexbuf;
      comment lexbuf }
| eof
    { Format.eprintf "warning: unterminated comment@." }
| '\n'
    { set_pos lexbuf; comment lexbuf  }
| '\r'
    { set_pos lexbuf; comment lexbuf }
| _
    { comment lexbuf }
