#' Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param infile Path to the input file
#' @return A matrix of the infile
#' @export

IPDCalc <- function(YearIn, YearOut, ImplictPriceDeflator) {
  # ImplictPriceDeflator<-names("Year", "Annual value")
  if (YearOut > YearIn) {
    #If you go forward through time
    flation <-
      ImplictPriceDeflator[ImplictPriceDeflator[, 1] %in% YearOut, 2] /
      ImplictPriceDeflator[ImplictPriceDeflator[, 1] %in% YearIn, 2]
  } else {
    #If you go back in time
    flation <-
      ImplictPriceDeflator[ImplictPriceDeflator[, 1] %in% YearIn, 2] /
      ImplictPriceDeflator[ImplictPriceDeflator[, 1] %in% YearOut, 2]
  }
  
  return(flation)
}
