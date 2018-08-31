# raw data for the title abbreviation table
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

# to update:
#devtools::use_data(df_key, overwrite = TRUE)

