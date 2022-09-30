

# finds wikipedia page
# may be multiple methods in the future, currently just google


#' Searches Google for Wikipedia Page
#'
#' This function takes a location string and finds it's related wikipedia page using google search and rvest.
#'
#' This function may have some issues.It relies on a specific formatting of google search results that may change in the future to work.
#' Use with some caution.
#' Also: may have to account for simple.wiki
#'
#'
#' @param search_string The string to be searched on google. Should be a character
#' @return A dataframe consisting of the search result and the associated page_name
search_google_for_wikipedia_page <- function(search_string)
{
  # search url
  search_url = paste0("https://www.google.com/search?q=site%3A+https%3A%2F%2Fwww.wikipedia.org%2F+",
  stringr::str_replace_all(search_string," ","+"))

  # scrape google search results
  page <- rvest::read_html(search_url)

  results <- rvest::html_elements(page, 'a')
  results_t <- rvest::html_text(results)
  page_mask <- stringr::str_detect(results_t,"›")
  results_text <- rvest::html_text(rvest::html_elements(page,"h3"))
  result_page_name <-  stringr::str_extract(rvest::html_text(rvest::html_elements(page, "h3")),".*(?= -)")


  results_df <- data.frame(text=results_text,page_name=result_page_name)
  return(results_df)
}

#' Searches for a Wikipedia Page using a variety of methods
#'
#' This function takes a location string and finds it's related wikipedia page using the selected method
#'
#'
#' @param search_string The string to be searched. Should be a character
#' @param method The method to be used to search
#' @param use_first_result Boolean variable. Default True. If True returns the first link, if false, returns a dataframe of all results
#' @return Either a page_name in character form or a dataframe
#' @export
search_for_wikipedia_page <- function(search_string, method = 'rvest-google', use_first_result = TRUE)
{
  if (method == 'rvest-google')
  {
    results_df <- search_google_for_wikipedia_page(search_string)
  }
  else
  {
    stop("method not found")
  }

  if (use_first_result)
  {
    return(results_df$page_name[1])
  }
  else
  {
    return(results_df)
  }
}
