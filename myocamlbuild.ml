(* OASIS_START *)
(* OASIS_STOP *)
(* use extern token file *)
flag ["ocaml"; "menhir"; "extern_tokens"] & S[A"--external-tokens"; A"My_Tokens"];
Ocamlbuild_plugin.dispatch dispatch_default;;
