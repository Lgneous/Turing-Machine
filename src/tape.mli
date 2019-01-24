type t

val make : string -> char -> t

val tape : t -> string
val head : t -> int

val write : t -> char -> t
val read : t -> t

val left : t -> t
val right : t -> t
