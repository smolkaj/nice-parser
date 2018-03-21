# ocaml-parsing
Writing a parser in OCaml requires a surprising amount of boilerplate code. This is a fully functional skeleton using standard tools:
* [Menhir](http://gallium.inria.fr/~fpottier/menhir/), a LR(1) parser generator.
* [Sedlex](https://github.com/alainfrisch/sedlex), a lexer generator with Unicode support.
* Jane Street's [base](https://opensource.janestreet.com/), the inofficial standard library for OCaml.
* Jane Street's [dune](https://opensource.janestreet.com/) (formerly jbuilder), an OCaml build system.

## How to build
With [opam](http://opam.ocaml.org), OCaml's packet manager, all dependencies can be installed automatically:
```sh
opam update                                     # ensure opam is up to date
opam switch 4.06                                # install OCaml 4.06
eval `opam config env`                          # set env variables
opam pin add --yes --no-action ocaml_parsing .  # install other...
opam install --yes --deps-only ocaml_parsing    # ...dependencies
```
Then, simply run `make` to build, and `make test` to build and run the test file. (The final test will result in an error message, this is expected.)

The code has been last tested with OCaml 4.06.

## Suggestion and Improvements
Feel free to submit pull requests. Suggestions and changes are welcome.
