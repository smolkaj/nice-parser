include Nice_parser.Make(struct
  type result = Ast.sexp
  type token = Menhir_parser.token
  exception ParseError = Menhir_parser.Error
  let parse = Menhir_parser.sexp_eof
  include Lexer
end)


(*===========================================================================*)
(* TESTS                                                                     *)
(* https://dune.readthedocs.io/en/stable/tests.html#inline-expectation-tests *)
(*===========================================================================*)

let%test_module _ = (module struct
  
  let () = Printexc.record_backtrace false

  let%expect_test "atom" =
    parse_string "this_is_AN_At0m"
    |> Printf.printf !"%{sexp:Ast.sexp}";
    [%expect{| (Atom this_is_AN_At0m) |}]

  let%expect_test "whitespace" =
    parse_string "   \t\n this_also_is_an_atom \t"
    |> Printf.printf !"%{sexp:Ast.sexp}";  
    [%expect{| (Atom this_also_is_an_atom) |}]

  let%expect_test "illegal atom" =
    parse_string "  *$-# "
    |> Printf.printf !"%{sexp:Ast.sexp}";  
    [%expect.unreachable]
  [@@expect.uncaught_exn {|
    ("Nice_parser.Make(P).LexError(\"[lexer] unexpected character: '*'\", _)")
  |}]

  let%expect_test "empty list" =
    parse_string "()"
    |> Printf.printf !"%{sexp:Ast.sexp}";  
    [%expect{| (List ()) |}]

  let%expect_test "complex example" =
    {|
      (
        (
          list in a list  (* comment within a list *)
          (list in a list in a list)
          42 is the answer to all questions
          (* (this S-expression
               (has been commented out)
             )
          (* Block comments *) can be "nested" *)
        )
      )
    |}
    |> parse_string
    |> Printf.printf !"%{sexp:Ast.sexp}";
    [%expect{|
      (List
       ((List
         ((Atom list) (Atom in) (Atom a) (Atom list)
          (List
           ((Atom list) (Atom in) (Atom a) (Atom list) (Atom in) (Atom a)
            (Atom list)))
          (Atom 42) (Atom is) (Atom the) (Atom answer) (Atom to) (Atom all)
          (Atom questions)))))
    |}]

  let%expect_test "illegal list" =
    parse_string "this aint a list"
    |> Printf.printf !"%{sexp:Ast.sexp}";
    [%expect.unreachable]
  [@@expect.uncaught_exn {| ("Nice_parser.Make(P).ParseError(_, _)") |}]

end)
