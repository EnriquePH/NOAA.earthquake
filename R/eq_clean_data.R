#' Clean Earthquake NOAA Data
#'
#' After downloading and reading in the dataset, the overall task for this
#' module is to write a function named \code{eq_clean_data()} that takes
#' raw NOAA data frame and returns a clean data frame.
#' The clean data frame should have the following:
#' * A date column created by uniting the year, month, day and converting
#' it to the \code{Date} class.
#' * \code{LATITUDE} and \code{LONGITUDE} columns converted to numeric class.
#' @md
#' @param df A data frame with the raw NOAA earthquake data.
#'
#' @return A cleaned data frame.
#' @references \url{http://www.noaa.gov/}
#' @importFrom magrittr "%>%"
#' @importFrom tidyr replace_na
#' @importFrom dplyr mutate
#' @export
#'
#' @examples
#' \dontrun{
#' eq_clean_data(df)
#' }
eq_clean_data <- function(df) {
  MONTH <- NULL
  YEAR <- NULL
  DAY <- NULL
  LATITUDE <- NULL
  LONGITUDE <- NULL
  FLAG_TSUNAMI <- NULL

  df %>%
    # Replace missing dates to first and January
    tidyr::replace_na(replace = list(MONTH = 1, DAY = 1)) %>%
    # Convert mm/dd/+yyyy to Date
    dplyr::mutate(DATE = as.Date(julian(MONTH, DAY, YEAR),
                                 origin = as.Date("1970-01-01"))) %>%
    # Convert lat and long.
    dplyr::mutate(LATITUDE = as.numeric(LATITUDE)) %>%
    dplyr::mutate(LONGITUDE = as.numeric(LONGITUDE)) %>%
    # FLAG_TSUNAMI as logical.
    dplyr::mutate(FLAG_TSUNAMI = ifelse(is.na(FLAG_TSUNAMI), FALSE, TRUE))
}
