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

# Makes some rough assumptions so it should be able to determine whether St is Saint or Street:
street_cleaner('123 St. James St.')
[1] "123 SAINT JAMES STREET"

# As a part of a dplyr::mutate() is where it really shines:
library(dplyr)
streets <- c('123 Main St.', '123 Main Str', '123 Main Street', '123 St. James St.', '123 STREET JAMES STREET', '123 Easy Ave NW')
df <- data_frame(address = streets)
df %>% 
  mutate(clean_address = street_cleaner(address),
         clean_address_abbr = street_cleaner(address, abbr = TRUE)) 
#> # A tibble: 6 x 3
#>   address                 clean_address                 clean_address_abbr 
#>   <chr>                   <chr>                         <chr>              
#> 1 123 Main St.            123 MAIN STREET               123 MAIN ST        
#> 2 123 Main Str            123 MAIN STREET               123 MAIN ST        
#> 3 123 Main Street         123 MAIN STREET               123 MAIN ST        
#> 4 123 St. James St.       123 SAINT JAMES STREET        123 ST JAMES ST    
#> 5 123 STREET JAMES STREET 123 SAINT JAMES STREET        123 ST JAMES ST    
#> 6 123 Easy Ave NW         123 EASY AVENUE NORTHWEST     123 EASY AVE NW


# city_cleaner() is similar to street_cleaner(), but standarizes city attritubes rather than streets:
cities <- c('Fort Collins', 'Ft Myers', 'Saint Louis', 'St. Petersburg')
df <- data_frame(city = cities)
df %>% 
  mutate(clean_city = street_cleaner(city),
         clean_city_abbr = street_cleaner(city, abbr = TRUE)) 
#> # A tibble: 4 x 3
#>   city           clean_city    clean_city_abbr
#>   <chr>          <chr>         <chr>          
#> 1 Fort Collins   FORT COLLINS  FT COLLINS     
#> 2 Ft Myers       FORT MYERS    FT MYERS       
#> 3 Saint Louis    SAINT LOUIS   ST LOUIS       
#> 4 St. Petersburg ST PETERSBURG ST PETERSBURG  


```
