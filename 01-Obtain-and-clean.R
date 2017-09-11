library(readr)
library(dplyr)
library(lubridate)
library(magrittr)
library(NOAA.earthquake)


eq_read_raw_data <- function(destfile, data_path) {
  raw_file <- paste0(data_path, "/", dest_file)
  readr::read_delim(raw_file,
           delim = "\t",
           escape_double = FALSE,
           trim_ws = TRUE,
           col_types = list(
             .default = col_integer(),
             FLAG_TSUNAMI = col_character(),
             YEAR = col_integer(),
             MONTH = col_integer(),
             DAY = col_integer(),
             SECOND = col_character(),
             EQ_PRIMARY = col_double(),
             EQ_MAG_MW = col_double(),
             EQ_MAG_MS = col_double(),
             EQ_MAG_MB = col_character(),
             EQ_MAG_ML = col_double(),
             EQ_MAG_MFA = col_character(),
             EQ_MAG_UNK = col_double(),
             COUNTRY = col_character(),
             STATE = col_character(),
             LOCATION_NAME = col_character(),
             LATITUDE = col_double(),
             LONGITUDE = col_double(),
             MISSING = col_character(),
             DAMAGE_MILLIONS_DOLLARS = col_double(),
             TOTAL_MISSING = col_character(),
             TOTAL_MISSING_DESCRIPTION = col_character(),
             TOTAL_DAMAGE_MILLIONS_DOLLARS = col_character()
           ))
  }


#' Title
#'
#' @param df
#'
#' @return
#' @export
#'
#' @examples
eq_clean_data <- function(df) {
  df %>%
    #tidyr::replace_na(replace = list(MONTH = 1, DAY = 1)) %>%
    dplyr::mutate(DATE =
                    lubridate::ymd(paste(YEAR, MONTH, DAY, sep = "/"),
                                   truncated = 2)) %>%
    dplyr::mutate(FLAG_TSUNAMI = ifelse(is.na(FLAG_TSUNAMI), FALSE, TRUE))
}


#-------------------------------------------------------------------------------

data_path <- "inst/extdata"
dest_file <- "noaa_earthquake.txt"

eq_download_data(destfile = dest_file,
                 data_path = data_path)

eq_df <- eq_read_raw_data(destfile = dest_file,
                  data_path = data_path)



eq_df <- eq_clean_data(eq_df)


View(eq_df)

#eq_location_clean


eq_df$LOCATION_NAME <- mapply(function(x, y) gsub(x, "", y),
                              eq_df$COUNTRY,
                              eq_df$LOCATION_NAME) %>%
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


View(eq_df)



x <- c("0057-1-1", "09-01-02", "09-01-03", )
ymd(x)


dates <- c("02/27/0092", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
as.Date(dates, "%m/%d/%y")

ymd(c("2010"), truncated = 2)


sprintf("%04d", 57)

lubridate::ymd(paste("2011", NA, NA, sep = "/"), truncated = 2)
