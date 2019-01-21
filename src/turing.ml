open Batteries

let _ =
  let f = open_in Sys.argv.(1) in
  let lexbuf = Lexing.from_channel f in
  try
    ignore @@ Parser.prog Lexer.read lexbuf
  with
    _ -> let pos = lexbuf.lex_curr_p in
         ignore @@ Printf.printf "line %d, col %d\n" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
