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

spp_list2df<- function(Comm.Catch.Spp.List) {
  
  #Create this list into a data frame, which will be easier for the user to input material into
  Comm.Catch.Spp.df <- data.frame(matrix(
    data = NA,
    nrow = 100,
    ncol = c(
      length(Comm.Catch.Spp.List$plus) + length(Comm.Catch.Spp.List$subtract)
    )
  ))
  
  for (i in 1:length(Comm.Catch.Spp.List)) {
    temp <- Comm.Catch.Spp.List[i][[1]]
    colover <-
      ifelse(i %in% 1, 0, length(names(Comm.Catch.Spp.List[i][[1]])))
    for (ii in 1:length(temp)) {
      # temp1<-temp[ii][[1]]
      Comm.Catch.Spp.df[0:length(temp[ii][[1]]), colover + ii] <-
        temp[ii][[1]]
      colnames(Comm.Catch.Spp.df)[colover + ii] <-
        paste0(trimws(names(temp)[ii][[1]]), "_", names(Comm.Catch.Spp.List)[i])
      # Comm.Catch.Spp.df<-t(Comm.Catch.Spp.df)
      # colnames(Comm.Catch.Spp.df)<-colnames(names(temp1))
    }
  }
  Comm.Catch.Spp.df <-
    Comm.Catch.Spp.df[, order(names(Comm.Catch.Spp.df))]
  Comm.Catch.Spp.df <-
    Comm.Catch.Spp.df[!(rowSums(is.na(Comm.Catch.Spp.df)) %in% ncol(Comm.Catch.Spp.df)), ]
  
  return(Comm.Catch.Spp.df)
  
}
