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

<<<<<<< HEAD
##### Inflators#####

#sinew::makeOxygen(obj = gdpdef_stfed, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 90 rows and 2 variables:
#' \describe{
#'   \item{\code{YEAR}}{double COLUMN_DESCRIPTION}
#'   \item{\code{GDPDEF}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"gdpdef_stfed"

# sinew::makeOxygen(obj = GDP_inflator, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 17 rows and 2 variables:
#' \describe{
#'   \item{\code{Annual}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Annual value}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"GDP_inflator"

# sinew::makeOxygen(obj = gdpdef_stfed, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 90 rows and 2 variables:
#' \describe{
#'   \item{\code{YEAR}}{double COLUMN_DESCRIPTION}
#'   \item{\code{GDPDEF}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"gdpdef_stfed"

# sinew::makeOxygen(obj = IPD2017, add_fields = "source")
#' @title DATASET_TITLE
=======
# sinew::makeOxygen(obj = ImplictPriceDeflator, add_fields = "source")
#' @title ImplictPriceDeflator
>>>>>>> baf9d3b005c2c787aa00eb464a5c3ff0b329b689
#' @description DATASET_DESCRIPTION
#' @format A data frame with 89 rows and 4 variables:
#' \describe{
#'   \item{\code{Year}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IPD}}{double COLUMN_DESCRIPTION}
#'   \item{\code{2008 Base}}{double COLUMN_DESCRIPTION}
<<<<<<< HEAD
#'   \item{\code{2017 Base}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"IPD2017"

######Imports#####

# sinew::makeOxygen(obj = GearType_NE, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 15 rows and 19 variables:
#' \describe{
#'   \item{\code{Gear}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Lobster}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Herring}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Sea Scallop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Summer Flounder}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Black Sea Bass}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Scup}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Bluefish}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Groundfish}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Mackerel}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Monkfish}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Red Crab}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Spiny Dogfish}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Skate}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Surfclam/Ocean Quahog}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Whiting/Other Hakes}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Tilefish}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Jonah Crab}}{double COLUMN_DESCRIPTION}
#'   \item{\code{All Other}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"GearType_NE"

# sinew::makeOxygen(obj = Impacts_Sector_Markups, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 100 rows and 4 variables:
#' \describe{
#'   \item{\code{Jurisdiction}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Jurisdiction0}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Stakeholders}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Markups}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"Impacts_Sector_Markups"

# sinew::makeOxygen(obj = Imports_2015, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 24 rows and 8 variables:
#' \describe{
#'   \item{\code{State}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Imports}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Whole.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Proc.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Groc.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Rest.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Exports from US}}{double COLUMN_DESCRIPTION}
#'   \item{\code{X8}}{logical COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"Imports_2015"

# sinew::makeOxygen(obj = Imports_States_2010, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 24 rows and 7 variables:
#' \describe{
#'   \item{\code{States}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Imports}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Whole.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Proc.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Groc.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Rest.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Exports from US}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"Imports_States_2010"

# sinew::makeOxygen(obj = Imports_States_2015, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 24 rows and 8 variables:
#' \describe{
#'   \item{\code{X1}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Imports}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Whole.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Proc.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Groc.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Rest.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Exports from US}}{double COLUMN_DESCRIPTION}
#'   \item{\code{X8}}{logical COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"Imports_States_2015"

# sinew::makeOxygen(obj = Imports_Species_2010, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 24 rows and 7 variables:
#' \describe{
#'   \item{\code{X1}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Imports}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Whole.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Proc.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Groc.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Rest.Prop}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Exports from US}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"Imports_Species_2010"

#####Multipliers######

# sinew::makeOxygen(obj = Multipliers_Commercial, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 2513 rows and 36 variables:
#' \describe{
#'   \item{\code{Notes}}{logical COLUMN_DESCRIPTION}
#'   \item{\code{Jurisdiction}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Jurisdiction_Long}}{character COLUMN_DESCRIPTION}
#'   \item{\code{GearType}}{logical COLUMN_DESCRIPTION}
#'   \item{\code{Stakeholders}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Index}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Species}}{character COLUMN_DESCRIPTION}
#'   \item{\code{RPC-}}{double COLUMN_DESCRIPTION}
#'   \item{\code{DirectImpacts-PersonalIncomeMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IndirectImpacts-PersonalIncomeMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{InducedImpacts-PersonalIncomeMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{TotalImpacts-PersonalIncomeMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{DirectImpacts-OutputMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IndirectImpacts-OutputMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{InducedImpacts-OutputMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{TotalImpacts-OutputMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{DirectImpacts-EmploymentMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IndirectImpacts-EmploymentMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{InducedImpacts-EmploymentMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{TotalImpacts-EmploymentMultipliers_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{DirectImpacts-PersonalIncomeImpacts_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IndirectImpacts-PersonalIncomeImpacts_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{InducedImpacts-PersonalIncomeImpacts_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{TotalImpacts-PersonalIncomeImpacts_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{DirectImpacts-OutputImpacts_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IndirectImpacts-OutputImpacts_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{InducedImpacts-OutputImpacts_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{TotalImpacts-OutputImpacts_000_2006}}{double COLUMN_DESCRIPTION}
#'   \item{\code{DirectImpacts-EmploymentImpacts_Full-part-timejobs}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IndirectImpacts-EmploymentImpacts_Full-part-timejobs}}{double COLUMN_DESCRIPTION}
#'   \item{\code{InducedImpacts-EmploymentImpacts_Full-part-timejobs}}{double COLUMN_DESCRIPTION}
#'   \item{\code{TotalImpacts-EmploymentImpacts_Full-part-timejobs}}{double COLUMN_DESCRIPTION}
#'   \item{\code{DirectImpacts-ValueAdded}}{double COLUMN_DESCRIPTION}
#'   \item{\code{IndirectImpacts-ValueAdded}}{double COLUMN_DESCRIPTION}
#'   \item{\code{InducedImpacts-ValueAdded}}{double COLUMN_DESCRIPTION}
#'   \item{\code{TotalImpacts-ValueAdded}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"Multipliers_Commercial"

