open Batteries

type ast =
  | Assoc of (string * ast) list
  | List of ast list
  | String of string

let is_assoc = function
  | Assoc _ -> true
  | _ -> false

let is_list = function
  | List _ -> true
  | _ -> false

let for_all_list f = function
  | List xs -> List.for_all f xs
  | _ -> false

let is_string = function
  | String _ -> true
  | _ -> false

let is_char = function
  | String s when String.length s = 1 -> true
  | _ -> false

let assoc_uniq x ast =
  let rec _assoc_uniq = function
    | [] -> Result.Bad (x ^ " not found.")
    | (k, v) :: tl when k = x && not @@ List.mem_assoc x tl -> Result.Ok v
    | (k, v) :: tl when k = x -> Result.Bad ("Duplicates entries for " ^ x ^ ".")
    | _ :: tl -> _assoc_uniq tl
  in
  match ast with
  | Assoc xs -> _assoc_uniq xs
  | _ -> Result.Bad "Invalid type: should be an object."

let filter f err_msg = function
  | Result.Ok x -> if f x then Result.Ok x else Result.Bad err_msg
  | err -> err
