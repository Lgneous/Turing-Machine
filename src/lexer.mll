{
        open Lexing
        open Parser

        exception SyntaxError of string
}

let blank = [' ' '\t']
let newline = '\n' | '\r' | "\n\r"
let char = '"' [^ '"'] '"'

rule read = parse
  | blank { read lexbuf }
  | newline { new_line lexbuf; read lexbuf }
  | char { CHAR (lexeme lexbuf) }

  | "\"name\"" { NAME }
  | "\"alphabet\"" { ALPHABET }
  | "\"blank\"" { BLANK }
  | "\"states\"" { STATES }
  | "\"initial\"" { INITIAL }
  | "\"finals\"" { FINALS }
  | "\"transitions\"" { TRANSITIONS }
  | "\"read\"" { READ }
  | "\"to_state\"" { TO_STATE }
  | "\"write\"" { WRITE }
  | "\"action\"" { ACTION }
  | "\"LEFT\"" { LEFT }
  | "\"RIGHT\"" { RIGHT }

  | '"' { read_string (Buffer.create 17) lexbuf }
  | '{' { LEFT_BRACE }
  | '}' { RIGHT_BRACE }
  | '[' { LEFT_BRACK }
  | ']' { RIGHT_BRACK }
  | ':' { COLON }
  | ',' { COMMA }
  | eof { EOF }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
and read_string buf =
  parse
  | '"' { STRING (Buffer.contents buf) }
  | [^ '"']+
    { Buffer.add_string buf (Lexing.lexeme lexbuf);
      read_string buf lexbuf
    }
