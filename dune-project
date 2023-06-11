(lang dune 1.10)

(using menhir 2.0)

(generate_opam_files true)

(name nice_parser)

(version 1.0.0)

(license MIT)

(source
 (github smolkaj/nice-parser))

(authors "Steffen Smolka <steffen.smolka@gmail.com>")

(maintainers "Steffen Smolka <steffen.smolka@gmail.com>")

(documentation "https://smolkaj.github.io/nice-parser/nice_parser/")

(package
 (name nice_parser)
 (synopsis "Nice parsers without the boilerplate")
 (description
  "Nice_parser wraps your {menhir, ocamlyacc}-generated parser in a sane interface, eliminating boilerplate code.")
 (depends
  (ocaml
   (>= 4.08.0))
  (dune
   (and
    :build
    (>= 1.10)))
  (stdio
   (<> 0))
  (base :with-test)
  (menhir :with-test)
  (ppx_jane :with-test)
  (odoc :with-doc)))
