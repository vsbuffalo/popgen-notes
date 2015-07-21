%.xml : %.tex
	latexml --destination=$@ $<

%.xhtml : %.xml
	latexmlpost --css=plr-style.css --javascript=adjust-svg.js --stylesheet=xsl/LaTeXML-all-xhtml.xsl --destination=$@ $<
	-cp plr-style.css $(@D)
	-cp adjust-svg.js $(@D)

ibd/ibd-writeup.xhtml : ibd/ibd-writeup.tex
	-rm ibd/LaTeXML.cache
	latexml --destination=ibd/ibd-writeup.xml $<
	latexmlpost --split --splitpath="//ltx:bibliography |//ltx:appendix" --css=plr-style.css --stylesheet=xsl/LaTeXML-all-xhtml.xsl --javascript=adjust-svg.js --destination=$@ ibd/ibd-writeup.xml
	cp plr-style.css ibd
	cp adjust-svg.js ibd

%.svg : %.pdf
	inkscape $< --export-plain-svg=$@

%.png : %.pdf
	convert -density 300 $< -flatten $@

notes: popgen_notes.pdf

html-notes: popgen_notes.html

popgen_notes.pdf: popgen_notes.tex 
	pdflatex $^

popgen_notes.html: popgen_notes.tex
	pandoc -s --mathjax --to html5 $< > $@


.PHONY: notes html-notes
