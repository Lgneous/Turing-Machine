open Batteries

type t = Syntax.t

let print_n_str x n =
  print_string @@ String.repeat x n

let rec print_list = function
  | str :: tl when tl <> [] -> print_string (str ^ ", ") ; print_list tl
  | str :: tl -> print_string str; print_list tl
  | _ -> ()

let rec print_transitions = function
  | (name,lst) :: tl -> List.iter
                          (fun t -> print_endline (
			                "(" ^ name ^ ", " ^ t.Transition.read ^ ") -> ("
			                ^ t.Transition.to_state ^ ", " ^ t.Transition.write ^ ", "
			                ^ if t.Transition.action = Transition.Left then "LEFT)"
				          else "RIGHT)" )
		          ) lst; print_transitions tl
  | _ -> ()

let rec print_machine = function
  | (Syntax.Name str) :: tl ->
     print_n_str "*" 81; print_newline (); print_char '*';
     print_n_str " " 79; print_endline "*"; print_char '*';
     print_n_str " " (39 - ((String.length str) / 2));
     print_string str;
     print_n_str " " (39 - ((String.length str) / 2));
     if (String.length str) mod 2 = 0 then print_char ' ';
     print_endline "*"; print_char '*'; print_n_str " " 79;
     print_endline "*"; print_n_str "*" 81; print_newline ();
     print_machine tl
  | (Syntax.Alphabet alst) :: tl ->
     print_string "Alphabet: [ ";
     print_list alst ; print_endline " ]";
     print_machine tl
  | (Syntax.States slst) :: tl ->
     print_string "States  : [ ";
     print_list slst ; print_endline " ]";
     print_machine tl
  | (Syntax.Initial str) :: tl ->
     print_endline ("Initial : " ^ str);
     print_machine tl
  | (Syntax.Blank str) :: tl ->
     print_endline ("Blank   : " ^ str) ;
     print_machine tl
  | (Syntax.Finals flst)::tl ->
     print_string "Finals  : [ ";
     print_list flst; print_endline " ]";
     print_machine tl
  | (Syntax.Transitions tlst) :: tl -> print_transitions tlst; print_machine tl
  | _ -> print_n_str "*" 81; print_newline ()
