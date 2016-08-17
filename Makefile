all: html pdf docx rtf

pdf: resume.pdf
resume.pdf: resume.md update_citation
	pandoc --standalone --template style_chmduquesne.tex \
	--from markdown --to context \
	-V papersize=A4 \
	-o resume.tex resume.md; \
	context resume.tex

html: index.html
index.html: style_chmduquesne.css resume.md update_citation
	pandoc --standalone -H style_chmduquesne.css \
        --from markdown --to html \
	--mathjax \
        -o index.html resume.md

docx: resume.docx
resume.docx: resume.md update_citation
	pandoc -s -S resume.md -o resume.docx

rtf: resume.rtf
resume.rtf: resume.md
	pandoc -s -S resume.md -o resume.rtf

resume.md: update_citation

update_citation:
	Rscript add_citation_history.R

clean:
	rm index.html
	rm resume.tex
	rm resume.tuc
	rm resume.log
	rm resume.pdf
	rm resume.docx
	rm resume.rtf
