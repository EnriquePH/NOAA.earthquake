#' Download Earthquake Data from NOAA
#'
#' @param destfile A character string with the name where the
#'  downloaded file is saved.
#' @param data_path A string with the data path
#'
#' @return None
#' @importFrom utils download.file
#' @references \url{https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1}
#' @references \url{http://www.noaa.gov/}
#' @seealso \code{\link[utils]{download.file}}
#' @export
#'
#' @examples
#' \dontrun{
#' data_path <- "inst/extdata"
#' dest_file <- "noaa_earthquake.txt"
#' eq_download_data(destfile = dest_file, data_path = data_path)
#' }
eq_download_data <- function(destfile, data_path) {
  noaa_url <- paste0(
    "https://www.ngdc.noaa.gov/nndc/struts/results?",
    "type_0=Exact&query_0=$ID&t=101650&s=13&d=189&dfn=",
    "signif.txt"
  )

  dir.create(data_path, showWarnings = FALSE)

  dest_path <- paste0(data_path, "/", destfile)
  if (! file.exists(dest_path)) {
    utils::download.file(url = noaa_url,
                         destfile = dest_path)
    cat(paste("Data has been downloaded: ", dest_path, "\n"))
  } else {
    warning(paste("File ", dest_path, " already exists"))
  }
}
