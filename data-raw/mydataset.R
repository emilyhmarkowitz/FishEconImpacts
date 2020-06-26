library(readr)
library(readxl)

####LOAD DATA#####

########***State Codes########
state.codes <-recstatecodes1<- read_csv("data-raw/recstatecodes1.csv")
statecodes<- read_csv("data-raw/statecodes.csv")
statereg<- read_csv("data-raw/statereg.csv")
area<-list("PAC" = c("CA", "OR", "WA"), 
           "NE" = c("CT", "ME", "MA", "NH", "RI"), 
           "MA" = c("DE", "MD", "NJ", "NY", "VA"), 
           "SA" = c("FL", "EFL", "GA", "NC", "SC"), 
           "GOM" = c("AL", "FL", "WFL", "LA", "MS", "TX") )


########***Inflators########
GDP_inflator<- read_csv("data-raw/GDP_inflator.csv")
gdpdef_stfed<- read_csv("data-raw/gdpdef_stfed.csv")
ImplictPriceDeflator<- read_csv("data-raw/IPD2017.csv")
ImplictPriceDeflator <-
  data.frame("Year" = ImplictPriceDeflator[, c(1)],
             "Annual value" = ImplictPriceDeflator[, c(2)])
names(ImplictPriceDeflator) <- c("Year", "Annual value")
ImplictPriceDeflator.Ex <-
  ImplictPriceDeflator[(nrow(ImplictPriceDeflator) - 3):nrow(ImplictPriceDeflator), ]

#######***Catch Commerical#################

Comm.Catch.Data <- read.csv(paste0(getwd(), "/data-raw/landings.csv"))
names(Comm.Catch.Data)[3]<-"Species"
Comm.Catch.Data$Species<-trimws(as.character(Comm.Catch.Data$Species))
Comm.Catch.Data$Pounds<-as.numeric(gsub(pattern = ",",replacement = "", x = Comm.Catch.Data$Pounds))
Comm.Catch.Data$Dollars<-as.numeric(gsub(pattern = ",",replacement = "", x = Comm.Catch.Data$Dollars))

#######***Catch Regional#################

Rec.Catch.Ex <-data.frame("Mode" = 0,
                          "Year" = 0,
                          "Subregion" = 0,
                          "State No" = 0,
                          "Area" = 0,
                          "Estimated Trips" = 0,
                          "Variance" = 0)



########***Species Commercial########
olo_species_codes<-species.codes<- read_csv("data-raw/olo_species_codes.csv")

species.codes$FUS_NAME[which(species.codes$AFS_NAME == "POLLOCK, WALLEYE")] <-
  "Pollock, Alaska"
species.codes$NAME[which(species.codes$AFS_NAME == "POLLOCK, WALLEYE")] <-
  "Pollock,Alaska"
species.codes$AFS_NAME[which(species.codes$AFS_NAME == "POLLOCK, WALLEYE")] <-
  "POLLOCK, ALASKA"


Comm.Catch.Species.Ex <-
  data.frame(
    'East Coast Groundfish' = c('Cod, Atlantic', 'Cusk', ''),
    'HMS' = c('Billfishes', 'Bonito', 'Dolphin')
  )

names(Comm.Catch.Species.Ex) <- c('East Coast Groundfish', "HMS")

