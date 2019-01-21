open Batteries

type t = {
    name : string;
    alphabet : string list;
    blank : string;
    states : string list;
    initial : string;
    finals : string list;
    transitions : (string, Transition.t list) Hashtbl.t;
  }
