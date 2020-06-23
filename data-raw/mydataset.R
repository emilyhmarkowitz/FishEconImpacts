## code to prepare `mydataset` dataset goes here


# data-raw/mydataset.R
# Data import and processing pipeline

library(readr)
library(readxl)

# ImplictPriceDeflator <- read_csv("data-raw/IPD2017.csv")
# statereg_rec <- read_csv("data-raw/recstatecodes1.csv")
statereg <- read_csv("data-raw/statereg.csv")

# pendulum <- read_csv("data-raw/pendulum data.csv")
# demographics <- read_excel("data-raw/Demographics.xlsx")

# Data processing code here...

# This should be the last line.
# Note that names are unquoted.
# I like using overwrite = T so everytime I run the script the
# updated objects are saved, but the default is overwrite = F
usethis::use_data(statereg,# ImplictPriceDeflator, statereg_rec, 
                  overwrite = T)


# usethis::use_data(mydataset, overwrite = TRUE)
