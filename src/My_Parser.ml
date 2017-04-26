(** Thin wrapper around Menhir-generated parser, providing a saner interface. *)

let ast_of_string ?pos (s : string) =
  My_Lexer.parse_string ?pos s My_Generated_Parser.ast_eof

let ast_of_file (file : string) =
  My_Lexer.parse_file ~file My_Generated_Parser.ast_eof

(** Registers a pretty printer for lex and parse exceptions. This results in
    colorful error messages including the source location when errrors occur. *)
let pp_exceptions () : unit =
  Printexc.register_printer (fun exn -> Core.Std.Option.try_with (fun () ->
    Location.report_exception Format.str_formatter exn;
    Format.flush_str_formatter ()))
