#' Get's Wikipedia Page Coordinates
#'
#' This function takes a wikipedia page name and returns it's location in latitude and longitide
#'
#'
#' @param page_name Wikipedia page name. Should be a character
#' @return A 2 dimensional list, where the first entry is latitude and the second is longitude
#' @export
geocode_wikipedia_page <- function(page_name)
{
  # get wikipedia page using wikipediR, a wrapper for MediaWiki API
  wp_content <- WikipediR::page_content("en","wikipedia", page_name = page_name)
  # get page text
  text = wp_content$parse$text[[1]]
  # extract coordinates using regex.
  # Note: this method has issues that may reveal themselves. For example, it could be that coordinates for multiple places are
  # stored like this on wikipedia pages, in which case, this would return, the first, and possible wrong result
  # use carefully
  coords_text = stringr::str_extract(text,"(?<=<span class=\\\"geo\\\">)(.*?)(?=<\\/span>)")
  coord_list = strsplit(coords_text,';')[[1]]
  coord_list = as.numeric(coord_list)
  return(coord_list)
}


