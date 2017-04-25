(** Thin wrapper around Menhir-generated parser, providing a saner interface. *)

let ast_of_string ?pos (s : string) =
  My_Lexer.parse_string ?pos s My_Generated_Parser.ast_eof

let ast_of_file (file : string) =
  My_Lexer.parse_file ~file My_Generated_Parser.ast_eof
