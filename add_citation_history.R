#!/usr/local/bin/Rscript

source("generate_citation.R")

part1 <- readLines("resume_part1.md")
part2 <- readLines("resume_part2.md")

citation <- readLines("citation_info.md")

resume <- c(part1, "", citation, "", part2)

out <- file("resume.md", "w")
writeLines(resume, out)
close(out)






