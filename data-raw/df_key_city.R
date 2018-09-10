# raw data for the title abbreviation table
df_key_city <- read.table(text = 'title abbreviation
                     FORT FT
                     POINT PT
                     SAINT ST', 
                     header = TRUE, stringsAsFactors = FALSE)

# to update:
# devtools::use_data(df_key_city, overwrite = TRUE)