# sinew::makeOxygen(obj = Multipliers_Recreational, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 390 rows and 6 variables:
#' \describe{
#'   \item{\code{Area}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Mode}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Name0}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Name}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Acount}}{double COLUMN_DESCRIPTION}
#'   \item{\code{X6}}{logical COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"Multipliers_Recreational"

#####Species#####

# sinew::makeOxygen(obj = olo_species_codes, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 1071 rows and 4 variables:
#' \describe{
#'   \item{\code{AFS_NAME}}{character COLUMN_DESCRIPTION}
#'   \item{\code{species}}{double COLUMN_DESCRIPTION}
#'   \item{\code{NAME}}{character COLUMN_DESCRIPTION}
#'   \item{\code{FUS_NAME}}{character COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"olo_species_codes"

#####Product Flow###### 
#sinew::makeOxygen(obj = ProductFlow_BasicData_StateTotals_test, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 25 rows and 2 variables:
#' \describe{
#'   \item{\code{State}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Total Value}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"ProductFlow_BasicData_StateTotals_test"

#sinew::makeOxygen(obj = ProductFlow_BasicData_Sythesis_test, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 6 rows and 7 variables:
#' \describe{
#'   \item{\code{ImportsAndDefaultDistribution}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Wholesalers}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Processors}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Retail}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Restaurants}}{double COLUMN_DESCRIPTION}
#'   \item{\code{ExportsFromUS}}{double COLUMN_DESCRIPTION}
#'   \item{\code{X7}}{logical COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"ProductFlow_BasicData_Sythesis_test"

#sinew::makeOxygen(obj = ProductFlow_BasicData_test, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 14 rows and 9 variables:
#' \describe{
#'   \item{\code{Source of fish, fish products}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Source}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Primary whole- salers/processors}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Secondary whole- salers/distributors}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Foodservice/ restaurants}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Groceries/ retail markets}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Exports}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Final consumers}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Total}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"ProductFlow_BasicData_test"

#sinew::makeOxygen(obj = ProductFlow_synthesis_comm, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 18 rows and 8 variables:
#' \describe{
#'   \item{\code{Product flow for shrimp and non-shrimp fish and fish products: synthesis of basic data Source of fish, fish products}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Destination of fish, fish products (percentage distribution) (Note 5) Primary processors}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Secondary whole- salers/distributors}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Foodservice/ restaurants}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Groceries/ retail markets}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Exports (Notes 6, 7)}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Final consumers}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Total}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"ProductFlow_synthesis_comm"

#######State Codes######
#sinew::makeOxygen(obj = recstatecodes1, add_fields = "source")
#' @title DATASET_TITLE
=======
#'   \item{\code{2017 Base}}{double COLUMN_DESCRIPTION}
#'}
#' @source \url{http://somewhere.important.com/}
"ImplictPriceDeflator"

# sinew::makeOxygen(obj = statereg_rec, add_fields = "source")
#' @title statereg_rec
>>>>>>> baf9d3b005c2c787aa00eb464a5c3ff0b329b689
#' @description DATASET_DESCRIPTION
#' @format A data frame with 25 rows and 5 variables:
#' \describe{
#'   \item{\code{state.no}}{double COLUMN_DESCRIPTION}
#'   \item{\code{state.name}}{character COLUMN_DESCRIPTION}
#'   \item{\code{region.name}}{character COLUMN_DESCRIPTION}
#'   \item{\code{region.no}}{double COLUMN_DESCRIPTION}
<<<<<<< HEAD
#'   \item{\code{state.abb}}{character COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"recstatecodes1"

#sinew::makeOxygen(obj = statecodes, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 25 rows and 4 variables:
#' \describe{
#'   \item{\code{State.no}}{double COLUMN_DESCRIPTION}
#'   \item{\code{State}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Region}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Region.no}}{double COLUMN_DESCRIPTION} 
#'}
#' @source \url{http://somewhere.important.com/}
"statecodes"

# sinew::makeOxygen(obj = statereg, add_fields = "source")
#' @title DATASET_TITLE
#' @description DATASET_DESCRIPTION
#' @format A data frame with 25 rows and 11 variables:
#' \describe{
#'   \item{\code{X1}}{double COLUMN_DESCRIPTION}
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


=======
#'   \item{\code{state.abb}}{character COLUMN_DESCRIPTION}
#'}
#' @source \url{http://somewhere.important.com/}
"statereg_rec"
>>>>>>> baf9d3b005c2c787aa00eb464a5c3ff0b329b689