Comm.Catch.Spp.List.National <-
  Comm.Catch.Spp.List <- list(
    subtract = list(
      'Shrimp' = c(),
      'Crab' = c("Crab, Horse"),
      'Lobster' = c(),
      'East Coast Groundfish' = c(
        'Flounder, Arrowtooth',
        'Flounder, Pacific*',
        'Flounders, Righteye',
        'Hake, Pacific',
        'CUSK-EELS'
      ),
      'HMS' = c("Shark,*Dogfish"),
      'Reef Fish' = c("Mackerel, Atlantic"),
      'West Coast Groundfish ' = c("Pollock, Walleye", "SOLE, YELLOWFIN"),
      'West Coast Whiting ' = c(),
      'Halibut' = c(),
      'Menhaden and Industrial' = c(),
      'Salmon' = c(),
      'Sea Scallop' = c(),
      'Pelagic Herring and Mackerel' = c(),
      'Surf Clam and Ocean Quahog' = c(),
      'Other Trawl' = c("HERRING, PACIFIC, ROE ON KELP"),
      'All Other Finfish' = c("GRAND TOTALS"),
      'All Other Shellfish' = c('CLAM, ATLANTIC SURF', 'CLAM, OCEAN QUAHOG', 'CLAM, QUAHOG'),
      'Freshwater' = c(),
      'Inshore and Miscellaneous' = c("BASS, ROCK"),
      'Bait' = c()
    ),
    add = list(
      'Shrimp' = c("shrimp", "mantis", "penaeid"),
      'Crab' = "crab",
      'Lobster' = "lobster",
      'East Coast Groundfish' = c(
        'Cod, Atlantic',
        'Cusk',
        'Flatfish',
        'Flounder',
        'Goosefish',
        'Haddock',
        'Hake',
        'Hogchoker',
        'Plaice',
        'Scup*',
        "BASS, BLACK SEA ",#'Sea Bass, Black',
        'Shark,*Dogfish',
        'SKATE*',
        'WOLFFISH, ATLANTIC'
      ),
      'HMS' = c(
        'Billfishes',
        'Bonito',
        'Dolphin',
        'Finfishes, Pel*',
        'Marlin',
        'Sail*',
        'Shark',
        'Spear*',
        'Sword*',
        'Thresher*',
        'Tuna*'
      ),
      'Reef Fish' = c(
        'BIGEYE',
        'BUTTERFLYFISHES',
        'Coney',
        'GAG',
        'GLASSEYE SNAPPER',
        'GRAYSBY',
        'GROUPER*',
        'HOGFISH',
        'JACK*',
        'JOBFISH, GREEN (UKU)',
        'MACKEREL*',
        'POMPANO*',
        'ROSEFISH, BLACKBELLY',
        'RUNNER*',
        'SCAMP',
        'SCORPIONFISH*',
        'SHEEPSHEAD',
        'SNAPPER*',
        'Spanish flag',
        'SQUIRRELFISHES',
        'SURGEONFISHES',
        'TILEFISH*',
        'WENCHMAN',
        'YELLOWTAIL'
      ),
      'West Coast Groundfish ' = c(
        'Cod, Pacific',
        'Flounder, Arrowtooth',
        'Flounder, Pacific*',
        'Flounders, Righteye',
        'Hake, Pacific',
        'Lingcod',
        'Pollock',
        'Rockfish*',
        'Sablefish',
        'SANDDAB, PACIFIC',
        'Seabass, White',
        'Sole'
      ),
      'West Coast Whiting ' = c("Hake, Pacific"),
      'Halibut' = c("HALIBUT"),
      'Menhaden and Industrial' = c(
        'ALEWIFE',
        'LADYFISH',
        'MENHADEN, ATLANTIC',
        'OILFISH',
        'MENHADEN'
      ),
      'Salmon' = "Salmon",
      'Sea Scallop' = c("SCALLOP"),
      'Pelagic Herring and Mackerel' = c("Herring", "Mackerel, Atlantic"),
      'Surf Clam and Ocean Quahog ' = c('CLAM, ATLANTIC SURF', 'CLAM, OCEAN QUAHOG', 'CLAM, QUAHOG'),
      'Other Trawl' = c(
        'ANCHO*',
        'ATKA MACKEREL',
        'BLUEFISH',
        'BUTTERFISH',
        'CROAKER, ',
        'DORY, AMERICAN JOHN',
        'GRENADIERS',
        'Lumpfish',
        'MULLET*',
        'OCTOPUS',
        'POMFRETS',
        'REDFISH',
        'SARDINE*',
        'SHAD*',
        'SPOT',
        'SQUID*',
        'THORNYHEAD, '
      ),
      'All Other Shellfish  ' = c(
        'Abalone*',
        'Clam',
        'Cockle',
        'coral*',
        'Crab, Horse',
        'LIMPETS',
        'MOLLUSKS',
        'MUSSEL*',
        'OYSTER*',
        'PERIWINKLES',
        'SEA URCHINS',
        'SHELLFISH',
        'SNAILS (CONCHS)'
      ),
      'Freshwater ' = c(
        'PERCH*',
        'QUILLBACK',
        'SILVERSIDES',
        'STURGEON*',
        'SUCKERS',
        'SUNFISHES',
        'TILAPIAS',
        'TROUT, ',
        'TURTLE*',
        'WALLEYE',
        'WHITEFISH, ',
        'BASS, ROCK',
        'BOWFIN',
        'BUFFALOFISHES',
        'BURBOT',
        'CARP*',
        'CATFISH*',
        'CHUBS',
        'CRAPPIE',
        'CRAYFISHES OR CRAWFISHES',
        'DRUM, FRESHWATER',
        'FINFISHES, FW, OTHER',
        'GARS',
        'GOLDFISH',
        'Mooneyes'
      ),
      'Inshore and Miscellaneous' = c(
        'Stingrays',
        'Alligator*',
        'Bass',
        'ECHINODERM',
        'Frog*',
        'HERRING, PACIFIC, ROE ON KELP',
        'Jellyfish*',
        'LEATHER-BACK',
        'PERMIT',
        'RAYS',
        'SEA CUCUMBER',
        'SEAWEED*',
        'SPONGE*',
        'Starfish'
      ),
      'Bait' = c(
        'BALLYHOO',
        'BLOODWORMS',
        'FINFISHES, UNC BAIT AND ANIMAL FOOD',
        'MUMMICHOG',
        'SANDWORMS'
      )
    )
  )


