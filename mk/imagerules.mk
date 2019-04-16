# General rules for making images

%.pdf: %.eps
	epstopdf $< > $@

%.eps: %.dot
	dot -Tps < $< > $@

%.pdf: %.svg
	inkscape -A $@ $<

%.eps: %.plt
	pyxplot $<

%.eps: %.dia
	dia -e $@ -t eps $<

# Recently (2015), the pdf driver for dot has not been giving optimal results
# It is better to have only rules above: dot -> eps -> pdf
#%.pdf: %.dot
#	dot -Tpdf < $< > $@

#%.svg: %.dot
#	dot -Tsvg < $< > $@

