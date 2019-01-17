type action = Left | Right

type t = {
    read : char;
    to_state : string;
    write : char;
    action : action
  }
