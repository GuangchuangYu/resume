#!/bin/env Rscript

require(rmarkdown)
require(ypages)
require(badger)

render("YGC.rmd", md_document("markdown"))

