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

  # address <- if_else(abbr == FALSE, sub('([0-9]\\s+)ST\\b', '\\1SAINT', address), address)
  # address <- ifelse(abbr == FALSE, sub('([A-Z]\\s+)ST\\b', '\\1STREET', address), address)
  # address <- ifelse(abbr == FALSE, sub('\\bSTR\\b', 'STREET', address), address)
  # address <- ifelse(abbr == TRUE, sub('\\b(STREET|SAINT|STR)\\b', 'ST', address), address)
  
  # replace target text
  address_out <- str_replace_all(address, replace_with)
  
  # Street and Saint check - 
  
  # address_out <- ifelse(abbr == FALSE, str_replace_all(address_out, '([0-9]\\s+)ST\\b', '\\1SAINT'), address_out)
  # address_out <- ifelse(abbr == FALSE, str_replace(address_out, '([A-Z]\\s+)ST\\b', '\\1STREET'), address_out)
  # address_out <- ifelse(abbr == FALSE, str_replace(address_out, '\\bSTR\\b', 'STREET'), address_out)
  # address_out <- ifelse(abbr == TRUE, str_replace(address_out, '\\b(STREET|SAINT|STR)\\b', 'ST'), address_out)
  
  if(abbr == FALSE) address_out <- str_replace(address_out, '([0-9]\\s+)ST\\b', '\\1SAINT')
  if(abbr == FALSE) address_out <- str_replace(address_out, '([A-Z]\\s+)ST\\b', '\\1STREET')
  if(abbr == FALSE) address_out <- str_replace(address_out, '\\bSTR\\b', 'STREET')
  if(abbr == TRUE) address_out <- str_replace_all(address_out, '\\b(STREET|SAINT|STR)\\b', 'ST')
  # address_out <- ifelse(abbr == FALSE, str_replace(address_out, '([A-Z]\\s+)ST\\b', '\\1STREET'), address_out)
  # address_out <- ifelse(abbr == FALSE, str_replace(address_out, '\\bSTR\\b', 'STREET'), address_out)
  #address_out <- ifelse(abbr == TRUE, str_replace(address_out, '\\b(STREET|SAINT|STR)\\b', 'ST'), address_out)

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


