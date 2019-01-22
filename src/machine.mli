type t = {
    name : string;
    alphabet : string list;
    blank : string;
    states : string list;
    initial : string;
    finals : string list;
    transitions : (string, Transition.t list) Hashtbl.t;
  }

val of_ast : Syntax.t -> t

val sanitize : t -> (t, string) BatResult.t