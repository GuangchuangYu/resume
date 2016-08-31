#!/usr/local/bin/Rscript

library(methods)
library(scholar)
library(ggplot2)
library(ggthemes)

id <- 'DO5oG40AAAAJ'
ygc <- get_profile(id)
df <- get_citation_history(id)

dd <- strsplit(date(), " ")[[1]]
subtitle <- paste("data from Google Scholar,", dd[2], dd[5])
title <- paste0("Citation = ", ygc$total_cites, ", H-index = ", ygc$h_index, ", I10-index = ", ygc$i10_index)
p <- ggplot(df, aes(year, cites)) + geom_line() + theme_fivethirtyeight(base_size=10) + geom_label(aes(label=cites), size=3) +
    ggtitle(title, subtitle=subtitle) + scale_x_continuous(breaks = df$year) + theme(plot.title=element_text(size=10))

ggsave(p, file="citation_trend.pdf", width=6.6, height=3)

x <- readLines("resume.md")
idx <- grep("^\\s*<!\\-\\-.+:=.+\\-\\->$", x)

x[idx[1]] <- "![](citation_trend.pdf)"
x <- x[-idx[-1]]

out <- file("resume3.md")
writeLines(x, out)
close(out)

