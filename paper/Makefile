# Makefile for a paper
#

TITLE=rbv
FIGS=fig/*
BIBS=bib/*.bib
TEXS= \
  $(TITLE).tex \
  abstract.tex \
  intro.tex \
  optimization.tex \
  stg.tex \
  analysis.tex \
  transform.tex \
  evaluation.tex \
  discussion.tex \
  discussion/limitations.tex \
  related-work.tex \
  conclusion.tex
PDFS=$(TITLE).pdf


# Making Rules

all: $(PDFS)

a4: $(TITLE)-a4.pdf

$(TITLE).pdf: $(TEXS) $(BIBS) # $(FIGS)

%-a4.pdf: %.pdf
	pdfcrop --bbox "48 68 564 744" --margins 30 $*.pdf
	pdfresizetoa4 $*-crop.pdf $*-a4.pdf

.PHONY: figs
figs: $(FIGS)


# Cleanup rules

.PHONY: clean cleanfigs
clean: cleanauxs
	rm -f $(PDFS)

include mk/tex.mk
