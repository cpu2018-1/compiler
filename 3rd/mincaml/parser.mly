%{
(* parserが利用する変数、関数、型などの定義 *)
open Syntax
let addtyp x = (x, Type.gentyp ())


%}

/* (* 字句を表すデータ型の定義 (caml2html: parser_token) *) */
%token <bool> BOOL
%token <int> INT
%token <float> FLOAT
%token NOT
%token MINUS
%token PLUS
%token AST
%token SLASH
%token MINUS_DOT
%token PLUS_DOT
%token AST_DOT
%token SLASH_DOT
%token EQUAL
%token LESS_GREATER
%token LESS_EQUAL
%token GREATER_EQUAL
%token LESS
%token GREATER
%token IF
%token THEN
%token ELSE
%token <Id.t> IDENT
%token LET
%token IN
%token REC
%token COMMA
%token ARRAY_CREATE
%token DOT
%token LESS_MINUS
%token SEMICOLON
%token LPAREN
%token RPAREN
%token EOF
%token SLL SRL SRA       /* (* シフト演算 *) */
%token FLESS


/* (* 優先順位とassociativityの定義（低い方から高い方へ） (caml2html: parser_prior) *) */
%nonassoc IN
%right prec_let
%right SEMICOLON
%right prec_if
%right LESS_MINUS
%nonassoc prec_tuple
%left COMMA
%left EQUAL LESS_GREATER LESS GREATER LESS_EQUAL GREATER_EQUAL 
%left SLL SRL SRA
%left PLUS MINUS PLUS_DOT MINUS_DOT
%left AST SLASH AST_DOT SLASH_DOT
%right prec_unary_minus
%left prec_app
%left DOT

/* (* 開始記号の定義 *) */
%type <Syntax.t> exp
%start exp

%%

simple_exp: /* (* 括弧をつけなくても関数の引数になれる式 (caml2html: parser_simple) *) */
| LPAREN exp RPAREN
    { $2 }
| LPAREN RPAREN
    { Unit({ lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)})}
| BOOL
    { Bool($1, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| INT
    { Int($1, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| FLOAT
    { Float($1, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| IDENT
    { Var($1, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| simple_exp DOT LPAREN exp RPAREN
    { Get($1, $4, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }

exp: /* (* 一般の式 (caml2html: parser_exp) *) */
| simple_exp
    { $1 }
| NOT exp
    %prec prec_app
    { Not($2, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| MINUS exp
    %prec prec_unary_minus
    { match $2 with
    | Float(f, d) -> Float(-.f, d) (* -1.23などは型エラーではないので別扱い *)
    | e -> Neg(e, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp PLUS exp /* (* 足し算を構文解析するルール (caml2html: parser_add) *) */
    { Add($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp MINUS exp
    { Sub($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp AST exp
    { 
      match $1, $3 with
      | Int (10, d), e | e, Int (10, d) -> App(Var ("mul10", { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}), [e], { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) 
      | Int (4, d), e | e, Int (4, d) -> Sll(e, Int (2, d), { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) 
      | _ -> 
      App(Var ("mul", { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}), [$1; $3], { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp SLASH exp
    { 
      match $3 with
      | Int (2, d) -> 
      Sra($1, Int (1, d), { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)})
      | Int (10, d) -> 
      App(Var ("div10",{ lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}),  [$1], { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)})
      | _ -> 
      App(Var ("div", { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}), [$1; $3], { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp EQUAL exp
    { Eq($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp LESS_GREATER exp
    { Not(Eq($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}), { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp LESS exp
    { Not(LE($3, $1, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}), { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp GREATER exp
    { Not(LE($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}), { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp LESS_EQUAL exp
    { LE($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp GREATER_EQUAL exp
    { LE($3, $1, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| IF exp THEN exp ELSE exp
    %prec prec_if
    { If($2, $4, $6, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| MINUS_DOT exp
    %prec prec_unary_minus
    { FNeg($2, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp PLUS_DOT exp
    { FAdd($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp MINUS_DOT exp
    { FSub($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp AST_DOT exp
    { FMul($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp SLASH_DOT exp
    { FDiv($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| LET IDENT EQUAL exp IN exp
    %prec prec_let
    { Let(addtyp $2, $4, $6, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| LET REC fundef IN exp
    %prec prec_let
    { LetRec($3, $5, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| simple_exp actual_args
    %prec prec_app
    { App($1, $2, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| elems
    %prec prec_tuple
    { Tuple($1, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| LET LPAREN pat RPAREN EQUAL exp IN exp
    { LetTuple($3, $6, $8, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| simple_exp DOT LPAREN exp RPAREN LESS_MINUS exp
    { Put($1, $4, $7, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp SEMICOLON exp
    { Let((Id.gentmp Type.Unit, Type.Unit), $1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp SEMICOLON
    { Let((Id.gentmp Type.Unit, Type.Unit), $1, Unit({ lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}), { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| ARRAY_CREATE simple_exp simple_exp
    %prec prec_app
    { Array($2, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp SLL exp 
    { Sll($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp SRL exp 
    { Srl($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
| exp SRA exp 
    { Sra($1, $3, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
/*
| FLESS simple_exp simple_exp
    %prec prec_app
    { Not(LE($3, $2, { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}), { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol)}) }
*/
| error
    { failwith
        (let s = (Parsing.symbol_start_pos ()) in
        let e = (Parsing.symbol_end_pos ()) in
        if (s.Lexing.pos_lnum = e.Lexing.pos_lnum) then
          Printf.sprintf "parse error line %d near characters %d-%d" 
           s.Lexing.pos_lnum 
           (s.Lexing.pos_cnum - s.Lexing.pos_bol)
           (e.Lexing.pos_cnum - e.Lexing.pos_bol)
        else
          Printf.sprintf "parse error from line %d characters %d to line %d characters %d" 
           s.Lexing.pos_lnum 
           (s.Lexing.pos_cnum - s.Lexing.pos_bol)
           e.Lexing.pos_lnum 
           (e.Lexing.pos_cnum - e.Lexing.pos_bol))
    }

fundef:
| IDENT formal_args EQUAL exp
    { { name = addtyp $1; args = $2; body = $4; deb = { lnum = (Parsing.symbol_start_pos ()).Lexing.pos_lnum; bchar = ((Parsing.symbol_start_pos ()).Lexing.pos_cnum - (Parsing.symbol_start_pos ()).Lexing.pos_bol); echar = ((Parsing.symbol_end_pos ()).Lexing.pos_cnum - (Parsing.symbol_end_pos ()).Lexing.pos_bol) } } }

formal_args:
| IDENT formal_args
    { addtyp $1 :: $2 }
| IDENT
    { [addtyp $1] }

actual_args:
| actual_args simple_exp
    %prec prec_app
    { $1 @ [$2] }
| simple_exp
    %prec prec_app
    { [$1] }

elems:
| elems COMMA exp
    { $1 @ [$3] }
| exp COMMA exp
    { [$1; $3] }

pat:
| pat COMMA IDENT
    { $1 @ [addtyp $3] }
| IDENT COMMA IDENT
    { [addtyp $1; addtyp $3] }



