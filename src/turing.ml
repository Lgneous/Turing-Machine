open Batteries

let usage () =
  print_endline @@ String.concat "\n" [
                                   "usage: ./turing.byte [-h] jsonfile input";
                                   "";
                                   "positional arguments:";
                                   "  jsonfile                  json description of the machine";
                                   "";
                                   "  input                     input of the machine";
                                   "";
                                   "optional arguments:";
                                   "  -h, --help                show this help message and exit";
                                 ]
let test = function
  | Result.Ok d -> Print.machine_desc d
  | Result.Bad e -> print_endline e

let _ =
  usage ();
  let f = open_in Sys.argv.(1) in
  let lexbuf = Lexing.from_channel f in
  try
    test @@ Machine.sanitize @@ Machine.of_ast @@ Parser.prog Lexer.read lexbuf
  with
    _ -> let pos = lexbuf.lex_curr_p in
         ignore @@ Printf.printf "line %d, col %d\n" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
