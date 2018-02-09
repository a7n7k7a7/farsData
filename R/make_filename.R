#' Create filename for Fatality Analysis Reporting System data
#' 
#' This is a helper hunction to create a filename including a year of the dataset.
#'
#' @param year A year of the dataset
#'
#' @return Function returns a character string with filename including year of the dataset.
#' 
#' @examples
#' make_filename(2017)
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}