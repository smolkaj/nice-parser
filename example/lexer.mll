{
open Menhir_parser

exception LexError of string

let[@inline] failwith msg = raise (LexError msg)

let[@inline] illegal c =
  failwith (Printf.sprintf "[lexer] unexpected character: '%c'" c)
}

(* regular expressions *)
let whitespace = ' ' | '\t'
let newline = "\r\n" | '\r' | '\n'
let ident = ['A'-'Z' 'a'-'z' '0'-'9' '_']*

rule next_token = parse
  | eof { EOF }
  | whitespace+
    { next_token lexbuf }
  | newline
    { Lexing.new_line lexbuf; next_token lexbuf }
  | "(*"
    { comment 0 lexbuf; next_token lexbuf }

  (* YOUR TOKENS HERE... *)
  | '(' { LPAR }
  | ')' { RPAR }

  (* lex identifiers last, so keywords are not lexed as identifiers *)
  | ident as atom { ATOM atom }

  (* no match? raise exception *)
  | _ as c { illegal c }


(* allow nested comments, like OCaml *)
and comment nesting = parse
  | "(*"
    { comment (nesting+1) lexbuf }
  | "*)"
    { if nesting > 0 then comment (nesting - 1) lexbuf }
  | eof
    { failwith "[lexer] unterminated comment at EOF" }
  | _
    { comment nesting lexbuf }

