all: fitspec.pdf

fitspec.pdf: fitspec.tex
	pdflatex -draftmode fitspec.tex
	pdflatex            fitspec.tex

clean:
	rm -f fitspec.{aux,log,out,pdf}
