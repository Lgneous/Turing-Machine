open Batteries

type action = Left | Right

type t = {read: char; to_state: string; write: char; action: action}

let rec from_read trans c =
  match trans with
  | [] -> Result.Bad (String.make 1 c ^ " not found.")
  | hd :: tl -> if c = hd.read then Result.Ok hd else from_read tl c
