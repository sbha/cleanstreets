# raw data for the title abbreviation table
df_key_city <- read.table(text = 'title abbreviation type
FORT FT OTHER
MOUNT MT OTHER
POINT PT OTHER
SAINT ST OTHER
EAST E DIR
WEST W DIR
NORTH N DIR
SOUTH S DIR', 
                     header = TRUE, stringsAsFactors = FALSE)

# to update:
# devtools::use_data(df_key_city, overwrite = TRUE)