Comm.Catch.Spp <- data.frame(
  Species = names(Comm.Catch.Spp.List$add),
  Pounds = 0,
  Dollars = 1000000
)

Comm.Catch.Spp.List.NE <- list(
  subtract = list(
    "Lobster" = c(),
    "Herring" = c(),
    "Sea Scallop" = c(),
    "Summer Flounder" = c(),
    "Black Sea Bass" = c(),
    "Scup" = c(),
    "Bluefish" = c(),
    "Groundfish" = c(),
    "Mackerel" = c(),
    "Monkfish" = c(),
    "Red Crab" = c(),
    "Spiny Dogfish" = c(),
    "Skate" = c(),
    "Surfclam and Ocean Quahog" = c(),
    "Whiting/Other Hakes" = c(),
    "Tilefish" = c(),
    "Jonah Crab" = c()
    # "All Other" = c()
  ),
  add = list(
    "Lobster" = "lobster",
    "Herring" = "Herring",
    "Sea Scallop" = 'CLAM, ATLANTIC SURF',
    "Summer Flounder" = c("FLOUNDER, SUMMER"),
    "Black Sea Bass" = "BASS, BLACK SEA ", #c("SEA BASS, BLACK"),
    "Scup" = c("SCUPS OR PORGIES", "SCUP"),
    "Bluefish" = c("BLUEFISH"),
    "Groundfish" = c(
      'Cod, Atlantic',
      'Cusk',
      'Flatfish',
      'Flounder',
      'Goosefish',
      'Haddock',
      'Hake',
      'Hogchoker',
      'Plaice',
      'Scup*',
      "BASS, BLACK SEA ",#'Sea Bass, Black',
      'Shark,*Dogfish',
      'SKATE*',
      'WOLFFISH, ATLANTIC'
    ),
    "Mackerel" = "Mackerel, Atlantic",
    "Monkfish" = ("monk"),
    "Red Crab" = c("CRAB, RED ROCK", "CRAB, RED PA"),
    "Spiny Dogfish" = c("SHARK, SPINY DOGFISH"),
    "Skate" = c("Skate"),
    "Surfclam and Ocean Quahog" = c('CLAM, ATLANTIC SURF', 'CLAM, OCEAN QUAHOG', 'CLAM, QUAHOG'),
    "Whiting/Other Hakes" = c("Hake", "Whiting"),
    "Tilefish" = c("Tilefish"),
    "Jonah Crab" = c("CRAB, JONAH")
    # "All Other" = c()
  )
)

for (j in 1:length(Comm.Catch.Spp.List.NE$add)){
  Comm.Catch.Spp.List.NE$subtract$`All Other`<-c(Comm.Catch.Spp.List.NE$subtract$`All Other`, 
                                                 Comm.Catch.Spp.List.NE$add[j][[1]])
}
Comm.Catch.Spp.List.NE$add$`All Other`<-
  species.codes$AFS_NAME[!(species.codes$AFS_NAME %in% 
                             Comm.Catch.Spp.List.NE$subtract$`All Other`)]


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


