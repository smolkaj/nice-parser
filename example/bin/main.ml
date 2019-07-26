open Base

let printf = Stdlib.Printf.printf

let () = begin

  (* enable pretty error messages *)
  Example.Parser.pp_exceptions ();

  let s1 = "(a b (c d) e)" in
  let s2 = "(long_atom_with_0123)" in
  let s3 = {|
    ( so far so good
          but (this is)) illegal (isnt it?)
    (* parsing will fail ^^^^^^^ here *)
  |}
  in
  List.iter [s1; s2; s3 ] ~f:(fun s ->
    printf "\nTrying to parse \"%s\".\n" s;
    Example.Parser.parse_string s
    |> Example.Ast.sexp_of_sexp
    |> Sexp.to_string_hum
    |> printf "-> %s\n";
  );
end
