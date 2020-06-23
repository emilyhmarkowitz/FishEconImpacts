# This goes in R/data.R
# where you will add the documentation using roxygen.

#sinew::makeOxygen(obj = statereg, add_fields = "source")
#' @title statereg
#' @description DATASET_DESCRIPTION
#' @format A data frame with 25 rows and 10 variables:
#' \describe{
#'   \item{\code{State}}{character COLUMN_DESCRIPTION}
#'   \item{\code{State1}}{character COLUMN_DESCRIPTION}
#'   \item{\code{fips}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Region}}{character COLUMN_DESCRIPTION}
#'   \item{\code{abbvst}}{character COLUMN_DESCRIPTION}
#'   \item{\code{abbvreg}}{character COLUMN_DESCRIPTION}
#'   \item{\code{xstate}}{double COLUMN_DESCRIPTION}
#'   \item{\code{xreg}}{double COLUMN_DESCRIPTION}
#'   \item{\code{State.no}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Region.no}}{double COLUMN_DESCRIPTION}
#'}
#' @source \url{http://somewhere.important.com/}
"statereg"

# sinew::makeOxygen(obj = ImplictPriceDeflator, add_fields = "source")
#' @title ImplictPriceDeflator
#' @description DATASET_DESCRIPTION
#' @format A data frame with 89 rows and 4 variables:
#' \describe{
#'   \item{\code{Year}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IPD}}{double COLUMN_DESCRIPTION}
#'   \item{\code{2008 Base}}{double COLUMN_DESCRIPTION}
#'   \item{\code{2017 Base}}{double COLUMN_DESCRIPTION}
#'}
#' @source \url{http://somewhere.important.com/}
"ImplictPriceDeflator"

# sinew::makeOxygen(obj = statereg_rec, add_fields = "source")
#' @title statereg_rec
#' @description DATASET_DESCRIPTION
#' @format A data frame with 25 rows and 5 variables:
#' \describe{
#'   \item{\code{state.no}}{double COLUMN_DESCRIPTION}
#'   \item{\code{state.name}}{character COLUMN_DESCRIPTION}
#'   \item{\code{region.name}}{character COLUMN_DESCRIPTION}
#'   \item{\code{region.no}}{double COLUMN_DESCRIPTION}
#'   \item{\code{state.abb}}{character COLUMN_DESCRIPTION}
#'}
#' @source \url{http://somewhere.important.com/}
"statereg_rec"
