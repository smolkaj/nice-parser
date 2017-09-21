# ocaml-parsing
Writing a parser in OCaml requires a surprising amount of boilerplate code. This is a fully functional skeleton using standard tools:
* [Menhir](http://gallium.inria.fr/~fpottier/menhir/), a LR(1) parser generator
* [Sedlex](https://github.com/alainfrisch/sedlex), a lexer generator with Unicode support
* Jane Street's [core](https://ocaml.janestreet.com/ocaml-core/latest/doc/), the inofficial standard library for OCaml
* Jane Street's [jbuilder](http://oasis.forge.ocamlcore.org), an OCaml build system

## How to build
With [opam](http://opam.ocaml.org), OCaml's packet manager, all dependencies can be installed automatically:
```sh
opam update                                     # ensure opam is up to date
opam switch 4.05                                # install OCaml 4.05
eval `opam config env`                          # set env variables
opam pin add --no-action ocaml_parsing .        # install other...
opam install --yes --deps-only ocaml_parsing    # ...dependencies
```
Then, simply run `make` to build, and `make test` to build the test file. To run the test file, execute `_build/default/test/test.exe`.

The code has been last tested with OCaml 4.05.

## Suggestion and Improvements
Feel free to submit pull requests. Suggestions and changes are welcome.
