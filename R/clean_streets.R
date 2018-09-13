#' @title street_cleaner
#'
#' @description Function to standardize common street address formats
#'
#' @param street address
#'
#' @return clean address
#'
#' @examples street_cleaner
#'
#' @export street_cleaner

street_cleaner <- function(x, abbr = FALSE, caps = TRUE){
  #library(stringr)
  
  # df_key_street is the title abbreviation crosswalk
  # it exists in the /data directory 
  # load("data/df_key_street.Rda")
  
  # determine if going from long format to abbreviation or the other way 
  if (abbr == FALSE) {
    to_replace <- c(unlist(df_key_street$abbreviation))
    replace_with <- c(unlist(df_key_street$title))
    } else if (abbr == TRUE){
    to_replace <- c(unlist(df_key_street$title))
    replace_with <- c(unlist(df_key_street$abbreviation))
    }

  
  # bind the string to replace to avoid bad matches
  to_replace <- paste0('\\b', to_replace, '\\b')
  names(replace_with) <- to_replace
  
  # clean up raw address input
  address <- gsub('\\.|,', ' ', toupper(x))
  address <- gsub('\\s+', ' ', address)

   # replace target text
  address_out <- stringr::str_replace_all(address, replace_with)
  
  # Street and Saint check - 
  
  if(abbr == FALSE) address_out <- stringr::str_replace_all(address_out, '([A-Z]\\s+)ST\\b', '\\1STREET')
  if(abbr == FALSE) address_out <- stringr::str_replace_all(address_out, '\\bSTR\\b', 'STREET')
  if(abbr == FALSE) address_out <- stringr::str_replace_all(address_out, '(([0-9]|NORTH|NORTHEAST|NORTHWEST|EAST|WEST|SOUTH|SOUTHEAST|SOUTHWEST)\\s+)ST\\b', '\\1SAINT')
  if(abbr == TRUE) address_out <- stringr::str_replace_all(address_out, '\\b(STREET|SAINT|STR)\\b', 'ST')
  
  # if a street type occurs twice, replace first instance with SAINT
  # address_out <- ifelse(str_count(address_out, '\\bSTREET\\b') >= 2,
  #                       str_replace(address_out, '\\bSTREET\\b', 'SAINT'),
  #                       address_out)
  # searchable street types
  st_strs <- paste0('\\b(', paste(c(unique(df_key_street$title[df_key_street$type == 'ST']), 'STREET'), collapse = '|'), ')\\b')
  
  address_out <- ifelse(stringr::str_count(address_out, st_strs) >= 2,
                        stringr::str_replace(address_out, st_strs, 'SAINT'),
                        address_out)
  
  # determine if output should be all caps or just the first letter
  if (caps == FALSE) {
    address_out <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", tolower(address_out), perl=TRUE)
  }
  
  # return the reformatted address
  trimws(address_out)
}


