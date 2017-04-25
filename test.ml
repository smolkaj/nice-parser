open Core.Std

let () = begin
  printf "\n\nIt's working!\n";
  printf "My Tokens:\n";
  List.iter My_Lexer.all_of_token ~f:(fun t ->
    My_Lexer.show_token t
    |> printf "  %s\n");
  ()
end
