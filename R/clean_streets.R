#' @title street_cleaner
#'
#' @description Function to standardize common street address formats
#'
#' @param address
#'
#' @return NULL
#'
#' @examples stree_cleaner
#'
#' @export street_cleaner

street_cleaner <- function(x, abbr = FALSE, caps = TRUE){
  library(stringr)
  
  # df_key is the tile abbreviation crosswalk
  # it exists in the /data directory 
  load("data/df_key.Rda")
  
  # deterime if going from long format to abbreviation or the other way 
  if (abbr == FALSE) {
    to_replace <- c(unlist(df_key$abbreviation))
    replace_with <- c(unlist(df_key$title))
  } else if (abbr == TRUE){
    to_replace <- c(unlist(df_key$title))
    replace_with <- c(unlist(df_key$abbreviation))
  }
  
  # bind the replacement to avoid bad matches
  to_replace <- paste0('\\b', to_replace, '\\b')
  names(replace_with) <- to_replace
  
  # clean up raw address input
  address <- gsub('\\.|,', ' ', toupper(x))
  address <- gsub('\\s+', ' ', address)
  
  # replace target text
  address_out <- str_replace_all(address, replace_with)
  
  # determine if output should be all caps or just the first letter
  if (caps == FALSE) {
    address_out <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", tolower(address_out), perl=TRUE)
  }
  
  # return the reformatted address
  trimws(address_out)
}


