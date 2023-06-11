*For an older version of this repository based on sedlex, refer to the [sedlex branch](../../tree/sedlex)*.

# Nice Parser

[![Build Status](https://github.com/smolkaj/nice-parser/workflows/build%20and%20test/badge.svg?branch=master)](https://github.com/smolkaj/nice-parser/actions)

Writing an OCaml parser with nice error messages should be easy - and now it is!
*Nice Parser* comes in two parts:

1. **lib/**: The [`nice_parser`](lib/) library ([API](http://smolkaj.github.io/nice-parser/nice_parser/)) consolidates boilerplate code and wraps your auto-generated parser in  a *nice* interface with beautiful error messages. 
In types: `Nice_parser.Make : functor(P : RAW_PARSER) -> NICE_PARSER`.
2. **example/**: The example parser lets you get started on your own parser in seconds. It is based on [`nice_parser`](lib/) and standard tools:
   * [Menhir](http://gallium.inria.fr/~fpottier/menhir/), a LR(1) parser generator.
   * [ocamllex](https://caml.inria.fr/pub/docs/manual-ocaml/lexyacc.html), OCaml's built-in lexer generator.
   * Jane Street's [dune](https://dune.build/) and [base](https://opensource.janestreet.com/base/), the de-facto standard built tool and standard library for OCaml.

Using the library and the skeleton, you can get started on your own parser in seconds:
```sh
git clone https://github.com/smolkaj/nice-parser.git  # clone this repository
cd nice-parser && rm -r lib && mv example src         # use example as starting point
opam install . --deps-only --with-test                # install dependencies
dune build                                            # try to build...
dune exec src/bin/main.exe                            # ...and run your parser!
```
You should see the following output (the error message relies on OCaml >= 4.08's new [source highlighting mechanism](https://github.com/ocaml/ocaml/pull/2096)):
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
The API is documented [here](http://smolkaj.github.io/nice-parser/nice_parser/).
The [example skeleton](example) should be self-explanatory.

## How to build
Ideally, use OCaml 4.08 or higher (for [beautiful error messages](https://github.com/ocaml/ocaml/pull/2096)).
All required dependencies can be installed using the [opam](http://opam.ocaml.org) package manager.
The project can be built using [dune](https://dune.build).
```
opam install . --deps-only --with-test
dune build
dune runtest
```

## Suggestions and Improvements
Suggestions and changes are welcome. Please submit pull requests, or open issues.
