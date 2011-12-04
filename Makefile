TEXINPUTS := .:./config:./common:./deps:./content:./examples:
export TEXINPUTS

RMTOO=./tools/bin/rmtoo -m ${PWD}/tools/apps/rmtoo
CALL_RMTOO=${RMTOO} -j file://config/rmtoo.json

all: dist/main.pdf

include dist/.rmtoo_dependencies

dist/main.pdf: ${REQS_LATEX2} content/*.tex
	xelatex -shell-escape -output-directory dist "\input{config/main.tex}"
	xelatex -shell-escape -output-directory dist "\input{config/main.tex}"

dist/.rmtoo_dependencies:
	${CALL_RMTOO} \
		--create-makefile-dependencies=dist/.rmtoo_dependencies

.PHONY: force
force: clean all

clean:
	rm -f dist/.rmtoo_dependencies dist/*.pdf

show:
	xdg-open dist/main.pdf
