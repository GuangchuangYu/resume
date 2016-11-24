#!/usr/local/bin/Rscript

library(methods)
library(scholar)
library(ggplot2)
library(ggthemes)

id <- 'DO5oG40AAAAJ'
ygc <- get_profile(id)
df <- get_citation_history(id)

dd <- strsplit(date(), "\\s+")[[1]]
subtitle <- paste("data from Google Scholar,", dd[2], dd[5])
title <- paste0("Citation = ", ygc$total_cites, ", H-index = ", ygc$h_index, ", I10-index = ", ygc$i10_index)
p <- ggplot(df, aes(year, cites)) + geom_line() + theme_minimal() + geom_label(aes(label=cites), size=3) + xlab(NULL) + ylab(NULL) +
	ylim(NA, round(max(df$cites) * 1.1)) + ggtitle(title, subtitle=subtitle) +
	scale_x_continuous(breaks = df$year) + theme(plot.title=element_text(size=10)) + labs(caption="Guangchuang Yu")

ggsave(p, file="citation_trend.pdf", width=6.6, height=3)

x <- readLines("resume.md")
idx <- grep("^\\s*<!\\-\\-.+:=.+\\-\\->$", x)

x[idx[1]] <- "![](citation_trend.pdf)"
x <- x[-idx[-1]]

x <- x[-grep("projecteuler|codeabbey", x)]

out <- file("resume3.md")
writeLines(x, out)
close(out)
