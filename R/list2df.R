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


list2df <- function(xlist) {
  a <- c()
  for (i in 1:length(xlist)) {
    a <- rbind.data.frame(a,
                          data.frame(
                            object = as.character(names(xlist)[i]),
                            text = as.character(names(xlist[i][[1]])),
                            code = paste(as.character(xlist[i][[1]]), collapse = ", ")
                          ))
  }
  return(data.frame(a))
}
