# raw data for the title abbreviation table
df_key <- read.table(text = 'title abbreviation
AVENUE AVE
BOULEVARD BLVD       
DRIVE DR
FORT FT
HIGHWAY HWY
JUNCTION JCT
JUNCTION JNCT
LAKE LK                     
LANE LN
PARKWAY PKWY
PLACE PL
POINT PT
ROAD RD
SUITE STE
TERRACE TER
TERRACE TERR
TURNPIKE TRNPK
VIEW VW
WAY WY
EAST E
WEST W
NORTH N
SOUTH S
SOUTHWEST SW
SOUTHEAST SE
NORTHEAST NE
NORTHWEST NW', header = TRUE, stringsAsFactors = FALSE)

# to update:
#devtools::use_data(df_key, overwrite = TRUE)

# STREET STR
# \\1SAINT ([0-9]+\\s+)ST 
# \\1STREET ([A-Z]+\\s+)ST

#STREET ST
#SAINT ([0-9]+\\s+)ST


