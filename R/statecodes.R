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

statecodes <-
  function(st, methods.Comm.States, output = "Number") {
    if (output %in% "Number") {
      if (sum(as.character(st) %in% "US") == 1) {
        st <-
          as.character(methods.Comm.States)[2:length(as.character(methods.Comm.States))]
      }
      a <-
        (state.codes$state.no[state.codes$state.abb %in% as.character(st)])
    } else if (output %in% "Abb") {
      if (sum(as.character(st) %in% 0) == 1) {
        st <- as.numeric(st)[2:length(as.numeric(st))]
      }
      a <-
        (state.codes$state.no[state.codes$state.abb %in% as.character(st)])
    }
    return(a)
  }
