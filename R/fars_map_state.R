#' Create map of Fatality Analysis Reporting System data
#' 
#' The function plots the data from a selected year and state on a map.
#'
#' @param state.num Number of state
#' @param year A year of the data to plot
#'
#' @return The function returns a plot with map of a state and the accidents place from the selected year.
#' 
#' @importFrom maps map
#' @importFrom graphics points
#' @importFrom dplyr filter
#' 
#' @note The files should be named 'accident_year.csv.bz2' otherwise the function will return an error.
#' 
#' @examples
#' \dontrun{
#' fars_map_state(1, 2013)
#' }
#' 
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)
  
  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}