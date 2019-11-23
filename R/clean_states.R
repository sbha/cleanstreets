

clean_states <- function(x, to = 'name'){
  df_states <- tibble(
    abbrs  = c(state.abb, 'DC', 'DC'),
    names = c(state.name, 'Washington DC', 'District of Columbia')
  )
  
  if (to == 'name') {
    to_replace <- c(unlist(df_states$abbrs))
    replace_with <- c(unlist(df_states$names))
  } else if (to == 'abbr'){
    to_replace <- c(unlist(df_states$names))
    replace_with <- c(unlist(df_states$abbrs))
  }
  
  to_replace <- paste0('\\b', to_replace, '\\b')
  names(replace_with) <- to_replace
  str_replace_all(x, replace_with)
}

# locs <- c('Texas', 'TX', 'OH', 'Ohio', 'MN', 'Minnesota')
# clean_states(locs)
# clean_states(locs, 'abbr')
