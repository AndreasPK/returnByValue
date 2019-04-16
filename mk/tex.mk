# Simple tex implicit rules
# for a fancier version, see fancytex.mk
#
#
#
#
#   . . .
# Intentional blank space so that this file lines up
# with fancytex.mk when using tabs in vim or emacs
#   . . .
#

PDFLATEX     =          pdflatex -halt-on-error
FASTPDFLATEX =          $(PDFLATEX) -draftmode
HASBIB       =          grep -q '^\\bibdata{.*}$$'
BIBTEX       =          bibtex


%.pdf: %.tex
	$(FASTPDFLATEX) $<
	if $(HASBIB) $*.aux; then \
	  $(BIBTEX) $* && \
	  $(FASTPDFLATEX) $<; \
	fi
	$(PDFLATEX) $<


# Only needed for automatic compilation of handout mode beamer slides:
%-handout.pdf: %.tex
	$(FASTPDFLATEX) -jobname $*-handout $<
	if $(HASBIB) $*-handout.aux; then \
	  $(BIBTEX) $*-handout && \
	  $(FASTPDFLATEX) -jobname $*-handout $<; \
	fi
	$(PDFLATEX) -jobname $*-handout $<


cleanauxs:
	rm -f *~ *.aux *.bbl *.blg *.log *.toc *.nav *.out *.snm
