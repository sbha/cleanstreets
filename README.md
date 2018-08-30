# cleanstreets
## Overview
Standardize address attributes

## Installation
``` r
# install.packages("devtools")
devtools::install_github("sbha/cleanstreets")
```

## Usage
```r
# The default if to go from abbreviations to long names:
library(cleanstreets)
street_cleaner('123 Main St.')
#> "123 MAIN STREET"

# Setting the argument abbr = TRUE converts longer names to abbreviations:
street_cleaner('123 Main Street', abbr = TRUE)
#> "123 MAIN ST"

```
