open Batteries

type ast =
  | Assoc of (string * ast) list
  | List of ast list
  | String of string

val is_assoc : ast -> bool

val is_list : ast -> bool

val for_all_list : (ast -> bool) -> ast -> bool

val is_string : ast -> bool

val is_char : ast -> bool

val assoc_uniq : string -> ast -> (ast, string) Result.t

val filter : (ast -> bool) -> string -> (ast, string) Result.t -> (ast, string) Result.t
