#' @title street_cleaner
#'
#' @description Function to standardize comman street address formats
#'
#' @param address
#'
#' @return NULL
#'
#' @examples stree_cleaner
#'
#' @export street_cleaner

street_cleaner <- function(x){
  library(stringr)
  df_key <- read.table(text = '
                       title abbreviation
                       ROAD RD
                       SUITE STE
                       AVENUE AVE
                       HIGHWAY HWY
                       BOULEVARD BLVD
                       STREET ST
                       PARKWAY PKWY
                       PLACE PL
                       DRIVE DR
                       LANE LN
                       EAST E
                       WEST W
                       NORTH N
                       SOUTH W
                       SOUTHWEST SW
                       SOUTHEAST SE
                       NORTHEAST NE
                       NORTHWEST NW', header = TRUE, stringsAsFactors = FALSE)

  replace_with <- c(unlist(df_key$title))
  to_replace <- c(unlist(df_key$abbreviation))
  to_replace <- paste0('\\b', to_replace, '\\b')
  names(replace_with) <- to_replace

  address <- gsub('\\.|,', ' ', toupper(x))
  address <- gsub('\\s+', ' ', address)

  str_out <- str_replace_all(address, replace_with)
  trimws(str_out)
}


