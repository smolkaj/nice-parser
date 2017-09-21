#include "Tokens.ml"
  [@@deriving show, enumerate]

type ('token, 'a) parser =
  (Lexing.lexbuf -> 'token) -> Lexing.lexbuf -> 'a

val parse : LexBuffer.t -> (token,'a) parser -> 'a

val parse_string : ?pos:Lexing.position -> string  -> (token,'a) parser -> 'a
  
val parse_file : file:string -> (token,'a) parser -> 'a
