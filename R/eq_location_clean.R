#' Clean Earthquake NOAA Location Data
#'
#' This function cleans LOCATION_NAME column by stripping out
#'  the country name (including the colon) and converts names to title case
#' @param df A data frame with the raw NOAA earthquake data.
#'
#' @return A LOCATION_NAME cleaned data frame.
#' @importFrom magrittr "%>%"
#' @importFrom dplyr mutate
#' @importFrom stringr str_to_title
#' @export
#'
#' @examples
#' \dontrun{
#' eq_location_clean(df)
#' }
eq_location_clean <- function(df) {
  LOCATION_NAME <- NULL
  COUNTRY <- NULL
  . <- NULL

  df %>%
    dplyr::mutate(LOCATION_NAME = mapply(function(x, y) {
      gsub(paste0(x,":") , "", y)},
      COUNTRY,
      LOCATION_NAME) %>%
        gsub("BRITIAN", "BRITAIN", .) %>%
        gsub("^(:|;|-|,)\\s", "", .) %>%
        gsub("^(-|:)", "", .) %>%
        trimws %>%
        gsub("(,|:|\\.)$", "", .) %>%
        gsub("-:", "", .) %>%
        gsub("\\[", "(", .) %>%
        gsub("\\]", ")", .) %>%
        gsub(": :", ":", .) %>%
        stringr::str_to_title(.)
    )
}
