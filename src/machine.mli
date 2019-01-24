type t = {
    name : string;
    alphabet : char list;
    blank : char;
    states : string list;
    initial : string;
    finals : string list;
    transitions : (string, Transition.t list) Hashtbl.t;
  }

val of_ast : Syntax.t -> t

val sanitize : t -> (t, string) BatResult.t

val run : t -> Tape.t -> string -> string
