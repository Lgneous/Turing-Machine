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
