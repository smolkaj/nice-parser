open Core
open Ocaml_parsing

let () = begin
  printf "\n\nIt's working!\n";

  (* enable pretty error messages *)
  Parser.pp_exceptions ();

  printf "\nMy Tokens:\n";
  List.iter Lexer.all_of_token ~f:(fun t ->
    Lexer.show_token t
    |> printf "  %s\n");

  let s1 = "() ( ()() (()()) )" in
  let s2 = "( () ()" in
  let s3 = "( () () ) ) ()" in
  List.iter [s1; s2; s3 ] ~f:(fun s ->
    printf "\nTrying to parse \"%s\".\n" s;
    Parser.ast_of_string s;
    printf "-> success!\n";
  );
  ()
end
