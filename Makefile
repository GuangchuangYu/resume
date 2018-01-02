update_html: html pdf2
	git add .; git commit -m 'update'; git push -u origin gh-pages

all: html pdf docx rtf

pdf: YGC.pdf
YGC.pdf: style_chmduquesne.tex render4pdf YGC.rmd YGC.md
	pandoc --standalone --template style_chmduquesne.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o YGC.tex YGC.md; \
	context YGC.tex

pdf2:
	Rscript -e 'rmarkdown::render("ygc_pdf_resume.Rmd")';\
	mv ygc_pdf_resume.pdf YGC.pdf

html: index.html
index.html: style_chmduquesne.css render4html YGC.rmd YGC.md
	pandoc --standalone -H style_chmduquesne.css \
        --from markdown --to html \
	--mathjax \
        -o index.html YGC.md

docx: YGC.docx
YGC.docx: YGC.rmd YGC.md render4pdf
	pandoc -s -S YGC.md -o YGC.docx

rtf: YGC.rtf
resume.rtf: YGC.md YGC.rmd render4pdf
	pandoc -s -S YGC.md -o YGC.rtf

render4pdf:
	Rscript -e 'source("render4pdf.R")'

render4html:
	Rscript -e 'source("render4html.R")'

clean:
	rm index.html
	rm YGC.tex
	rm YGC.tuc
	rm YGC.log
	rm YGC.pdf
	rm YGC.docx
	rm YGC.rtf
	rm YGC.md

