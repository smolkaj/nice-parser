let reraise exn =
  Printexc.(raise_with_backtrace exn (get_raw_backtrace ()))


module type RAW_PARSER = sig
  type token
  type result
  exception LexError of string
  exception ParseError
  val next_token : Lexing.lexbuf -> token
  val parse : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> result
end

module type NICE_PARSER = sig
  type token
  type result
  exception LexError of { msg: string; loc: Location.t }
  exception ParseError of { token: token; loc: Location.t }
  val pp_exceptions : Format.formatter -> exn -> unit
  val register_exception_pp : unit -> unit
  val parse_string : ?pos:Lexing.position -> string -> result
  val parse_chan : ?pos:Lexing.position -> in_channel -> result
  val parse_file : string -> result
end


module Make (P : RAW_PARSER) : NICE_PARSER with 
  type token = P.token and
  type result = P.result
= struct

  type token = P.token
  type result = P.result
  exception LexError of { msg: string; loc: Location.t }
  exception ParseError of { token: token; loc:Location.t }


  (* MUTABLE STATE *)

  let curr_token : token option ref = 
    ref None

  let curr_lexbuf : Lexing.lexbuf option ref =
    ref None

  let curr_input () : Pp_loc.Input.t option =
    match !curr_lexbuf with
    | None -> None
    | Some { lex_start_p=start; lex_curr_p=curr; lex_buffer; _ } ->
      if start.pos_fname = curr.pos_fname && curr.pos_fname <> "" then
        Some (Pp_loc.Input.file curr.pos_fname)
      else
        Some (Pp_loc.Input.bytes lex_buffer)


  (* LEXING / PARSING *)

  let next_token lexbuf =
    let token = P.next_token lexbuf in
    curr_token := Some token;
    token

  let parse lexbuf =
    curr_lexbuf := Some lexbuf;
    try 
      P.parse next_token lexbuf
    with
    | P.LexError msg ->
      reraise (LexError { msg; loc = Location.curr lexbuf })
    | P.ParseError ->
      let[@warning "-8"] (Some token) = !curr_token in
      reraise (ParseError { token; loc = Location.curr lexbuf })

  let parse_string ?(pos : Lexing.position option) s =
    match pos with
    | None ->
      parse Lexing.(from_string s)
    | Some p ->
      parse Lexing.{(from_string s) with lex_start_p=p; lex_curr_p=p}

  let parse_chan ?(pos : Lexing.position option) chan =
    match pos with
    | None ->
      parse Lexing.(from_channel chan)
    | Some p ->
      parse Lexing.{(from_channel chan) with lex_start_p=p; lex_curr_p=p}

  let parse_file file =
    Stdio.In_channel.with_file file ~f:(fun chan ->
      let lexbuf = Lexing.from_channel chan in
      Location.init lexbuf file;
      parse lexbuf
    )


  (* PRETTY EXCEPTIONS *)

  (* underline errors in red and bold *)
  let single_line_underline = Pp_loc.{
    open_tag = (fun () -> "\x1b[1m\x1b[31m");
    close_tag = (fun () -> "\x1b[39m\x1b[0m");
  }

  let pp_loc fmt loc : unit =
    Format.fprintf fmt "@.%a:@." Location.print_loc loc

  let pp_exceptions fmt exn : unit =
    match exn with
    | LexError {loc; _} | ParseError {loc; _} ->
      pp_loc fmt loc;
      begin match curr_input () with
      | Some inp ->
        Pp_loc.pp inp fmt [(loc.loc_start, loc.loc_end)]
      | None ->
        ()
      end
    | _ -> ()

  let register_exception_pp () = begin
    let buf = Buffer.create 128 in
    let fmt = Format.formatter_of_buffer buf in
    Pp_loc.setup_highlight_tags fmt ~single_line_underline ();
    Printexc.register_printer (function 
      | LexError _ | ParseError _ as exn ->
        pp_exceptions fmt exn;
        Format.pp_print_flush fmt ();
        let err = Buffer.contents buf in
        Buffer.reset buf;
        Some err
      | _ ->
        None
    )
  end

end
