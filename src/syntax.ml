open Batteries

type core =
  | Name of string
  | Alphabet of string list
  | Blank of string
  | States of string list
  | Initial of string
  | Finals of string list
  | Transitions of (string * (Transition.t list)) list

type t = core list

let print_n_str x n =
	let rec str_of_nchar sx n str =
		if n <= 0 then str
		else str_of_nchar x (n - 1) (str ^ sx)
	in print_string @@ str_of_nchar x n ""

let rec print_list = function
	| str::tl when tl <> [] -> print_string (str ^ ", ") ; print_list tl
	| str::tl				-> print_string str ; print_list tl
	| _						-> ()

let rec foreach lst f =
	match lst with
	| transition::tl -> f transition ; foreach tl f
	| _		-> ()

let rec print_transitions = function
	| (name,lst)::tl -> foreach lst (fun t -> print_endline (
									   "(" ^ name ^ ", " ^ t.Transition.read ^ ") -> ("
									 ^ t.to_state ^ ", " ^ t.write ^ ", "
									 ^ begin
										if t.action = Transition.Left then "LEFT)"
										else "RIGHT)"
									   end )
								) ; print_transitions tl
	| _	-> ()

let rec print_machine = function
	| (Name str)::tl ->
				  print_n_str "*" 81 ; print_newline () ; print_char '*' ;
				  print_n_str " " 79 ; print_endline "*" ; print_char '*' ;
				  print_n_str " " (39 - ((BatString.length str) / 2)) ;
				  print_string str ;
				  print_n_str " " (39 - ((BatString.length str) / 2)) ;
				  if (BatString.length str) mod 2 = 0 then print_char ' ';
				  print_endline "*" ; print_char '*' ; print_n_str " " 79 ;
				  print_endline "*" ; print_n_str "*" 81 ; print_newline () ;
				  print_machine tl
	| (Alphabet alst)::tl ->
				  print_string "Alphabet: [ " ;
				  print_list alst ; print_endline " ]" ;
				  print_machine tl
	| (States slst)::tl ->
				  print_string "States  : [ " ; 
				  print_list slst ; print_endline " ]" ;
				  print_machine tl
	| (Initial str)::tl ->
				  print_endline ("Initial : " ^ str) ;
				  print_machine tl
	| (Blank str)::tl ->
				  print_endline ("Blank   : " ^ str) ;
				  print_machine tl
	| (Finals flst)::tl ->
				  print_string "Finals  : [ " ;
				  print_list flst ; print_endline " ]" ;
				  print_machine tl
	| (Transitions tlst)::tl -> print_transitions tlst ; print_machine tl
	| _	-> print_n_str "*" 81 ; print_newline ()
	

 
