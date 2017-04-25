(** Thin wrapper around Menhir-generated parser, providing a saner interface. *)

val ast_of_string : ?pos: Lexing.position -> string -> unit
val ast_of_file : string -> unit
