.PHONY: build install uninstall test clean doc

build:
	dune build

test:
	dune runtest -f --no-buffer

install:
	dune install

uninstall:
	dune uninstall

doc:
	dune build @doc --profile release

clean:
	dune clean
