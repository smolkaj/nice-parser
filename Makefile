INSTALL_ARGS := $(if $(PREFIX),--prefix $(PREFIX),)

build:
	dune build	

install:
	dune install $(INSTALL_ARGS)

uninstall:
	dune uninstall $(INSTALL_ARGS)

reinstall: uninstall reinstall

clean:
	dune clean

doc:
	dune build @doc

test:
	dune build @runtest

all: build test doc

.PHONY: build install uninstall reinstall clean doc test all