Comm.Catch.Spp.df<-Catch.Species.Data <- spp_list2df(Comm.Catch.Spp.List.National)
Comm.Catch.Spp.df<-Catch.Species.Data <- spp_list2df(Comm.Catch.Spp.List.NE)

# Remove species that are not included in the analysis
species.codes<-species.codes[-(grep(pattern = "fw", 
                                    x = species.codes$AFS_NAME, 
                                    ignore.case = T)),]
species.codes<-species.codes[-(grep(pattern = "freshwater", 
                                    x = species.codes$AFS_NAME, 
                                    ignore.case = T)),]
species.codes<-species.codes[-(grep(pattern = "Catfish", 
                                    x = species.codes$AFS_NAME, 
                                    ignore.case = T)),]
species.codes<-species.codes[-(grep(pattern = "Lake", 
                                    x = species.codes$AFS_NAME, 
                                    ignore.case = T)),]
species.codes<-species.codes[-(grep(pattern = "Perch, Yellow", 
                                    x = species.codes$AFS_NAME, 
                                    ignore.case = T)),]


#######***Species Recreational####
Rec.Catch.Spp.df <- Comm.Catch.Spp.df
########***Imports########
GearType_NE<- read_csv("data-raw/GearType_NE.csv")
Impacts_Sector_Markups <- read_csv("data-raw/Impacts_Sector_Markups.csv")
Imports_2015 <- read_csv("data-raw/Imports_2015.csv")

Imports_States_2010 <- Imports.States <- read_csv("data-raw/Imports_States_2010.csv")
Imports.States$States<-trimws(Imports.States$States)
for (i in 1:length(area)){
  a<-cbind.data.frame(States = names(area)[i], 
                                                    Imports = sum(Imports.States$Imports[Imports.States$States %in% area[i][[1]]], na.rm = T),
                                                    data.frame(t(colMeans(Imports.States[Imports.States$States %in% area[i][[1]],-c(1,2)], na.rm = T))))
  names(a)<-names(Imports.States)
                      
  Imports.States<-rbind.data.frame(Imports.States, a)
}

Imports_States_2015 <- read_csv("data-raw/Imports_States_2015.csv")
Imports_Species_2010<- read_csv("data-raw/Imports_Species_2010.csv")


#National
spp <- unique(c(trimws(as.character(names(Comm.Catch.Spp.List.National$add))), 
                trimws(as.character(names(Comm.Catch.Spp.List.NE$add)))))

spp <- gsub(pattern = "&",
            replacement = "and",
            x = spp)

spp <- gsub(pattern = "/",
            replacement = " and ",
            x = spp)

Imports.Species <- Imports.Species.National <- data.frame(Species = spp,
                                                          spp.Prop = abs(rnorm(
                                                            n = length(spp), mean = .5, sd = .5
                                                          )))

Imports.States.Ex <- data.frame(Imports.States[1:3, ])
Imports.Species.Ex <- data.frame(Imports.Species[1:3, ])

YearIn.Imports.Auto <- 2010








#######***Imports Recreational#########
Rec.Imports <-
  Rec.Impact.Enter <-
  Rec.Impact.Sector.Ex <-
  data.frame(Species = as.character(Comm.Catch.Spp$Species),
             'Imports ($)' = 0)
Rec.ImportsMarkups <-
  Rec.Impact.Sectors.Enter <-
  Rec.Impact.Sector.Ex <-
  data.frame(
    Sector = c(
      "Harvesters",
      "Aquaculture",
      "Processors",
      "Wholesalers",
      "Retail"
    ),
    'Markups (%)' = 0
  )

#########***Impacts Commerical####################

Comm.Impact.Species <-
  Comm.Impact.Enter <-
  Comm.Impact.Ex <-
  data.frame(
    Species = as.character(Comm.Catch.Spp$Species),
    Markup = rnorm(
      n = length(Comm.Catch.Spp$Species),
      mean = .5,
      sd = .5
    )
  )
Comm.Impact.Species.Ex <- Comm.Impact.Enter[1:3, ]

Comm.Impact.Sector <-
  read.csv(paste0(getwd(), "/data-raw/Impacts_Sector_Markups.csv"),
           stringsAsFactors = FALSE)

Comm.Impact.Sector.Ex <-
  Comm.Impact.Sector.Enter <- Comm.Impact.Sector[1:4, ]


