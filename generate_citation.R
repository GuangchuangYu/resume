library("scholar")
library("rCharts")
library("methods")
library("rmarkdown")


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


info <- get_profile("DO5oG40AAAAJ")
d <- unlist(strsplit(date(), ' '))

out <- file("citation_info.md", "w")

writeLines(paste0("> Citation = ",  info$total_cites, ","), out)
writeLines(paste0("> H-index = ", info$h_index, ","), out)
writeLines(paste0("> I10-index = ", info$i10_index), out)
writeLines("", out)

writeLines(paste0("> (data from [Google Scholar](https://scholar.google.com/citations?user=DO5oG40AAAAJ&hl=en), ", d[2], " ", d[5]), out)

js <- readLines("js.md")
writeLines(c("", js, ""), out)

writeLines(x, out)
close(out)
