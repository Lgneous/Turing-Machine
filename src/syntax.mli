type t =
  { name: string
  ; alphabet: char list
  ; blank: char
  ; states: string list
  ; initial: string
  ; finals: string list
  ; transitions: (string, Transition.t list) Hashtbl.t }
