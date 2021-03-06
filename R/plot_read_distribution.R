#' @title Distribution of reads
#' @description Plots distribution of reads.
#' @param x \code{\link{phyloseq-class}} object
#' @param groups Metadata variable to check for groups based sequencing effort.
#' @param plot.type either density or histogram plot
#
#' @author Contact: Sudarshan Shetty \email{sudarshanshetty9@@gmail.com}
#' @return A \code{\link{ggplot}} plot object.
#' @importFrom data.table data.table
#' @export
#' @examples \dontrun{
#'   # Example data
#'     library(microbiome)
#'     data(biogeogut)
#'     ps0 <- biogeogut
#'     p <- plot_read_distribution(ps0, groups='SampleType', plot.type= 'density')
#'           }
#' @keywords utilities

plot_read_distribution <- function(x, groups, plot.type = c("density",
                                                            "histogram"))
{
  df <- pdfa <- pdfb <- Reads_per_sample <- NULL
  title <- "Distribution of reads in the dataset"
  df <- data.table(as(sample_data(x), "data.frame"), Reads_per_sample = sample_sums(x),
                   keep.rownames = TRUE)
  if (plot.type == "density")
  {
    p.dfa <- ggplot(df, aes(x = Reads_per_sample, fill = factor(groups))) +
      geom_density(alpha = 0.5, fill = "steelblue") + facet_wrap(groups) +
      theme_bw() + theme(axis.text.x = element_text(angle = 90,
                                                         hjust = 1))

  } else if (plot.type == "histogram")
  {
    p.dfa <- ggplot(df, aes(x = Reads_per_sample, fill = factor(groups))) +
      geom_histogram(alpha = 0.5) + facet_wrap(groups) + theme_bw() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))

  }
  print("Done plotting")
  return(p.dfa)
}