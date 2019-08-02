#!/bin/bash
if ! opam switch $OCAML; then
  rm -rf ~/.opam/$OCAML
  opam init --yes --bare
  opam switch create $OCAML
fi
eval $(opam env)
opam upgrade --yes --all
opam pin remove --yes $PACKAGE; opam pin add --yes --no-action $PACKAGE .
opam install --yes --deps-only $PACKAGE
opam install --yes --verbose --build-doc --build-test --keep-build-dir $PACKAGE
