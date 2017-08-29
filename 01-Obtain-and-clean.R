library(readr)
library(dplyr)
library(lubridate)
library(magrittr)

eq_download_data <- function(destfile, data_path) {
  # https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1
  noaa_url <- paste0(
    "https://www.ngdc.noaa.gov/nndc/struts/results?" ,
    "type_0=Exact&query_0=$ID&t=101650&s=13&d=189&dfn=",
    "signif.txt"
  )
  
  dir.create(data_path, showWarnings = FALSE)
  
  dest_path <- paste0(data_path, "/", destfile)
  if(!file.exists(dest_path)) {
    utils::download.file(url = noaa_url,
                destfile = dest_path)
    cat(paste("Data has been downloaded: ", dest_path, "\n"))
  } else {
    warning(paste("File ", dest_path, " already exists"))
  }
}


eq_read_raw_data <- function(destfile, data_path) {
  raw_file <- paste0(data_path, "/", dest_file)
  readr::read_delim(raw_file,
           delim = "\t",
           escape_double = FALSE,
           trim_ws = TRUE,
           col_types = list(
             .default = col_integer(),
             FLAG_TSUNAMI = col_character(),
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

eq_clean_data <- function(df) {
  df %>% 
    dplyr::mutate(DATE = ~lubridate::ymd(paste0(YEAR, MONTH, DAY)))
}


data_path <- "data"
dest_file <- "noaa_data.txt"

eq_download_data(destfile = dest_file,
                 data_path = data_path)

eq_df <- eq_read_raw_data(destfile = dest_file,
                  data_path = data_path)


eq_df <- eq_clean_data(eq_df)

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

gsub(": :", ":","Balkans Nw: : Stobi")
