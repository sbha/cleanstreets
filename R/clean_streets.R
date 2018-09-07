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
  library(stringr)
  
  # df_key is the title abbreviation crosswalk
  # it exists in the /data directory 
  # load("data/df_key.Rda")
  
  # determine if going from long format to abbreviation or the other way 
  if (abbr == FALSE) {
    to_replace <- c(unlist(df_key$abbreviation))
    replace_with <- c(unlist(df_key$title))
    } else if (abbr == TRUE){
    to_replace <- c(unlist(df_key$title))
    replace_with <- c(unlist(df_key$abbreviation))
    }

  
  # bind the string to replace to avoid bad matches
  to_replace <- paste0('\\b', to_replace, '\\b')
  names(replace_with) <- to_replace
  
  # clean up raw address input
  address <- gsub('\\.|,', ' ', toupper(x))
  address <- gsub('\\s+', ' ', address)
  
  # replace target text
  address_out <- str_replace_all(address, replace_with)
  
  # Street and Saint check - 
  address_out <- ifelse(abbr == FALSE, gsub('([0-9]\\s+)ST\\b', '\\1SAINT', address_out), address_out)
  address_out <- ifelse(abbr == FALSE, gsub('([A-Z]\\s+)ST\\b', '\\1STREET', address_out), address_out)
  address_out <- ifelse(abbr == FALSE, gsub('\\bSTR\\b', 'STREET', address_out), address_out)
  address_out <- ifelse(abbr == TRUE, gsub('\\b(STREET|SAINT|STR)\\b', 'ST', address_out), address_out)
  # if STREET occurs twice, replace first instance with SAINT
  address_out <- ifelse(str_count(address_out, '\\bSTREET\\b') >= 2,
                        str_replace(address_out, '\\bSTREET\\b', 'SAINT'),
                        address_out)

  # determine if output should be all caps or just the first letter
  if (caps == FALSE) {
    address_out <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", tolower(address_out), perl=TRUE)
  }
  
  # return the reformatted address
  trimws(address_out)
}


