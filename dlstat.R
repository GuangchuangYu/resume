library(dlstats)
library(ggplot2)
## library(cowplot)
## library(magrittr)
## library(ggthemes)

if (FALSE) {
plot_ly(nb, x=~end, y=~Nb_of_downloads, color=~package) %>%
    layout(xaxis=list(title="Year"), yaxis=list(title="Number of Downloads")) %>% add_trace(linetype=~package)
}

p <- plot_bioc_stats()
ggsave(p, filename="dlstats.pdf", width=6.6, height=4)


## pp <- lapply(seq_along(pkg), function(i) {
## 	ggplot(subset(nb, package==pkg[i]), aes(end, Nb_of_downloads,color=I(cols[i]))) +
## 	geom_line() + geom_point() +
## 	ggtitle(pkg[i], subtitle=rank[i]) + theme_fivethirtyeight() +
## 	theme(legend.position='none') + xlab(NULL) + ylab(NULL)
## })

## title <- ggdraw() + draw_label("Monthly download stats", fontface='bold')
## p <- plot_grid(plotlist=pp, ncol=3)
## dlp <- plot_grid(title, p, ncol=1, rel_heights=c(.08, 1))
## save_plot("dlstats.pdf",
##           dlp,
##           base_height = 3.3,
##           base_width = 6.6)


## x <- readLines("resume3.md")
## idx <- grep("<!--dlstats-->", x)

## x[idx] <- "![](dlstats.pdf)"

## out <- file("resume3.md", "w")
## writeLines(x, out)
## close(out)
