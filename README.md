*For an older version of this repository based on sedlex, refer to the [sedlex branch](../../tree/sedlex)*.

# Nice_parser [![Build Status](https://travis-ci.org/smolkaj/ocaml-parsing.svg?branch=master)](https://travis-ci.org/smolkaj/ocaml-parsing)

Writing a parser in OCaml ~requires~ used to require a lot of boilerplate code.
Nice_parser changes this:
1. The [`Nice_parser`](src/nice_parser.ml) module (available on `opam`)  consolidates boilerplate code that can be shared among all parsers, providing a sane interface (with beautiful error messages) to your \{menhir, ocamlyacc\}-generated parser.
2. The [example](example) folder contains a fully functional parser skeleton based on `Nice_parser` and standard tools:
   * [Menhir](http://gallium.inria.fr/~fpottier/menhir/), a LR(1) parser generator.
   * [ocamllex](https://caml.inria.fr/pub/docs/manual-ocaml/lexyacc.html), OCaml's built-in lexer generator.
   * Jane Street's [dune](https://dune.build/), the inofficial standard build system for OCaml.
   * Jane Street's [base](https://opensource.janestreet.com/base/), the inofficial standard library for OCaml.

You can get started with your own parser in seconds:
```sh
opam install nice_parser                                  # install the nice_parser library
git clone https://github.com/smolkaj/ocaml-parsing.git    # clone this repository
cd ocaml-parsing && rm -r src && mv example src           # use example as starting point
dune build src/example.a                                  # try to build...
dune exec src/bin/main.exe                                # ...and run your parser!
```

## API documentation
Available [here](http://smolkaj.github.io/ocaml-parsing/).

## How to build
**TODO: update**
With [opam](http://opam.ocaml.org), OCaml's packet manager, all dependencies can be installed automatically:
```sh
opam update                                     # ensure opam is up to date
opam switch 4.06                                # install OCaml 4.06
eval `opam config env`                          # set env variables
opam pin add --yes --no-action ocaml_parsing .  # install other...
opam install --yes --deps-only ocaml_parsing    # ...dependencies
```
Then, simply run `make` to build, and `make test` to build and run the test file. (The final test will result in an error message, this is expected.)

The code has been last tested with OCaml 4.08.

## Suggestions and Improvements
Suggestions and changes are welcome. Please submit pull requests, or open issues.
