state_to_st <- function(x){
  c(state.abb, 'DC')[match(x, c(state.name, 'District of Columbia'))]
}


st_to_state <- function(x){
  c(state.name, 'District of Columbia')[match(x, c(state.abb, 'DC'))]
}
