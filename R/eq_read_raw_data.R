#' Read raw NOAA earthquake from package data directory
#'
#' @param file_path A string with the complete path to data in package
#'
#' @return A data frame
#' @export
#'
#' @importFrom readr read_delim
#' @importFrom readr col_integer
#' @importFrom readr col_double
#' @importFrom readr col_character
#' @seealso \code{\link[readr]{read_delim}}
#' @references \url{http://www.noaa.gov/}
#' @examples
#' \dontrun{
#' data_path <- "extdata"
#' dest_file <- "noaa_earthquake.txt"
#' file_path <- system.file(data_path, dest_file, package = "NOAA.earthquake")
#' eq_df <- eq_read_raw_data(file_path)
#' }
eq_read_raw_data <- function(file_path) {
  readr::read_delim(file_path,
                    delim = "\t",
                    escape_double = FALSE,
                    trim_ws = TRUE,
                    col_types = list(
                      .default = readr::col_integer(),
                      FLAG_TSUNAMI = readr::col_character(),
                      YEAR = readr::col_integer(),
                      MONTH = readr::col_integer(),
                      DAY = readr::col_integer(),
                      SECOND = readr::col_double(),
                      EQ_PRIMARY = readr::col_double(),
                      EQ_MAG_MW = readr::col_double(),
                      EQ_MAG_MS = readr::col_double(),
                      EQ_MAG_MB = readr::col_character(),
                      EQ_MAG_ML = readr::col_double(),
                      EQ_MAG_MFA = readr::col_character(),
                      EQ_MAG_UNK = readr::col_double(),
                      COUNTRY = readr::col_character(),
                      STATE = readr::col_character(),
                      LOCATION_NAME = readr::col_character(),
                      LATITUDE = readr::col_double(),
                      LONGITUDE = readr::col_double(),
                      MISSING = readr::col_character(),
                      DAMAGE_MILLIONS_DOLLARS = readr::col_double(),
                      TOTAL_MISSING = readr::col_character(),
                      TOTAL_MISSING_DESCRIPTION = readr::col_character(),
                      TOTAL_DAMAGE_MILLIONS_DOLLARS = readr::col_character()
                    ))
}
