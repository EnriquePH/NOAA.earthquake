rm(list=ls())

library(NOAA.earthquake)
#library(readr)
library(magrittr)

data_path <- "extdata"
dest_file <- "noaa_earthquake.txt"

file_path <- system.file(data_path, dest_file, package = "NOAA.earthquake")
file_path

eq_df <- eq_read_raw_data(file_path)

eq_df <- eq_clean_data(eq_df)

eq_df <- eq_location_clean(eq_df)

View(eq_df)

summary(eq_df)

unique(eq_df$COUNTRY)

#eq_location_clean

# https://github.com/cran/chron/blob/master/R/utils.R

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



x <- c("0057-1-1", "09-01-02", "09-01-03")
ymd(x)


dates <- c("02/27/0092", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
as.Date(dates, "%m/%d/%y")

ymd(c("2010"), truncated = 2)


sprintf("%04d", 57)

lubridate::ymd(paste("2011", NA, NA, sep = "/"), truncated = 2)
