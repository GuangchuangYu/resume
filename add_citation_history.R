#!/usr/local/bin/Rscript

library("scholar")
library("rCharts")
library("methods")


id <- "DO5oG40AAAAJ"
cites <- get_citation_history(id)

g <- mPlot(cites ~ year, data = cites, type = "Bar")

ff <- tempfile(fileext=".html")
sink(ff)
g$print(include_assets = T)
sink()

x <- readLines(ff)
i = grep("</style>$", x)
x <- x[-(1:i)]

part1 <- readLines("resume_part1.md")
part2 <- readLines("resume_part2.md")


resume <- c(part1, "", x, "", part2)

out <- file("resume.md", "w")
writeLines(resume, out)
close(out)






