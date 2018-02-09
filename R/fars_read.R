#' Read Fatality Analysis Reporting System data
#' 
#' The function fars_read() enables reading FARS files into R.
#'
#' @param filename A character string containing filename
#'
#' @return This function returns a tibble with data from selected file.
#' 
#' @importFrom dplyr tbl_df
#' @importFrom readr read_csv
#' 
#' @note The function will return an error if a file doesn't exist.
#' 
#' @examples
#' my.data <- fars_read('accident_2015.csv.bz2')
#' 
#' @export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}