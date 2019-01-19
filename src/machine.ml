open Batteries

type t = {
    name : string;
    alphabet : char list;
    blank : char;
    states : string list;       (* Maybe use a string set *)
    initial : string;
    transitions : Transitions.t list
  }

let of_ast ast =
  let name = Syntax.filter Syntax.is_string "Invalid type: name value should be a string." @@ Syntax.assoc_uniq "name" ast in
  let alphabet = Syntax.filter (Syntax.for_all_list Syntax.is_char) "Invalid type: alphabet value should be a char list." @@ Syntax.assoc_uniq "alphabet" ast in
  let blank = Syntax.filter Syntax.is_char "Invalid type: blank value should be a char." @@ Syntax.assoc_uniq "blank" ast in
  let states = Syntax.filter (Syntax.for_all_list Syntax.is_string) "Invalid type: states value should be a string list." @@ Syntax.assoc_uniq "states" ast in
  let initial = Syntax.filter Syntax.is_string "Invalid type: initial value should be a string." @@ Syntax.assoc_uniq "initial" ast in
  print_bool @@ List.for_all Result.is_ok [name;alphabet;blank;states;initial]
