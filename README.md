# cleanstreets
## Overview
Standardizes most common street address attributes so that formats are consistent. 

## Installation
``` r
# install.packages("devtools")
devtools::install_github("sbha/cleanstreets")
```

## Usage
```r
# The default is to go from abbreviations to long names:
library(cleanstreets)
street_cleaner('123 Main St.')
#> "123 MAIN STREET"

# Setting the argument abbr = TRUE converts longer names to abbreviations:
street_cleaner('123 Main Street', abbr = TRUE)
#> "123 MAIN ST"

# Return formatted address with only the first letter of each word capitalized, rather than all caps
street_cleaner('123 Main St.', caps = FALSE)
#> "123 Main Street"

# As a part of a dplyr::mutate():
library(dplyr)
df %>% 
  mutate(clean_address = street_cleaner(address, abbr = TRUE)) 



```
