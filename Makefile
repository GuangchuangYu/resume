all: html pdf docx rtf

pdf: resume.pdf
resume.pdf: resume3.md
	pandoc --standalone --template style_chmduquesne.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o resume.tex resume3.md; \
	context resume.tex

html: index.html
index.html: style_chmduquesne.css resume2.md resume.md
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

resume3.md: resumePDF

resumePDF: 
	Rscript citation.R

resume2.md: resume

resume:
	Rscript -e 'library(ypages); gendoc("resume.md", outfile="resume2.md")'


clean:
	rm index.html
	rm resume.tex
	rm resume.tuc
	rm resume.log
	rm resume.pdf
	rm resume.docx
	rm resume.rtf