########***Multipliers Commerical########
Multipliers_Recreational<- read_csv("data-raw/Multipliers_Recreational.csv")
Multipliers_Commercial<- Comm.Mult.Data <- Comm.Mult <- read.csv(file = "./data-raw/Multipliers_Commercial.csv")
YearIn.Mult.Auto <- 2014
for (i in 8:ncol(Comm.Mult.Data)) {
  Comm.Mult.Data[, i] <-
    as.numeric(gsub(
      x = Comm.Mult.Data[, i],
      pattern = ",",
      replacement = ""
    ))
}

Comm.Mult.Data <-
  Comm.Mult.Data[Comm.Mult.Data$Index %in% 1:20 &
                   !(Comm.Mult.Data$Jurisdiction_Long %in% "Sum"), ]
Comm.Mult.Data$Species <- trimws(as.character(Comm.Mult.Data$Species))
names(Comm.Mult.Data) <-
  c(
    "Notes",
    "Jurisdiction",
    "Jurisdiction_Long",
    "GearType",
    "Stakeholders",
    "Index",
    "Species",
    "RPC",
    "DirectImpacts.PersonalIncomeMultipliers",
    "IndirectImpacts.PersonalIncomeMultipliers",
    "InducedImpacts.PersonalIncomeMultipliers",
    "TotalImpacts.PersonalIncomeMultipliers",
    "DirectImpacts.OutputMultipliers",
    "IndirectImpacts.OutputMultipliers",
    "InducedImpacts.OutputMultipliers",
    "TotalImpacts.OutputMultipliers",
    "DirectImpacts.EmploymentMultipliers",
    "IndirectImpacts.EmploymentMultipliers",
    "InducedImpacts.EmploymentMultipliers" ,
    "TotalImpacts.EmploymentMultipliers",
    "DirectImpacts.PersonalIncomeImpacts"      ,
    "IndirectImpacts.PersonalIncomeImpacts",
    "InducedImpacts.PersonalIncomeImpacts"   ,
    "TotalImpacts.PersonalIncomeImpacts",
    "DirectImpacts.OutputImpacts"                ,
    "IndirectImpacts.OutputImpacts",
    "InducedImpacts.OutputImpacts"               ,
    "TotalImpacts.OutputImpacts" ,
    "DirectImpacts.EmploymentImpacts"  ,
    "IndirectImpacts.EmploymentImpacts",
    "InducedImpacts.EmploymentImpacts",
    "TotalImpacts.EmploymentImpacts",
    "DirectImpacts.ValueAdded"               ,
    "IndirectImpacts.ValueAdded",
    "InducedImpacts.ValueAdded",
    "TotalImpacts.ValueAdded"
  )

Comm.Mult.Data$Species<-trimws(as.character(Comm.Mult.Data$Species))
Comm.Mult.Data$Species<-gsub(pattern = "&", replacement = "and", x = as.character(Comm.Mult.Data$Species))
Comm.Mult.Data$Species<-gsub(pattern = "/", replacement = " and ", x = as.character(Comm.Mult.Data$Species))
Comm.Mult.Data$Species[Comm.Mult.Data$Species %in% c("All Others", "All Other", "")]<- "Other Gear"
Comm.Mult.Data$GearType<-trimws(as.character(Comm.Mult.Data$GearType))
Comm.Mult.Data$Jurisdiction<-trimws(as.character(Comm.Mult.Data$Jurisdiction))
Comm.Mult.Data$Stakeholders<-trimws(as.character(Comm.Mult.Data$Stakeholders))

Comm.Mult.Data.Ex <-
  Comm.Mult.Data[1:3, !(names(Comm.Mult.Data) %in% c("Notes", "Jurisdiction_Long", "Index"))]
Comm.Mult.Ex <- Comm.Mult.Data[1:2, ]

