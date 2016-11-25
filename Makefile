update_html: html
	git add .; git commit -m 'update'; git push -u origin gh-pages

all: html pdf docx rtf

pdf: YGC.pdf
YGC.pdf: resumePDF resume3.md
	pandoc --standalone --template style_chmduquesne.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o resume.tex resume3.md; \
	context resume.tex;\
	mv resume.pdf YGC.pdf

html: index.html resume2.md
index.html: style_chmduquesne.css resume resume.md resume2.md
	pandoc --standalone -H style_chmduquesne.css \
        --from markdown --to html \
	--mathjax \
        -o index.html resume2.md

docx: resume.docx
resume.docx: resume2.md resume.md
	pandoc -s -S resume2.md -o resume.docx

rtf: resume.rtf
resume.rtf: resume2.md resume.md
	pandoc -s -S resume2.md -o resume.rtf

resumePDF:
	Rscript citation.R;\
	Rscript dlstat.R

resume2.md: resume

resume:
	Rscript -e 'library(ypages); gendoc("resume.md", outfile="resume2.md")'


clean:
	rm index.html
	rm resume.tex
	rm resume.tuc
	rm resume.log
	rm YGC.pdf
	rm resume.docx
	rm resume.rtf

