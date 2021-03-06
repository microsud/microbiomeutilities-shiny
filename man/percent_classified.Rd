% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/percent_classified.R
\name{percent_classified}
\alias{percent_classified}
\title{Summarize the percent taxa classification for phyloseq}
\usage{
percent_classified(x)
}
\arguments{
\item{x}{\code{\link{phyloseq-class}} object}
}
\value{
table with information on percent OTUs classified.
}
\description{
Summarize the percent taxa classification for \code{\link{phyloseq-class}}.
}
\examples{
\dontrun{
  # Example data
    library(microbiomeutilities)
    data("biogeogut")
    pseq <- biogeogut
    percent_classified(pseq)
    
          }
}
\author{
Contact: Sudarshan A. Shetty \email{sudarshanshetty9@gmail.com}
}
\keyword{utilities}