#######***Multipliers Recreational#######
Rec.Mult <- read.csv(file = "./data-raw/Multipliers_Recreational.csv")
Rec.Mult.Ex <- Rec.Mult.Ex <- Rec.Mult[1:2, ]
Rec.Mult.Enter <-
  data.frame(t(
    data.frame(
      "PerTripModeAverageCost_h" = c("Per Trip Mode Average Cost", "", "For Hire", 0),
      "ImpactMultiplier1_h" = c("Impact Multiplier 1", "", "For Hire", 0),
      "ImpactMultiplier2_h" = c("Impact Multiplier 2", "", "For Hire", 0),
      "ImpactMultiplier3_h" = c("Impact Multiplier 3", "", "For Hire", 0),
      "ImpactMultiplier4_h" = c("Impact Multiplier 4", "", "For Hire", 0),
      "PerTripModeAverageCost_p" = c("Per Trip Mode Average Cost", "", "Private", 0),
      "ImpactMultiplier1_p" = c("Impact Multiplier 1", "", "Private", 0),
      "ImpactMultiplier2_p" = c("Impact Multiplier 2", "", "Private", 0),
      "ImpactMultiplier3_p" = c("Impact Multiplier 3", "", "Private", 0),
      "ImpactMultiplier4_p" = c("Impact Multiplier 4", "", "Private", 0),
      "PerTripModeAverageCost_s" = c("Per Trip Mode Average Cost", "", "Shore", 0),
      "ImpactMultiplier1_s" = c("Impact Multiplier 1", "", "Shore", 0),
      "ImpactMultiplier2_s" = c("Impact Multiplier 2", "", "Shore", 0),
      "ImpactMultiplier3_s" = c("Impact Multiplier 3", "", "Shore", 0),
      "ImpactMultiplier4_s" = c("Impact Multiplier 4", "", "Shore", 0)
    )
  ))
names(Rec.Mult.Enter) <- c("Name", "State", "Mode", "Amount")

# Rec.Mult.Enter$State<-input$ChooseStates[[1]]
# Rec.Mult.Enter<-Rec.Mult.Enter[Rec.Mult.Enter$Mode %in% (input$RecreationalMode[[1]])]
# if (length(input$RecreationalModes) %in% 1) {
#   Rec.Mult.Enter$Mode<-names(input$RecreationalModes)
# } else if (length(input$RecreationalModes) %in% 2){
# Rec.Mult.Enter<-rbind.data.frame(Rec.Mult.Enter,
#                                   Rec.Mult.Enter,
#                                   Rec.Mult.Enter)
# }


########***Gear Type#######
Comm.Catch.Gear.NE0 = read.csv(paste0(getwd(), "/data-raw/GearType_NE.csv"),
                               stringsAsFactors = FALSE)

names(Comm.Catch.Gear.NE0)[1]<-""

Comm.Catch.Gear.NE0<-Comm.Catch.Gear.NE0[,match(table = names(Comm.Catch.Gear.NE0), 
                                                x = sort(names(Comm.Catch.Gear.NE0)))]

b<-names(Comm.Catch.Spp.List.NE$add)
b<-c("", sort(b))


names(Comm.Catch.Gear.NE0)<-b

library(tidyr)
Comm.Catch.Gear.NE<-gather(Comm.Catch.Gear.NE0, X, value, 
                           names(Comm.Catch.Gear.NE0)[2]:names(Comm.Catch.Gear.NE0)[ncol(Comm.Catch.Gear.NE0)], 
                           factor_key = T)

names(Comm.Catch.Gear.NE)<-c("GearType", "Species", "percent")


Comm.Catch.GearType <- Comm.Catch.Gear.NE

########***Product Flow########
ProductFlow_BasicData_StateTotals_test<- read_csv("data-raw/ProductFlow_BasicData_StateTotals_test.csv")
ProductFlow_BasicData_Sythesis_test<- read_csv("data-raw/ProductFlow_BasicData_Sythesis_test.csv")
ProductFlow_BasicData_test<- read_csv("data-raw/ProductFlow_BasicData_test.csv")
ProductFlow_synthesis_comm<- Comm.ProductFlow.Data <- read.csv(file = "./data-raw/ProductFlow_synthesis_comm.csv")

names(Comm.ProductFlow.Data) <-
  c(
    "Source",
    "Processors",
    "SecondaryWholesalers",
    "FoodserviceResturants",
    "GroceriesRetailMarkets",
    "Exports",
    "FinalConsumers",
    "Total"
  )




####MENUS####
methods.Comm.States <- list()
for (i in 1:length(unique(Comm.Mult.Data$Jurisdiction))) {
  methods.Comm.States[i] <-
    as.character(paste0(unique(Comm.Mult.Data$Jurisdiction)))[i]
  names(methods.Comm.States)[i] <-
    paste0(
      unique(Comm.Mult.Data$Jurisdiction_Long)[i],
      " (", unique(Comm.Mult.Data$Jurisdiction)[i], ")"
    )
}

