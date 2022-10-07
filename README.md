# wikipediageocoder

Simple R package to use wikipedia for geocoding.

Example:
```
library(wikipediageocoder)
# location string that google geocoding returns NA
search_string = 'mare island navy yard'
page_name = search_for_wikipedia_page(search_string)
print(page_name)
#> [1] "Mare Island Naval Shipyard"
coordinates = geocode_wikipedia_page(page_name)
print(coordinates)
#> [1]   38.0900 -122.2633
```
