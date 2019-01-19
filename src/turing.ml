open Batteries

let testcore = [
    Syntax.Name "unary_sub" ;
    Syntax.Alphabet ["1";".";"-";"="] ;
    Syntax.States ["scanright";"eraseone";"subone";"skip";"HALT"] ;
    Syntax.Initial "scanright" ;
    Syntax.Finals ["HALT"] ;
    Syntax.Transitions [
	("scanright", [
	   {read=".";
	    to_state="scanright";
	    write=".";
	    action=Transition.Right} ;
	   {read="1";
	    to_state="scanright";
	    write="1";
	    action=Transition.Right} ;
	   {read="-";
	    to_state="scanright";
	    write="-";
	    action=Transition.Right} ;
	   {read="=";
	    to_state="eraseone";
	    write=".";
	    action=Transition.Left}
	]) ;
	("eraseone", [
	   {read="1";
	    to_state="subone";
	    write="=";
	    action=Transition.Left} ;
	   {read="-";
	    to_state="HALT";
	    write=".";
	    action=Transition.Left}
	]) ;
	("subone", [
	   {read="1";
	    to_state="subone";
	    write="1";
	    action=Transition.Left} ;
	   {read="-";
	    to_state="skip";
	    write="-";
	    action=Transition.Left}
	]) ;
	("skip", [
	   {read=".";
	    to_state="skip";
	    write=".";
	    action=Transition.Left} ;
	   {read="1";
	    to_state="scanright";
	    write=".";
	    action=Transition.Right}
	])
      ]

			   ]

let _ = Machine.print_machine testcore

                              (*  let f = open_in Sys.argv.(1) in
  let lexbuf = Lexing.from_channel f in
  try
    ignore @@ Parser.prog Lexer.read lexbuf
  with
    _ -> let pos = lexbuf.lex_curr_p in
         ignore @@ Printf.printf "line %d, col %d\n" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
		               *)
