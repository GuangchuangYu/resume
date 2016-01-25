library(scholar)
library(ggplot2)
library(ggthemes)

id <- 'DO5oG40AAAAJ'
ygc <- get_profile(id)
df <- get_citation_history(id)

title <- paste0("Citation = ", ygc$total_cites, ", H-index = ", ygc$h_index, ", I10-index = ", ygc$i10_index)
p <- ggplot(df, aes(year, cites)) + geom_line() + theme_fivethirtyeight() + geom_point(size=3) + ggtitle(title)

ggsave(p, file="citation.pdf", width=6, height=3)
ggsave(p, file="citation.png", width=6, height=3)
