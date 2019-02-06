let limit = ref 1000


let library_file = "/home/tansei/mydir/lecture/cpuex/3rd/mincaml/genlib.ml"


let rec sprint_binary_sub b n =
  if n < 0 then
    ""
  else (
    let b' = Int32.shift_right b 1 in
    (sprint_binary_sub b' (n - 1))^(
    if (Int32.logand b (Int32.of_int 1) = Int32.of_int 1) then
      "1"
    else 
      "0"
    )
  )

let rec sprint_binary b =
  sprint_binary_sub b 31

let rec print_ftable () =
  Ftable.iter (fun f i -> 
            Printf.printf "ftable[%d] = (%s, %f)\n" i (sprint_binary (Int32.bits_of_float f)) f) !(Virtual.ftable)

let rec iter n e = (* 最適化処理をくりかえす (caml2html: main_iter) *)
  Format.eprintf "iteration %d@." n;
  if n = 0 then e else
  let e' = Commelm.commelm (Elim.f (ConstFold.f (Inline.f (Assoc.f (Beta.f e))))) in
  if e = e' then e else
  iter (n - 1) e'


let lexbuf outchan l = (* バッファをコンパイルしてチャンネルへ出力する (caml2html: main_lexbuf) *)
  Id.counter := 0;
  Typing.extenv := M.empty;
  let a = Parser.exp Lexer.token l in
  let lib_chan = open_in library_file in 
  let lib = Parser.exp Lexer.token (Lexing.from_channel lib_chan) in
  close_in lib_chan;
(*  Syntax.print_syntax a; print_newline ();*)
  Emit.f outchan
    (RegAlloc.f
    ((*Glbsimm.f*)
    (Num_asm.g
      ((*Coloring.f*)
      ((*Avoid_ans_call.main*)
      ((*Schedule.f*)
      (Num_asm.f
      ((*Convert_if.f*)
      (Glbsimm.f
       (Simm.f
          (Virtual.f
             (Closure.f
                (iter !limit
                   (Alpha.f 
                     (KNormal.f
                       (Typing.f
                     (Syntax.concat lib a)
                      ))))))))))))))))

let string s = lexbuf stdout (Lexing.from_string s) (* 文字列をコンパイルして標準出力に表示する (caml2html: main_string) *)

let file f = (* ファイルをコンパイルしてファイルに出力する (caml2html: main_file) *)
  let inchan = open_in (f ^ ".ml") in
  let outchan = open_out (f ^ ".s") in
  try
    lexbuf outchan (Lexing.from_channel inchan);
    close_in inchan;
    close_out outchan;
  with e -> (close_in inchan; close_out outchan; raise e)


let () = (* ここからコンパイラの実行が開始される (caml2html: main_entry) *)
  let files = ref [] in
  Arg.parse
    [("-inline", Arg.Int(fun i -> Inline.threshold := i), "maximum size of functions inlined");
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated");
     ("-asm", Arg.Set(Virtual.print), "print asm.t before register allocation");
     ("-simm", Arg.Set(Simm.print), "print asm.t after simm");
     ("-if", Arg.Set(Convert_if.print), "print asm.t after convert_if");
     ("-nasm", Arg.Set(Num_asm.print_b), "print num_asm.t before register allocation");
     ("-breg", Arg.Set(Num_asm.print_a), "print num_asm.t before register allocation");
     ("-areg", Arg.Set(Emit.print), "print asm.t after register allocation")]
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-iter n] ...filenames without \".ml\"..." Sys.argv.(0));
  List.iter
    (fun f -> ignore (file f))
    !files
