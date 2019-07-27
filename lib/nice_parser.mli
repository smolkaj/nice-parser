(** Eliminates Boilerplate code that can be shared among all parsers,
    providing a sane interface to \{menhir, ocamlyacc\}-generated parser.

    Simply pass your auto-generated parser to the [Make] functor to nicify its
    interface:
    {[
      (* parser.ml *)
      include Nice_parser.Make(struct
        (* hook up your auto-generated parser here *)
        ...
      end)
    ]}
    Among other benefits, this will make your parser produce beautiful
    error messages like this (see {!NICE_PARSER.pp_exceptions}):
    {[
      File "examples/illegal.katbb", line 1, characters 10-17:
      1 | this!; is illegal!; isntit?
                    ^^^^^^^
      Error: [parser] unexpected token
  ]}
    
*)


(** The raw interface to an auto-generated parser/lexer pair. *)
module type RAW_PARSER = sig
  
  (** {1 Types} *)

  (** Tokens produced by lexer and consumed by auto-generated parser.  
      For menhir-generated parsers, [type token = Menhir_parser.token]. *)
  type token
  
  (** Your parser produces results of this type. *)
  type result


  (** {1 Exceptions} *)
  
  (** Exception (with error message) thrown by lexer in case of errors. *)
  exception LexError of string
  
  (** Exception thrown by auto-generated parser.  For menhir-generated parsers,
      [exception ParseError = Menhir_parser.Error] *)
  exception ParseError


  (** {1 Entrypoints} *)

  (** Entrypoint to auto-generated lexer. *)
  val next_token : Lexing.lexbuf -> token
  
  (** Entrypoint to auto-generated parser. *)
  val parse : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> result
end


(** The nicified interface to your parser. *)
module type NICE_PARSER = sig

  (** {1 Types} 
      Inherited from {!RAW_PARSER}. *)

  type token
  type result

  (** {1 Exceptions} 
    Nice exceptions include the location at which an error occured.
    A nice {!ParseErrror} also includes the {!token} which caused the parser
    to choke, which can be useful for debugging. *)
  
  exception LexError of { msg: string; loc: Location.t }
  exception ParseError of { token: token; loc: Location.t }
  
  val pp_exceptions : unit -> unit
  (** Registers a pretty printer for {!LexError} and {!ParseError}. This results
      in colorful error messages including the source location when errrors
      occur. With OCaml >= 4.08, the pretty printer will also quote the
      problematic location in the soure code and underline the error location,
      like so:
      {[
        File "examples/illegal.katbb", line 1, characters 10-17:
        1 | this!; is illegal!; isntit?
                      ^^^^^^^
        Error: [parser] unexpected token
      ]}
   *)
  
  (** {1 Parsing} *) 

  val parse_string : ?pos:Lexing.position -> string -> result
  val parse_chan : ?pos:Lexing.position -> in_channel -> result
  val parse_file : string -> result
end


(** Pass your parser/lexer to this functor to obtain a nicer interface,
    without having to write boilerplate code. *)
module Make : functor (P:RAW_PARSER) -> NICE_PARSER with
  type token = P.token and
  type result = P.result
