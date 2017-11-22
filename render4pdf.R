#!/bin/env Rscript

x <- readLines("YGC.rmd")

## remove language logo
x[grep("Rlogo.png", x)] <- "**R**"
x[grep("logo_bioconductor", x)] <- "**Bioconductor**"
x[grep("java.png", x)] <- "**Java**"

## remove figures (project euler, codeademy
x <- x[!grepl("^\\[!", x)]
x <- x[!grepl("^!", x)]

## add citation and dlstats
# x[grep("dlstats_trend", x)] <- "![](dlstats.pdf)"
x[grep("citation_trend", x)] <- "![](citation_trend.pdf)"


## remove r code to generate badge
x <- x[!grepl("^`r", x)]

out <- file("YGC2.rmd", "w")
writeLines(x, out)
close(out)

source("dlstat.R")
source("citation.R")

require(rmarkdown)
require(ypages)
require(badger)

render("YGC2.rmd", md_document("markdown"), "YGC.md")
unlink("YGC2.rmd")

