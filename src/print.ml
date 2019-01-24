open Batteries

let rec print_list = function
  | []                 -> ()
  | x::tl when tl = [] -> print_string x; print_list tl
  | x::tl              -> print_string @@ x ^ ", "; print_list tl


let rec print_transition = function
  | (name, [])    -> ()
  | (name, t::tl) -> print_endline @@ "(" ^ name ^ ", " ^ String.make 1 t.Transition.read ^ ") -> ("
                                      ^ t.Transition.to_state ^ ", " ^ String.make 1 t.Transition.write ^ ", "
                                      ^ begin if t.Transition.action = Transition.Left then "LEFT" else "RIGHT" end
                                      ^ ")"; print_transition (name, tl)

let rec print_transitions states transitions =
  match states with
  | []    -> ()
  | s::tl -> match Hashtbl.find_option transitions s with
             | None -> print_transitions tl transitions
             | Some lst  -> print_transition (s, lst); print_transitions tl transitions

let machine_desc desc =
  print_endline @@ String.repeat "*" 81;
  print_endline @@ "*" ^ (String.repeat " " 79) ^ "*";
  print_endline @@ "*"
                   ^ (String.repeat " " (39 - ((String.length desc.Machine.name) / 2)))
                   ^ desc.Machine.name
                   ^ (String.repeat " " (39 - ((String.length desc.Machine.name) / 2)))
                   ^ begin if (String.length desc.Machine.name mod 2 = 1) then "*" else " *" end;
  print_endline @@ "*" ^ (String.repeat " " 79) ^ "*";
  print_endline @@ String.repeat "*" 81;
  print_string "Alphabet: [ "; print_list @@ List.map (String.make 1) desc.Machine.alphabet; print_endline " ]";
  print_string "States : [ "; print_list desc.Machine.states; print_endline " ]";
  print_endline @@ "Initial : " ^ desc.Machine.initial;
  print_string "Finals  : [ "; print_list desc.Machine.finals; print_endline " ]";
  print_transitions desc.Machine.states desc.Machine.transitions;
  print_endline @@ String.repeat "*" 81
