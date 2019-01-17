type t = {
    name : string;
    alphabet : char list;
    blank : char;
    states : string list;       (* Maybe use a string set *)
    initial : string;
    transitions : Transitions.t list
  }
