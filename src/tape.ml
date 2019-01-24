open Batteries

type t = (string * int * char)

let make input blank = (input, 0, blank)

let tape (tape, _, _) = tape
let head (_, head, _) = head

let write (tape, head, blank) c =
  let tape = Bytes.of_string tape in
  String.set tape head c;
  Bytes.to_string tape, head, blank

let read (tape, head, _) =
  String.get tape head

let left (tape, head, blank) =
  if head = 0
  then String.make 1 blank ^ tape, head, blank
  else tape, head - 1, blank

let right (tape, head, blank) =
  if head = String.length tape - 1
  then tape ^ String.make 1 blank, head + 1, blank
  else tape, head + 1, blank

let shift t = function
  | Transition.Left -> left t
  | Transition.Right -> right t