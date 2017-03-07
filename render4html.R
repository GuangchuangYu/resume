#!/bin/env Rscript

require(rmarkdown)
require(ypages)

render("YGC.rmd", md_document("markdown"))

