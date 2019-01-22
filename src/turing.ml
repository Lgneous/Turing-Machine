open Batteries

let test = function
  | Result.Ok _ -> ()
  | Result.Bad e -> print_endline e

let _ =
  let f = open_in Sys.argv.(1) in
  let lexbuf = Lexing.from_channel f in
  try
    test @@ Machine.sanitize @@ Machine.of_ast @@ Parser.prog Lexer.read lexbuf
  with
    _ -> let pos = lexbuf.lex_curr_p in
         ignore @@ Printf.printf "line %d, col %d\n" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
