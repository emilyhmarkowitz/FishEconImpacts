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

spp_listdf2list<-function (Catch.Species.Data) {
  Catch.Species.Data1<-list(add = list(),
                            subtract = list())
  add<-names(Catch.Species.Data)[grepl(x = names(Catch.Species.Data), pattern = "_add")]
  subtract<-names(Catch.Species.Data)[grepl(x = names(Catch.Species.Data), pattern = "_subtract")]
  speciesgroups<-unique(c(gsub(x = subtract, pattern = "_subtract", replacement = ""),
                          gsub(x = add, pattern = "_add", replacement = "")))
  
  
  for (ii in 1:length(speciesgroups)) {
    #Add
    temp<-Catch.Species.Data[,names(Catch.Species.Data) %in%
                               add[grepl(pattern = speciesgroups[ii], x = add)]]
    if (sum(is.na(temp))!=length(temp)) {
      temp<-temp[!(is.na(temp))]
    } else {
      temp<-"NA"
    }
    Catch.Species.Data1$add$temp<- temp
    names(Catch.Species.Data1$add)[length(names(Catch.Species.Data1$add))]<-as.character(speciesgroups[ii])
    
    #Subtract
    temp<-Catch.Species.Data[,names(Catch.Species.Data) %in%
                               subtract[grepl(pattern = speciesgroups[ii], x = subtract)]]
    if (sum(is.na(temp))!=length(temp)) {
      temp<-trimws(temp[!(is.na(temp))])
    } else {
      temp<-"NA"
    }
    Catch.Species.Data1$subtract$temp<- temp
    names(Catch.Species.Data1$subtract)[length(names(Catch.Species.Data1$subtract))]<-trimws(as.character(speciesgroups[ii]))
    
  }
  
  return(Catch.Species.Data1)
}
