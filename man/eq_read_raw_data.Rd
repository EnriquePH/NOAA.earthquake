% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eq_read_raw_data.R
\name{eq_read_raw_data}
\alias{eq_read_raw_data}
\title{Read raw NOAA earthquake from package data directory}
\usage{
eq_read_raw_data(file_path)
}
\arguments{
\item{file_path}{A string with the complete path to data in package}
}
\value{
A data frame
}
\description{
Read raw NOAA earthquake from package data directory
}
\examples{
\dontrun{
data_path <- "extdata"
dest_file <- "noaa_earthquake.txt"
file_path <- system.file(data_path, dest_file, package = "NOAA.earthquake")
eq_df <- eq_read_raw_data(file_path)
}
}
\references{
\url{http://www.noaa.gov/}
}
\seealso{
\code{\link[readr]{read_delim}}
}
