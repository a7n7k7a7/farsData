#' Summarise Fatality Analysis Reporting System data
#' 
#' This function calculates the number of accidents per month in selected years.
#'
#' @inheritParams fars_read_years
#'
#' @return The function returns a tibble with number of cases.
#' 
#' @importFrom dplyr bind_rows group_by summarize 
#' @importFrom tidyr spread
#' @import magrittr
#' 
#' @note The files should be named 'accident_year.csv.bz2' otherwise the function will return an error.
#' 
#' @examples
#' fars_summarize_years(c(2013, 2014, 2015))
#' 
#' @export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>% 
    dplyr::group_by(year, MONTH) %>% 
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}