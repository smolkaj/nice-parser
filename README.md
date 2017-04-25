*For an older version of this repository based on sedlex, refer to the [sedlex branch](../../tree/sedlex)*.

# Nice_parser [![Build Status](https://travis-ci.org/smolkaj/ocaml-parsing.svg?branch=master)](https://travis-ci.org/smolkaj/ocaml-parsing)

Writing a parser in OCaml ~requires~ used to require a lot of boilerplate code.
Nice_parser changes this:
1. The [`nice_parser`](src/) library (API documented [here](http://smolkaj.github.io/ocaml-parsing/nice_parser/))  consolidates boilerplate code that can be shared among all parsers, providing a sane interface (with beautiful error messages) to your \{menhir, ocamlyacc\}-generated parser.
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
You should see the following output (the error message relies on OCaml >= 4.08):
```
Trying to parse "(a b (c d) e)".
-> (List ((Atom a) (Atom b) (List ((Atom c) (Atom d))) (Atom e)))

Trying to parse "(long_atom_with_0123)".
-> (List ((Atom long_atom_with_0123)))

Trying to parse "
    ( so far so good
          but (this is)) illegal (isnt it?)
    (* parsing will fail ^^^^^^^ here *)
  ".
Fatal error: exception Line 3, characters 25-32:
3 |           but (this is)) illegal (isnt it?)
                             ^^^^^^^
Error: [parser] unexpected token
```

## Documentation
The API is documented [here](http://smolkaj.github.io/ocaml-parsing/nice_parser/).
The [example skeleton](example) should be self-explanatory.

## How to build
Ideally, use OCaml 4.08 or higher (for [beautiful error messages](https://github.com/ocaml/ocaml/pull/2096)).
The project can be built using [dune](dune.build).
Consult the [dune-project file](dune-project) for the necessary dependencies;
all can be installed using [opam](http://opam.ocaml.org), OCaml's packet manager.

## Suggestions and Improvements
Suggestions and changes are welcome. Please submit pull requests, or open issues.
