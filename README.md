# cleanstreets
## Overview
R functions to standardize most common street address attributes with consistent formats. 
The package offers the following functions:

* `street_cleaner()` converts street address attributes to consistent abbreviated or long format names.
* `city_cleaner()` converts common city address names to consistent abbreviated or long format names.

## Installation
``` r
# install.packages("devtools")
devtools::install_github("sbha/cleanstreets")
```

## Usage
```r
# The default is to go from abbreviations to long names in uppercase:
library(cleanstreets)
street_cleaner('123 Main St.')
#> "123 MAIN STREET"

# Setting the argument abbr = TRUE converts long names to abbreviations:
street_cleaner('123 Main Street', abbr = TRUE)
#> "123 MAIN ST"

# Return formatted address with only the first letter of each word capitalized, rather than all caps:
street_cleaner('123 Main St.', caps = FALSE)
#> "123 Main Street"

# The function makes some rough assumptions to determine whether St is Saint or Street:
street_cleaner('123 St. James St.')
[1] "123 SAINT JAMES STREET"

# Over a column of addresses with inconsistent formats and as a part of a dplyr::mutate() is where street_cleaner() can really shine:
library(dplyr)
streets <- c('123 Main St.', '123 Main Str', '123 Main Street', '123 St. James St.', '123 ST JAMES STREET', '456 St. James Ave.', '123 Easy Ave NW', '123 First ST', '456 2nd Ave')
df <- data_frame(raw_address = streets)
df %>% 
   mutate(clean_address = street_cleaner(raw_address),
          clean_address_abbr = street_cleaner(raw_address, abbr = TRUE),
          clean_address_abbr_p = street_cleaner(raw_address, abbr = TRUE, period = TRUE))
#> # A tibble: 9 x 4
#>   raw_address         clean_address             clean_address_abbr clean_address_abbr_p
#>   <chr>               <chr>                     <chr>              <chr>               
#> 1 123 Main St.        123 MAIN STREET           123 MAIN ST        123 MAIN ST.        
#> 2 123 Main Str        123 MAIN STREET           123 MAIN ST        123 MAIN ST.        
#> 3 123 Main Street     123 MAIN STREET           123 MAIN ST        123 MAIN ST.        
#> 4 123 St. James St.   123 SAINT JAMES STREET    123 ST JAMES ST    123 ST. JAMES ST.   
#> 5 123 ST JAMES STREET 123 SAINT JAMES STREET    123 ST JAMES ST    123 ST. JAMES ST.   
#> 6 456 St. James Ave.  456 SAINT JAMES AVENUE    456 ST JAMES AVE   456 ST. JAMES AVE.  
#> 7 123 Easy Ave NW     123 EASY AVENUE NORTHWEST 123 EASY AVE NW    123 EASY AVE. NW.   
#> 8 123 First ST        123 FIRST STREET          123 1ST ST         123 1ST ST.         
#> 9 456 2nd Ave         456 SECOND AVENUE         456 2ND AVE        456 2ND AVE.         



# city_cleaner() is similar to street_cleaner(), but standarizes common city attributes rather than streets:
cities <- c('Fort Collins', 'Ft Myers', 'Saint Louis', 'St. Petersburg')
df <- data_frame(city = cities)
df %>%
  mutate(clean_city = city_cleaner(city),
         clean_city_abbr = city_cleaner(city, abbr = TRUE)) 
#> # A tibble: 4 x 3
#>   city           clean_city       clean_city_abbr
#>   <chr>          <chr>            <chr>          
#> 1 Fort Collins   FORT COLLINS     FT COLLINS     
#> 2 Ft Myers       FORT MYERS       FT MYERS       
#> 3 Saint Louis    SAINT LOUIS      ST LOUIS       
#> 4 St. Petersburg SAINT PETERSBURG ST PETERSBURG  


```
