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

Comm_Out1 <- function(Comm.Catch.Clean,
                      Comm.ProductFlow.Data,
                      ImplictPriceDeflator,
                      Comm.Impact.Sector,
                      Comm.Mult.Data,
                      st,
                      YearIn,
                      YearOut,
                      YearIn.Mult,
                      YearIn.Imports = NA,
                      Stakeholders0,
                      Imports.Comm,
                      Imports.States,
                      Imports.Species,
                      Catch.Type) {
  
  Out<-list()
  Out$Imports.Comm<-Imports.Comm
  Out$Imports.States<-Imports.States
  Out$Imports.Species<-Imports.Species
  Out$YearIn.Imports<-YearIn.Imports
  
  return(Out)
  
}
