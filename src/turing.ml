open Batteries
open Lexing

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

let display_or_err = function
  | Result.Ok d -> Print.machine_desc d
  | Result.Bad e -> print_endline e

let print_position lexbuf =
  let pos = lexbuf.lex_curr_p in
  Printf.printf "Line: %d, Column: %d\n" pos.pos_lnum
                (pos.pos_cnum - pos.pos_bol + 1)

let _ =
  if Array.length Sys.argv <> 3
  then usage ()
  else
    try
      let f = open_in Sys.argv.(1) in
      let lexbuf = Lexing.from_channel f in
      let ast =
        try Parser.prog Lexer.read lexbuf
        with Lexer.SyntaxError e -> (print_position lexbuf; print_endline e; exit 1)
           | _ -> (print_position lexbuf; print_endline "Parser Error"; exit 1)
      in
      let desc_res = Machine.sanitize @@ Machine.of_ast @@ ast in
      display_or_err desc_res;
      match desc_res with
      | Result.Ok desc -> Printf.printf " HALTING\n-- %s --\n" @@ Machine.run desc (Tape.make (Sys.argv.(2) ^ String.make 1 desc.Machine.blank) desc.Machine.blank) desc.Machine.initial
      | err -> ()

    with Sys_error e -> print_endline e; exit 2