methods.Rec.States <- list(
  'United States (US)' = 'US',
  'Alaska (AK)' = 'AK',
  'Alabama (AL)' = 'AL',
  # 'California (CA)' = 'CA',
  'Connecticut (CT)' = 'CT',
  'Delaware (DE)' = 'DE',
  # 'Florida (FL)' = 'FL',
  'Georgia (GA)' = 'GA',
  'Hawai`i (HI)' = 'HI',
  'Louisiana (LA)' = 'LA',
  'Massachusetts (MA)' = 'MA',
  'Maryland (MD)' = 'MD',
  'Maine (ME)' = 'ME',
  'Mississippi (MS)' = 'MS',
  'North Carolina (NC)' = 'NC',
  'New Hampshire (NH)' = 'NH',
  'New Jersey (NJ)' = 'NJ',
  'New York (NY)' = 'NY',
  # 'Oregon (OR)' = 'OR',
  'Rhode Island (RI)' = 'RI',
  'South Carolina (SC)' = 'SC',
  'Texas (TX)' = 'TX',
  'Virginia (VA)' = 'VA',
  # 'Washington (WA)' = 'WA',
  "West Florida (WFL)" = 'WFL',
  "East Florida (EFL)" = 'EFL'
)

methods.IPD.Type <- list(
  "Use default" = "Auto",
  "Input your own annual values" = "Upload",
  "Manually Enter IPD Data" = "Enter"
)

methods.Analysis.Type <- list(
  "Commerical" = "Comm" ,
  "Recreational" = "Rec",
  "Aquaculture (not coded)" = "Aqu"
)

methods.Catch.Type <- list(
  "Auto-add Data" = "Auto" ,
  "Manually Enter Data by Species" = "Enter.Spp",
  "Manually Enter Data by Species Group" = "Enter.SppGroup",
  "Upload a CSV with your Data by Species" = "Upload.Spp",
  "Upload a CSV with your Data by Species Group" = "Upload.SppGroup"
)

methods.Catch.Species <-
  list(
    "Do not group species in list" = "NoGroup",
    "Use the US commerical species lists" = "Auto_Comm_US",
    "Use the US recreational species list" = "Auto_Rec_US",
    "Upload your own list" = "Upload"
  )

methods.Catch.GearType <-
  list(
    "Do not group gear types in list" = "NoGroup",
    "Use the commerical gear type lists" = "Auto_Comm_US",
    "Use the US recreational gear type List" = "Auto_Rec_US",
    "Upload your own list" = "Upload"
  )

methods.Mult.Type <- list(
  "Automatically Download" = "Auto",
  "Upload a CSV with your Multiplier Data" = "Upload"#,
  # "Manually Enter Data" = "Enter"
)

methods.Impact.Species.Type <-
  list(
    "Automatically Download" = "Auto",
    "Upload a CSV with your Impacts Data" = "Upload",
    "Manually Enter Data" = "Enter"
  )

methods.Impact.Sector.Type <- list(
  "Automatically Download" = "Auto",
  "Upload a CSV with your Impacts Data" = "Upload",
  "Manually Enter Data" = "Enter"
)

methods.Imports.Type <- list(
  "Do not apply Import Data" = "None",
  "National 2017 Values" = "Auto",
  "Upload a CSV with your Import Data" = "Upload",
  "Manually Enter Data by Species" = "Enter.Spp",
  "Manually Enter Data by Species Groups" = "Enter.SppGroup"
)

methods.Imports.Comm <- list(
  # "None" = "None",
  "Domestic With Imports" = "With",
  "Just Imports" = "Imports",
  "Just Domestic" = "Domestic"
)

methods.Rec.Modes <- list("For Hire" = "ForHire", #c(4,5,6),
                          "Private" = "Private", #c(7,8),
                          "Shore" = "Shore")#c(1,2,3))

methods.Comm.Stakeholders <- list(
  "Harvesters" = "Harvesters",
  "Aquaculture" = "Aquaculture",
  "Processors" = "Processors",
  "Wholesalers" = "Wholesalers",
  "Grocers" = "Grocers",
  "Restaurants" = "Restaurants"
)

# methods.RecreationalModes<-list("Private" = "Private",
#                                 "For Hire" = "ForHire",
#                                 "Shore" = "Shore")

