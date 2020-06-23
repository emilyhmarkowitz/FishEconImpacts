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

Comm_Imports_Edit <- function(Imports.Species,
                              Imports.States,
                              st0,
                              YearIn.Imports,
                              YearIn.Mult,
                              YearOut,
                              ImplictPriceDeflator) {
  
  
  Imports.States$Imports <- Imports.States$Imports * funct_IPDCalc(YearIn = YearIn.Imports,
                                                                   YearOut = YearIn.Mult,
                                                                   ImplictPriceDeflator = ImplictPriceDeflator)
  
  Imports.States$Proc.Imp <- Imports.States$Imports * Imports.States$Proc.Prop
  Imports.States$Whole.Imp <- Imports.States$Imports * Imports.States$Whole.Prop
  Imports.States$Groc.Imp <- Imports.States$Imports * Imports.States$Groc.Prop
  Imports.States$Rest.Imp <- Imports.States$Imports * Imports.States$Rest.Prop
  Imports.States$Total.Imp <- sum(Imports.States$Proc.Imp,
                                  Imports.States$Whole.Imp,
                                  Imports.States$Groc.Imp,
                                  Imports.States$Rest.Imp,
                                  na.rm = T)
  
  Imports.Species$Imports.Proc <- Imports.Species$spp.Prop * Imports.States$Proc.Imp[Imports.States$State %in% st0]
  Imports.Species$Imports.Whole <- Imports.Species$spp.Prop * Imports.States$Whole.Imp[Imports.States$State %in% st0]
  Imports.Species$Imports.Groc <- Imports.Species$spp.Prop * Imports.States$Groc.Prop[Imports.States$State %in% st0]
  Imports.Species$Imports.Rest <- Imports.Species$spp.Prop * Imports.States$Rest.Imp[Imports.States$State %in% st0]
  Imports.Species$Imports.Total <- Imports.Species$spp.Prop * Imports.States$Total.Imp[Imports.States$State %in% st0]
  
  Imports.Species1 <-
    rbind.data.frame( cbind.data.frame( Species = Imports.Species$Species,
                                        Jurisdiction = st0,
                                        Stakeholder = "Harvesters",
                                        ValueOfLandings = 0),
                      cbind.data.frame(
                        Species = Imports.Species$Species,
                        Jurisdiction = st0,
                        Stakeholder = "Processors",
                        ValueOfLandings = Imports.Species$Imports.Proc),
                      cbind.data.frame(
                        Species = Imports.Species$Species,
                        Jurisdiction = st0,
                        Stakeholder = "Wholesalers",
                        ValueOfLandings = Imports.Species$Imports.Whole),
                      cbind.data.frame(
                        Species = Imports.Species$Species,
                        Jurisdiction = st0,
                        Stakeholder = "Grocers",
                        ValueOfLandings = Imports.Species$Imports.Groc),
                      cbind.data.frame(
                        Species = Imports.Species$Species,
                        Jurisdiction = st0,
                        Stakeholder = "Restaurants",
                        ValueOfLandings = Imports.Species$Imports.Rest),
                      cbind.data.frame(
                        Species = Imports.Species$Species,
                        Jurisdiction = st0,
                        Stakeholder = "Total",
                        ValueOfLandings = Imports.Species$Imports.Tot))
  
  names(Imports.Species1)[2] <- "Jurisdiction"
  
  return(Imports.Species1)
}
