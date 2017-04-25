# ocaml-parsing
Writing a parser in OCaml requires a surprising amount of boilerplate code. This is a fully functional skeleton using standard tools:
* (Menhir)[http://gallium.inria.fr/~fpottier/menhir/], a LR(1) parser generator
* (Sedlex)[https://github.com/alainfrisch/sedlex], a lexer generator with Unicode support
* Jane Street's (core)[https://ocaml.janestreet.com/ocaml-core/latest/doc/], OCaml's inofficial standard library
* (oasis)[http://oasis.forge.ocamlcore.org], a tool that simplifies building OCaml projects
