# Suppress duplicate topdirs.cmi warnings.
OCAMLFIND_IGNORE_DUPS_IN = $(shell ocamlfind query compiler-libs)
export OCAMLFIND_IGNORE_DUPS_IN

.NOTPARALLEL:

default:
	oasis setup-clean
	oasis setup
	./configure --enable-tests
	$(MAKE) -C . all

# OASIS_START
# OASIS_STOP
