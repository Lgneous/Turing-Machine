type t

val make : string -> char -> t

val tape : t -> string

val head : t -> int

val write : t -> char -> t

val read : t -> char

val left : t -> t

val right : t -> t

val shift : t -> Transition.action -> t

val to_string : t -> string
