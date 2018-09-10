# city_cleaner

city_cleaner <- function(x, abbr = FALSE, caps = TRUE){
  
  df_key_city <- read.table(text = 'title abbreviation
                              FORT FT
                              POINT PT
                              SAINT ST',
                              header = TRUE, stringsAsFactors = FALSE)
  
  if (abbr == FALSE) {
    to_replace <- c(unlist(df_key_city$abbreviation))
    replace_with <- c(unlist(df_key_city$title))
  } else if (abbr == TRUE){
    to_replace <- c(unlist(df_key_city$title))
    replace_with <- c(unlist(df_key_city$abbreviation))
  }
  
  # bind the string to replace to avoid bad matches
  to_replace <- paste0('\\b', to_replace, '\\b')
  names(replace_with) <- to_replace
  
  # clean up raw address input
  city <- gsub('\\.|,', ' ', toupper(x))
  city <- gsub('\\s+', ' ', city)
  
  # replace target text
  city_out <- str_replace_all(city, replace_with)
  
  # determine if output should be all caps or just the first letter
  if (caps == FALSE) {
    city_out <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", tolower(city_out), perl=TRUE)
  }
  
  # return the reformatted address
  trimws(city_out)
}

# test_city <- 'Ft Thomas'
# city_cleaner(test_city, abbr = TRUE)
# city_cleaner(test_city)
# city_cleaner(test_city, caps = FALSE)
# city_cleaner(test_city, abbr = TRUE, caps = FALSE)


