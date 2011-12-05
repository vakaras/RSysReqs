TEXINPUTS := .:./config:./common:./deps:./content:./examples:
export TEXINPUTS

RMTOO=./tools/bin/rmtoo -m ${PWD}/tools/apps/rmtoo
CALL_RMTOO=${RMTOO} -j file://config/rmtoo.json

.PHONY: force
force: clean all

all: dist/main.pdf dist/req-graph1.png dist/req-graph2.png

include dist/.rmtoo_dependencies


dist/req-graph1.png: dist/req-graph1.dot
	unflatten -l 23 dist/req-graph1.dot | \
		dot -Tpng -o dist/req-graph1.png

dist/req-graph2.png: dist/req-graph2.dot
	dot -Tpng -o dist/req-graph2.png dist/req-graph2.dot

dist/main.pdf: ${REQS_LATEX2} content/*.tex
	xelatex -shell-escape -output-directory dist "\input{config/main.tex}"
	xelatex -shell-escape -output-directory dist "\input{config/main.tex}"

dist/.rmtoo_dependencies:
	${CALL_RMTOO} \
		--create-makefile-dependencies=dist/.rmtoo_dependencies

clean:
	rm -f dist/.rmtoo_dependencies dist/*.pdf dist/*.tex dist/*.png

show:
	xdg-open dist/main.pdf

graph1:
	xdg-open dist/req-graph1.png

graph2:
	xdg-open dist/req-graph2.png
