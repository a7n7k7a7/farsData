#' Reading years and months from Fatality Analysis Reporting System data
#' 
#' The function reads years and months from multiple FARS files.
#'
#' @param years A vector of years to read the datasets for
#'
#' @return Function returns a list of tibbles for each selected year, containing month and year columns.
#'
#' @import magrittr
#' @importFrom dplyr mutate select
#' 
#' @note The files should be named 'accident_year.csv.bz2' otherwise the function will return an error.
#'
#' @examples
#' \dontrun{
#' my.data.lst <- fars_read_years(c(2013, 2014, 2015))
#' my.data.lst <- fars_read_years(2015)
#' }
#' 
#' @export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>% 
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}