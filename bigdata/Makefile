FILE=vonLaszewski-bigdata

all:
	pdflatex ${FILE}
	bibtex ${FILE}
	pdflatex ${FILE}
	pdflatex ${FILE}

clean:
	rm -rf *~ *.aux *.bbl *.dvi *.log *.out *.blg *.pdf *.toc *.fdb_latexmk *.fls
view:
	open ${FILE}.pdf

# all dependce tracking taking care of by Latexmk
fast:
	latexmk -pdf ${FILE}

watch:
	latexmk -pvc -view=pdf ${FILE}

.PHONY: all clean view fast watch

publish:
	@echo "==============================================================="
	@echo "publish ${FILE}.pdf -> http://cyberaide.github.io/papers/${FILE}.pdf" 
	@echo "==============================================================="
	cp ${FILE}.pdf /tmp
	cd ..; git checkout gh-pages
	cp /tmp/${FILE}.pdf .. 
	git add ../${FILE}.pdf
	git commit -m "adding new version of ${FILE}.pdf" ../${FILE}.pdf
	git push
	git checkout master
