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

tolower2 <- function(str0, capitalizefirst = F) {
  str2 <- c()
  
  if (str0[1] %in% "") {
    str <- ""
  } else {
    for (i in 1:length(str0)) {
      str1 <-
        gsub(pattern = "\\(",
             replacement = "\\( ",
             x = tolower(str0[i]))
      str1 <- gsub(pattern = "\\)",
                   replacement = " \\)",
                   x = str1)
      str1 <- strsplit(x = str1, split = " ")[[1]]
      
      keywords <- c(
        #State
        "Alabama",
        "Alaska",
        "California",
        "Connecticut",
        "Delaware",
        "East Florida",
        "West Florida",
        "Florida",
        "Georgia",
        "Louisiana",
        "Maine",
        "Maryland",
        "Massachusetts",
        "Mississippi",
        "New Hampshire",
        "New Jersey",
        "New York",
        "North Carolina",
        "Oregon",
        "Rhode Island",
        "South Carolina",
        "Texas",
        "Virginia",
        "Washington",
        #Region
        "North Pacific",
        "Pacific",
        "Western Pacific (Hawai`i)",
        "Western Pacific",
        "New England",
        "Mid-Atlantic",
        "Gulf of Mexico",
        "South Atlantic",
        #For specific Species
        "Spanish",
        "Gulf",
        "Bringham's",
        "Von Siebold's",
        "Pfluger's",
        "African",
        "Eurpoean",
        # Other
        "Atlantic",
        "American",
        "Atka",
        "Chinook",
        "Great Lakes"
      )
      
      # keywords<-c(keywords, paste0("(", keywords), paste0(keywords, ")"))
      
      
      for (ii in 1:length(keywords)) {
        keywords1 <- strsplit(x = keywords[ii], split = " ")[[1]]
        if (length(keywords1) %in% 1 &
            sum(grepl(
              x = str0,
              pattern = keywords1[1],
              ignore.case = T
            )) > 0) {
          str1[grep(x = str1,
                    pattern = keywords[ii],
                    ignore.case = T)] <- keywords[ii]
        } else if (length(keywords1) %in% 2 &
                   sum(grepl(
                     x = str0,
                     pattern = keywords1[1],
                     ignore.case = T
                   ) > 0) &
                   sum(grepl(
                     x = str0,
                     pattern = keywords1[2],
                     ignore.case = T
                   ) > 0)) {
          str1[grep(x = str1,
                    pattern = keywords1[1],
                    ignore.case = T)] <- keywords1[1]
          str1[grep(x = str1,
                    pattern = keywords1[2],
                    ignore.case = T)] <- keywords1[2]
        } else if (length(keywords1) %in% 3 &
                   grepl(x = str0,
                         pattern = keywords1[1],
                         ignore.case = T) &
                   grepl(x = str0,
                         pattern = keywords1[2],
                         ignore.case = T) &
                   grepl(x = str0,
                         pattern = keywords1[3],
                         ignore.case = T)) {
          str1[sum(grep(
            x = str1,
            pattern = keywords1[1],
            ignore.case = T
          ) > 0)] <- keywords1[1]
          str1[sum(grep(
            x = str1,
            pattern = keywords1[2],
            ignore.case = T
          ) > 0)] <- keywords1[2]
          str1[sum(grep(
            x = str1,
            pattern = keywords1[3],
            ignore.case = T
          ) > 0)] <- keywords1[3]
        }
      }
      
      # if (str1[1] == "von" & str1[2] == "siebolds") {
      #   str1<-str1[2:length(str1)]
      #   str1<-c("VonSiebold's", str1[3])
      # }
      
      # if (sum(grepl(pattern = "*A'u*", x = str1, ignore.case = T))>=1) {
      #   str1[grepl(pattern = "*A'u*", x = str1, ignore.case = T)]<-"*A\U02BBu*"
      # }
      #
      # if (sum(grepl(pattern = "*O'io*", x = str1, ignore.case = T))>=1) {
      #   str1[grepl(pattern = "*O'io*", x = str1, ignore.case = T)]<-"*O\U02BBio*"
      # }
      #
      # if (sum(grepl(pattern = "*'Ahi*", x = str1, ignore.case = T))>=1) {
      #   str1[grepl(pattern = "*'Ahi*", x = str1, ignore.case = T)]<-"*\U02BBAhi*"
      # }
      
      
      str1 <- paste(str1, collapse = " ")
      str1 <- gsub(pattern = "\\( ",
                   replacement = "\\(",
                   x = str1)
      str1 <- gsub(pattern = " \\)",
                   replacement = "\\)",
                   x = str1)
      if (capitalizefirst == T) {
        str1 <-
          paste(toupper(substr(str1, 1, 1)), substr(str1, 2, nchar(str1)), sep = "")
        
      }
      
      str1 <- gsub(pattern = "&",
                   replacement = "and",
                   x = str1)
      
      str2 <- c(str2, str1)
    }
    str2 <- trimws(str2)
  }
  return(str2)
}
