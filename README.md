# ocaml-parsing
Writing a parser in OCaml requires a surprising amount of boilerplate code. This is a fully functional skeleton using standard tools:
* [Menhir](http://gallium.inria.fr/~fpottier/menhir/), a LR(1) parser generator
* [Sedlex](https://github.com/alainfrisch/sedlex), a lexer generator with Unicode support
* Jane Street's [core](https://ocaml.janestreet.com/ocaml-core/latest/doc/), the inofficial standard library for OCaml
* [oasis](http://oasis.forge.ocamlcore.org), a tool that simplifies building OCaml projects

## How to build
With [opam](http://opam.ocaml.org), OCaml's packet manager, all dependencies can be installed automatically:
```sh
opam update                                                                   # ensure opam is up to date
opam switch 4.04.2                                                            # install OCaml 4.04.2
eval `opam config env`                                                        # set env variables
opam install menhir sedlex core oasis ppx_import ppx_enumerate ppx_deriving   # other dependencies
```
Then, simply run `make` to compile and run `test.ml`.

The code has been last tested with OCaml 4.04.2 and oasis 0.4.10.
