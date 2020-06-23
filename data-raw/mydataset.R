library(readr)
library(readxl)

statereg <- read_csv("data-raw/statereg.csv")
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
Imports_2015 <- read_csv("data-raw/Imports_2015.csv")
Imports_States_2010 <- read_csv("data-raw/Imports_States_2010.csv")
Imports_States_2015 <- read_csv("data-raw/Imports_States_2015.csv")
Imports_Species_2010<- read_csv("data-raw/Imports_Species_2010.csv")

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
  Imports_2015,
  Imports_States_2010,
  Imports_States_2015,
  Imports_Species_2010,

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

