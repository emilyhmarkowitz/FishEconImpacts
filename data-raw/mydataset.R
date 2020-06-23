## code to prepare `mydataset` dataset goes here


# data-raw/mydataset.R
# Data import and processing pipeline

library(readr)
library(readxl)

# ImplictPriceDeflator <- read_csv("data-raw/IPD2017.csv")
# statereg_rec <- read_csv("data-raw/recstatecodes1.csv")
statereg <- read_csv("data-raw/statereg.csv")
<<<<<<< HEAD
gdpdef_stfed <- read_csv("data-raw/gdpdef_stfed.csv")
Imports_Species_2010 <- read_csv("data-raw/Imports_Species_2010.csv")
Multipliers_Commercial <- read_csv("data-raw/Multipliers_Commercial.csv")

# Inflators
GDP_inflator<- read_csv("data-raw/GDP_inflator.csv")
gdpdef_stfed<- read_csv("data-raw/gdpdef_stfed.csv")
IPD2017<- read_csv("data-raw/IPD2017.csv")

#Imports
GearType_NE<- read_csv("data-raw/GearType_NE.csv")
Impacts_Sector_Markups <- read_csv("data-raw/Impacts_Sector_Markups.csv")
# Imports_2010 <- read_csv("data-raw/Imports_2010.csv")
Imports_2015 <- read_csv("data-raw/Imports_2015.csv")
Imports_States_2010 <- read_csv("data-raw/Imports_States_2010.csv")
Imports_States_2015 <- read_csv("data-raw/Imports_States_2015.csv")
Imports_Species_2010<- read_csv("data-raw/Imports_Species_2010.csv")
# Imports_Species_2015<- read_csv("data-raw/Imports_Species_2015.csv")

#Multipliers
Multipliers_Commercial<- read_csv("data-raw/Multipliers_Commercial.csv")
Multipliers_Recreational<- read_csv("data-raw/Multipliers_Recreational.csv")

#Species
olo_species_codes<- read_csv("data-raw/olo_species_codes.csv")

#Product Flow
ProductFlow_BasicData_StateTotals_test<- read_csv("data-raw/ProductFlow_BasicData_StateTotals_test.csv")
ProductFlow_BasicData_Sythesis_test<- read_csv("data-raw/ProductFlow_BasicData_Sythesis_test.csv")
ProductFlow_BasicData_test<- read_csv("data-raw/ProductFlow_BasicData_test.csv")
ProductFlow_synthesis_comm<- read_csv("data-raw/ProductFlow_synthesis_comm.csv")

#State Codes
recstatecodes1<- read_csv("data-raw/recstatecodes1.csv")
statecodes<- read_csv("data-raw/statecodes.csv")
statereg<- read_csv("data-raw/statereg.csv")

=======

# pendulum <- read_csv("data-raw/pendulum data.csv")
>>>>>>> baf9d3b005c2c787aa00eb464a5c3ff0b329b689
# demographics <- read_excel("data-raw/Demographics.xlsx")

# Data processing code here...

# This should be the last line.
# Note that names are unquoted.
# I like using overwrite = T so everytime I run the script the
# updated objects are saved, but the default is overwrite = F
<<<<<<< HEAD
usethis::use_data(
  statereg,
  gdpdef_stfed,

  # Inflators
  GDP_inflator,
  gdpdef_stfed,
  IPD2017,
  
  #Imports
  GearType_NE,
  Impacts_Sector_Markups,
  # Imports_2010,
  Imports_2015,
  Imports_States_2010,
  Imports_States_2015,
  Imports_Species_2010,
  # Imports_Species_2015,
  
  #Multipliers
  Multipliers_Commercial,
  Multipliers_Recreational,
  
  #Species
  olo_species_codes,
  
  #Product Flow
  ProductFlow_BasicData_StateTotals_test,
  ProductFlow_BasicData_Sythesis_test,
  ProductFlow_BasicData_test,
  ProductFlow_synthesis_comm,
  
  #State Codes
  recstatecodes1,
  statecodes,
  statereg, # ImplictPriceDeflator, statereg_rec, 
  
  overwrite = T)
=======
usethis::use_data(statereg,# ImplictPriceDeflator, statereg_rec, 
                  overwrite = T)
>>>>>>> baf9d3b005c2c787aa00eb464a5c3ff0b329b689


# usethis::use_data(mydataset, overwrite = TRUE)
