open Batteries

type t = {
    name : string;
    alphabet : char list;
    blank : char;
    states : string list;
    initial : string;
    finals : string list;
    transitions : (string, Transition.t list) Hashtbl.t;
  }

let of_ast desc = {
    name = desc.Syntax.name;
    alphabet = desc.Syntax.alphabet;
    blank = desc.Syntax.blank;
    states = desc.Syntax.states;
    initial = desc.Syntax.initial;
    finals = desc.Syntax.finals;
    transitions = desc.Syntax.transitions;
  }

let is_in xs = flip List.mem xs

let is_valid_blank desc =
  if List.mem desc.blank desc.alphabet
  then Result.Ok desc
  else Result.Bad "Blank character is not in alphabet."

let is_valid_initial desc =
  if List.mem desc.initial desc.states
  then Result.Ok desc
  else Result.Bad "Initial state is not in state list."

let is_valid_finals desc =
  if List.for_all (is_in desc.states) desc.finals
  then Result.Ok desc
  else Result.Bad "Final states must be a sublist of state list."

let is_valid_transitions desc =
  if Enum.for_all (is_in desc.states) (Hashtbl.keys desc.transitions)
  then Result.Ok desc
  else Result.Bad "Transitions must be included in state list."

let is_valid_read desc =
  let values = Hashtbl.values desc.transitions in
  let _is_valid_read = List.for_all (is_in desc.alphabet) in
  let _reads = List.map (fun x -> x.Transition.read) in
  if Enum.for_all _is_valid_read @@ Enum.map _reads values
  then Result.Ok desc
  else Result.Bad "The values to be read must be in alphabet."

let is_valid_to_state desc =
  let values = Hashtbl.values desc.transitions in
  let _is_valid_to_state = List.for_all (is_in desc.states) in
  let _to_state = List.map (fun x -> x.Transition.to_state) in
  if Enum.for_all _is_valid_to_state @@ Enum.map _to_state values
  then Result.Ok desc
  else Result.Bad "The state transitions must be in state list."

let is_valid_write desc =
  let values = Hashtbl.values desc.transitions in
  let _is_valid_write = List.for_all (is_in desc.alphabet) in
  let _writes = List.map (fun x -> x.Transition.write) in
  if Enum.for_all _is_valid_write @@ Enum.map _writes values
  then Result.Ok desc
  else Result.Bad "The values to be write must be in alphabet."

let sanitize desc =
  let (>>=) = Result.Monad.bind in
  Result.Ok desc >>= is_valid_blank >>= is_valid_initial >>= is_valid_finals >>= is_valid_transitions >>= is_valid_read >>= is_valid_to_state >>= is_valid_write
