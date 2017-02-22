library(dlstats)
library(ggplot2)
library(cowplot)
library(magrittr)
library(ggthemes)

pkg <- c("GOSemSim", "DOSE", "clusterProfiler", "ReactomePA", "ChIPseeker", "ggtree", "meshes", "treeio")
nb <- bioc_stats(pkg)
nb <- nb[-grep(max(nb$start), nb$start),]
if (FALSE) {
plot_ly(nb, x=~end, y=~Nb_of_downloads, color=~package) %>%
    layout(xaxis=list(title="Year"), yaxis=list(title="Number of Downloads")) %>% add_trace(linetype=~package)
}

x=read.delim("https://bioconductor.org/packages/stats/bioc/bioc_pkg_scores.tab")
x[order(x[,2], decreasing=T),] -> x
n <- toupper(x[,1]) %>% unique %>% length

rank = rep(NA, length(pkg))
for (i in seq_along(pkg)) {
	j <- which(x[,1] == pkg[i])
	rank[i] = j # paste0("rank: ", j, '/', n)
}

cols <- RColorBrewer::brewer.pal(length(pkg), 'Dark2')

p <- ggplot(nb, aes(end, Nb_of_distinct_IPs, group=package, color=package)) +
    geom_line() + geom_point() + theme_minimal()

ii <- order(rank, decreasing=F)
p <- p + scale_color_manual(breaks=pkg[ii],
                       labels=paste0(pkg, ": ", rank)[ii],
                       name=paste("Download rank in", n, "Bioconductor packages"),
                       values=cols)

p <- p + xlab(NULL) + ylab(NULL) + theme(legend.position=c(.3, .6)) +
    labs(captions=paste0("Downloads by distinct IPs: ", scales::comma(sum(nb$Nb_of_distinct_IPs)), "/total, ",
                         "access date: ", format(Sys.time(), "%b %Y")),
         title="Monthly download stats")

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


x <- readLines("resume3.md")
idx <- grep("<!--dlstats-->", x)

x[idx] <- "![](dlstats.pdf)"

out <- file("resume3.md", "w")
writeLines(x, out)
close(out)
