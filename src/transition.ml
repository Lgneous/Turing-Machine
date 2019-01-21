open Batteries

type action = Left | Right

type t = {
    read : string;
    to_state : string;
    write : string;
    action : action
  }