methods.YearOut <- list()
for (i in 1:nrow(ImplictPriceDeflator)) {
  methods.YearOut[i] <- ImplictPriceDeflator$Year[i]
  names(methods.YearOut)[i] <- ImplictPriceDeflator$Year[i]
}

# methods.YearsIn.Rec<-as.list(1981:substr(Sys.Date(), 0, 4))
# names(methods.YearsIn.Rec)<- c(1981:substr(Sys.Date(), 0, 4))

methods.YearsIn <-
  as.list(min(ImplictPriceDeflator$Year):max(ImplictPriceDeflator$Year))
names(methods.YearsIn) <-
  c(min(ImplictPriceDeflator$Year):max(ImplictPriceDeflator$Year))
methods.YearsIn$None <- "NA"
# methods.YearsIn.Enter<-as.list(1945:substr(Sys.Date(), 0, 4))
# names(methods.YearsIn.Enter)<- c(1945:substr(Sys.Date(), 0, 4))

# methods.Output.Type<-list("Summary of Impacts for All Species/Each Species Group" = "Species",
#                           "Summary of Labor Income" = "Labor",
#                           "Summary of Total Value" = "TotalValue",
#                           "Summary of Output Impacts" = "Output",
#                           "Summary of Employment Impacts" = "Employment")

methods.Out.Type <- list(
  "PII" = "",
  "Out" = "",
  "Emp" = "",
  "VA" = "",
  "AllSpecies" = "")



##########usethis::use_data##########

usethis::use_data(
  ########***State Codes########
  state.codes,
  statecodes,
  statereg,
  area,
  
  ########***Inflators########
  GDP_inflator,
  gdpdef_stfed,
  ImplictPriceDeflator,
  ImplictPriceDeflator.Ex,
  
  #######***Catch Commerical#################
  Comm.Catch.Data,
  
  #######***Catch Regional#################
  Rec.Catch.Ex,
  
  ########***Imports########
  GearType_NE,
  Impacts_Sector_Markups,
  Imports_2015,
  Imports_States_2010,
  Imports.States,
  Imports_States_2015,
  Imports_Species_2010,
  Imports.Species,
  Imports.States.Ex,
  Imports.Species.Ex,
  YearIn.Imports.Auto,
  
  #######***Imports Recreational#########
  Rec.Imports,
  Rec.ImportsMarkups,
  
  #########***Impacts Commerical####################
  Comm.Impact.Species,
  Comm.Impact.Species.Ex,
  Comm.Impact.Sector,
  Comm.Impact.Sector.Ex,
  
  ########***Multipliers Commerical########
  Multipliers_Commercial,
  YearIn.Mult.Auto,
  Comm.Mult.Data,
  Comm.Mult.Data.Ex,
  Comm.Mult.Ex,
  
  #######***Multipliers Recreational#######
  Multipliers_Recreational,
  Rec.Mult,
  Rec.Mult.Ex,
  Rec.Mult.Enter,
  
  ########***Species Commercial########
  species.codes,
  olo_species_codes,
  Comm.Catch.Species.Ex,
  Comm.Catch.Spp.df,
  Comm.Catch.Spp.List.National,
  Comm.Catch.Spp.List.NE,

  #######***Species Recreational####
  Rec.Catch.Spp.df,
  
  ########***Gear Type#######
  Comm.Catch.GearType,
  Comm.Catch.Gear.NE,
  
  ########***Product Flow########
  ProductFlow_BasicData_StateTotals_test,
  ProductFlow_BasicData_Sythesis_test,
  ProductFlow_BasicData_test,
  ProductFlow_synthesis_comm,
  Comm.ProductFlow.Data,
  
  ####MENUS####
  methods.Comm.States,
  methods.Rec.States,
  methods.IPD.Type,
  methods.Analysis.Type,
  methods.Catch.Type,
  methods.Catch.Species,
  methods.Catch.GearType,
  methods.Mult.Type,
  methods.Impact.Species.Type,
  methods.Impact.Sector.Type,
  methods.Imports.Type,
  methods.Imports.Comm,
  methods.Rec.Modes,
  methods.Comm.Stakeholders,
  methods.YearOut,
  methods.YearsIn,
  methods.Out.Type,
  
  overwrite = T)

