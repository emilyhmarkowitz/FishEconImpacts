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

Comm_Out <- function(Comm.Catch.Clean,
                     Comm.ProductFlow.Data,
                     ImplictPriceDeflator,
                     Comm.Impact.Sector,
                     Comm.Mult.Data,
                     st,
                     YearIn,
                     YearOut,
                     YearIn.Mult,
                     YearIn.Imports = NA,
                     Stakeholders0,
                     Imports.Comm,
                     Imports.States,
                     Imports.Species,
                     Catch.Type) {
  
  ############***Subset Data
  YearIn = as.numeric(YearIn)
  YearOut = as.numeric(YearOut)
  YearIn.Mult = as.numeric(YearIn.Mult)
  YearIn.Imports = as.numeric(YearIn.Imports)
  st<-as.character(st) #get it out of list form
  Species0 <- unique(as.character(Comm.Catch.Clean$Species))
  GearType0 <- unique(ifelse(as.character(Comm.Catch.Clean$GearType) %in% NA, "",
                             as.character(Comm.Catch.Clean$GearType)))
  
  # Comm.Mult0 <- Comm.Mult
  Comm.Mult.Data0 <- Comm.Mult.Data #Keep Origional
  Comm.Mult.Data1 <-
    Comm.Mult.Data[Comm.Mult.Data$Jurisdiction %in% (st) &
                     # (Comm.Mult.Data$GearType %in% GearType0 |
                     # Comm.Mult.Data$Species %in% Species0 ) &
                     Comm.Mult.Data$Stakeholders %in% Stakeholders0 , ]
  Comm.Mult.Data1 <-
    Comm.Mult.Data1[order(as.character(Comm.Mult.Data1$Species)), ]
  
  ############***Product Flow
  #US
  Harv.row <- "Landings/harvesters:  All species in US"
  Whole.row <- "Primary wholesalers/processors: shrimp--US"
  Retail.row <- "Secondary wholesalers/distributors--US"
  if (st %in% c("CT", "FL", "HI", "ME", "NJ", "NY", "RI", "SC")) {
    Harv.row <-
      "Landings/harvesters:  All species in CT,FL,HI,LA,ME,NC,NJ,NY,RI,SC,TX"
  } else if (st %in% c("AL", "MS")) {
    Harv.row <- "Landings/harvesters:  All species in AL,MS"
  } else if (st %in% "AK") {
    Harv.row <- "Landings/harvesters:  All species in Alaska"
    Whole.row <- "Primary wholesalers/processors:  Alaska"
    Retail.row <- "Secondary wholesalers/distributors:  Alaska"
  } else if (!(st %in% "AK")) {
    Whole.row <- "Primary wholesalers/processors:  States except Alaska"
    Retail.row <-
      "Secondary wholesalers/distributors:  States except Alaska"
  }
  
  
  ########***Calculate by Sector
  
  
  #####***Harvestors
  IPD <-
    IPDCalc(
      YearIn = YearIn,
      YearOut = YearIn.Mult,
      ImplictPriceDeflator = ImplictPriceDeflator
    )
  
  Comm.VOL.Harv <- cbind.data.frame(
    Stakeholder = "Harvesters",
    GearType = Comm.Catch.Clean$GearType,
    Species = Comm.Catch.Clean$Species,
    ValueOfSeaFoodInput = NA,
    ValueOfLandings = Comm.Catch.Clean$Dollars * ifelse(YearIn > YearIn.Mult, 1 / IPD, IPD) )
  
  Comm.VOL <- data.frame(Comm.VOL.Harv)
  
  #####***Processors
  if (sum(Stakeholders0 %in% "Processors")>0) {
    Comm.VOL.Proc <- data.frame(
      Stakeholder = "Processors",
      GearType = Comm.Catch.Clean$GearType,
      Species = Comm.Catch.Clean$Species,
      ValueOfSeaFoodInput = Comm.VOL.Harv$ValueOfLandings *
        Comm.ProductFlow.Data$Processors[Comm.ProductFlow.Data$Source %in% Harv.row] )
    Comm.VOL.Proc$ValueOfLandings <-
      Comm.VOL.Proc$ValueOfSeaFoodInput *
      Comm.Impact.Sector$Markups[(
        Comm.Impact.Sector$Jurisdiction %in% st &
          Comm.Impact.Sector$Stakeholders %in% "Processors" )]
    
    Comm.VOL <- rbind.data.frame(Comm.VOL, Comm.VOL.Proc)
    
    
    #####***Wholesalers
    if (sum(Stakeholders0 %in% "Wholesalers")>0) {
      Comm.VOL.Whole <- data.frame(
        Stakeholder = "Wholesalers",
        GearType = Comm.Catch.Clean$GearType,
        Species = Comm.Catch.Clean$Species,
        ValueOfSeaFoodInput = (
          Comm.VOL.Harv$ValueOfLandings *
            Comm.ProductFlow.Data$SecondaryWholesalers[Comm.ProductFlow.Data$Source %in% Harv.row] ) +
          ( Comm.ProductFlow.Data$SecondaryWholesalers[Comm.ProductFlow.Data$Source %in% Whole.row] *
              ( Comm.VOL.Proc$ValueOfSeaFoodInput + Comm.VOL.Proc$ValueOfLandings ) ) )
      Comm.VOL.Whole$ValueOfLandings <-
        Comm.VOL.Whole$ValueOfSeaFoodInput *
        Comm.Impact.Sector$Markups[Comm.Impact.Sector$Jurisdiction %in% st &
                                     Comm.Impact.Sector$Stakeholders %in% "Wholesalers"]
      
      Comm.VOL <- rbind.data.frame(Comm.VOL, Comm.VOL.Whole)
      
      
      #####***Retailers - Grocers
      if (sum(Stakeholders0 %in% "Grocers")>0) {
        Comm.VOL.Groc <- data.frame(
          Stakeholder = "Grocers",
          GearType = Comm.Catch.Clean$GearType,
          Species = Comm.Catch.Clean$Species,
          ValueOfSeaFoodInput = (
            Comm.VOL.Harv$ValueOfLandings *
              Comm.ProductFlow.Data$GroceriesRetailMarkets[Comm.ProductFlow.Data$Source %in% Harv.row] ) +
            (  Comm.ProductFlow.Data$GroceriesRetailMarkets[Comm.ProductFlow.Data$Source %in% Whole.row] *
                 ( Comm.VOL.Proc$ValueOfSeaFoodInput + Comm.VOL.Proc$ValueOfLandings ) )  +
            ( Comm.ProductFlow.Data$GroceriesRetailMarkets[Comm.ProductFlow.Data$Source %in% Retail.row] *
                ( Comm.VOL.Whole$ValueOfSeaFoodInput + Comm.VOL.Whole$ValueOfLandings)  ) )
        Comm.VOL.Groc$ValueOfLandings <-
          Comm.VOL.Groc$ValueOfSeaFoodInput *
          Comm.Impact.Sector$Markups[Comm.Impact.Sector$Jurisdiction %in% st &
                                       Comm.Impact.Sector$Stakeholders %in% "Grocers"]
        
        Comm.VOL <- rbind.data.frame(Comm.VOL, Comm.VOL.Groc)
        
      }#groc
      
      #####***Retailers - Resturants
      if (sum(Stakeholders0 %in% "Restaurants")>0) {
        Comm.VOL.Rest <- data.frame(
          Stakeholder = "Restaurants",
          GearType = Comm.Catch.Clean$GearType,
          Species = Comm.Catch.Clean$Species,
          ValueOfSeaFoodInput = (
            Comm.VOL.Harv$ValueOfLandings *
              Comm.ProductFlow.Data$FoodserviceResturants[Comm.ProductFlow.Data$Source %in% Harv.row] ) +
            ( Comm.ProductFlow.Data$FoodserviceResturants[Comm.ProductFlow.Data$Source %in% Whole.row] *
                ( Comm.VOL.Proc$ValueOfSeaFoodInput + Comm.VOL.Proc$ValueOfLandings )  )  +
            ( Comm.ProductFlow.Data$FoodserviceResturants[Comm.ProductFlow.Data$Source %in% Retail.row] *
                (   Comm.VOL.Whole$ValueOfSeaFoodInput + Comm.VOL.Whole$ValueOfLandings ) ) )
        Comm.VOL.Rest$ValueOfLandings <-
          Comm.VOL.Rest$ValueOfSeaFoodInput *
          Comm.Impact.Sector$Markups[Comm.Impact.Sector$Jurisdiction %in% st &
                                       Comm.Impact.Sector$Stakeholders %in% "Restaurants"]
        
        Comm.VOL <- rbind.data.frame(Comm.VOL, Comm.VOL.Rest )
      } #rest
    } #whole
  } #proc
  
  # Comm.Mult0 <- Comm.VOL
  Comm.VOL$Jurisdiction <- as.character(st)
  # Comm.VOL$Jurisdiction0 <- names(st0)
  # Comm.VOL0<-Comm.VOL
  
  ####***Including imports?
  print("Imports")
  
  # Comm.VOL000<-data.frame()
  for (iiii in 1:length(Imports.Comm)) {
    Comm.VOL0<-Comm.VOL
    
    if (Imports.Comm[iiii] %in% c("Domestic")) {
      Comm.VOL0$Import<-names(Imports.Comm)[iiii]
      
    } else  { #if (Imports.Comm[iiii] %in% c("Imports", "With"))
      Imports.Species2 <-
        Comm_Imports_Edit(
          Imports.Species = Imports.Species[Imports.Species$Species %in% unique(Comm.VOL0$Species),],
          Imports.States = Imports.States[Imports.States$States %in% st,],
          st0 = as.character(st),
          YearIn.Imports = YearIn.Imports,
          YearIn.Mult = YearIn.Mult,
          YearOut = YearOut,
          ImplictPriceDeflator = ImplictPriceDeflator
        )
      Imports.Species2$ValueOfSeaFoodInput<-Imports.Species2$ValueOfLandings
      
      
      if (Imports.Comm[iiii] %in% c("With")) { #With
        
        a<-merge(y = Imports.Species2, x = Comm.VOL0, by = c("Species", "Stakeholder", "Jurisdiction"))
        
        a$ValueOfLandings <- a$ValueOfSeaFoodInput <- a$ValueOfLandings.x + a$ValueOfLandings.y
        a$ValueOfLandings.x <- a$ValueOfLandings.y <- a$ValueOfSeaFoodInput.y <- a$ValueOfSeaFoodInput.x <- NULL
        Comm.VOL0<-a
        Comm.VOL0$Import<-names(Imports.Comm)[iiii]
        
      } else if (Imports.Comm[iiii] %in% c("Imports")) {
        Imports.Species2$GearType<-NA #because imports have no gear type
        Comm.VOL0 <- Imports.Species2
        Comm.VOL0$ValueOfSeaFoodInput<-Comm.VOL0$ValueOfLandings
        Comm.VOL0$Import<-names(Imports.Comm)[iiii]
      }
    }
    # Comm.VOL0<-Comm.VOL0[,match(table = names(Comm.VOL), x = names(Comm.VOL0))]
    Comm.VOL0<-Comm.VOL0[,match(table = c(names(Comm.VOL), "Import"), x = names(Comm.VOL0))]
    if (iiii == 1) {
      Comm.VOL000<-Comm.VOL0
    } else {
      Comm.VOL000<-rbind.data.frame(Comm.VOL000, Comm.VOL0)
    }
  }
  
  Comm.VOL<-Comm.VOL000[Comm.VOL000$Stakeholder %in% Stakeholders0,]
  
  ######***Create Impacts
  #Multipliers
  for (ii in which(names(Comm.Mult.Data1) %in% "RPC"):which(names(Comm.Mult.Data1) %in% "TotalImpacts.ValueAdded")) {
    Comm.Mult.Data1[, ii] <- as.numeric(paste0(Comm.Mult.Data1[, ii]))
  }
  
  print("Create Impacts")
  
  Comm.Mult.Data2<-Comm.Mult.Data1
  
  Comm.VOL000<-c()
  for (i in 1:length(Stakeholders0)) {
    stake <- Stakeholders0[i]
    
    Comm.VOL0 <- Comm.VOL[Comm.VOL$Stakeholder %in% stake, ]
    Comm.VOL0 <- Comm.VOL0[order(Comm.VOL0$Species,
                                 Comm.VOL0$GearType), ]
    Comm.Mult.Data3 <-
      Comm.Mult.Data2[Comm.Mult.Data2$Stakeholder %in% stake, ]
    
    # Comm.Mult.Data<-Comm.Mult.Data[, 8:ncol(Comm.Mult.Data)]
    
    Comm.VOL00<-Comm.VOL0
    
    # for (iii in 8:ncol(Comm.Mult.Data2)) {
    # Comm.VOL00$temp<-NA
    # names(Comm.VOL00)[iii]<-names(Comm.Mult.Data3)[iii]
    # }
    Comm.Mult.Data200<-Comm.Mult.Data2
    Comm.Mult.Data200<-Comm.Mult.Data200[,which(names(Comm.Mult.Data200) %in% "DirectImpacts.PersonalIncomeMultipliers"):ncol(Comm.Mult.Data200)]
    a<-data.frame(matrix(data = NA, nrow = nrow(Comm.VOL00), ncol = ncol(Comm.Mult.Data200)))
    names(a) <- names(Comm.Mult.Data200[,which(names(Comm.Mult.Data200) %in% "DirectImpacts.PersonalIncomeMultipliers"):ncol(Comm.Mult.Data200)])
    Comm.VOL00<-cbind.data.frame(Comm.VOL00, a)
    
    OtherGear<-setdiff(x = (GearType0), y = unique(Comm.Mult.Data3$GearType))
    
    if ((length(OtherGear)>0) &
        (!(stake %in% "Harvesters") &
         (sum(Comm.Mult.Data3$GearType %in% "Other Gear")>0))) {
      
      for (ii in 1:length(Species0)) {
        
        Comm.Mult.Data4<-Comm.Mult.Data3[Comm.Mult.Data3$Species %in% c("Other Gear", ""),
                                         8:ncol(Comm.Mult.Data3)]
        Comm.Mult.Data4<-data.frame(Comm.Mult.Data4)
        
        for (iiii in 8:ncol(Comm.Mult.Data4)) {
          Comm.VOL00[,iiii+8]<-Comm.Mult.Data4[,iiii]
        }
        
      }
      
    }
    Comm.VOL000<-rbind.data.frame(Comm.VOL000, Comm.VOL00)
  }
  print("Combine Multipliers and Data")
  
  Comm.VOL<-Comm.VOL000[,c("Stakeholder", "GearType", "Species", "Import",
                           "ValueOfSeaFoodInput", "ValueOfLandings",
                           "Jurisdiction")]
  
  #TOLEDO
  names(Comm.Mult.Data2)[names(Comm.Mult.Data2) %in% "Stakeholders"]<-"Stakeholder"
  names(Comm.Mult.Data2)[names(Comm.Mult.Data2) %in% "RPC."]<-"RPC"
  Comm.VOL$GearType<-trimws(as.character(Comm.VOL$GearType))
  Comm.VOL$GearType[is.na(Comm.VOL$GearType)]<-""
  Comm.Mult.Data2$Species<-trimws(as.character(Comm.Mult.Data2$Species))
  Comm.VOL$Species<-trimws(as.character(Comm.VOL$Species))
  Comm.Mult.Data2$Stakeholder<-trimws(as.character(Comm.Mult.Data2$Stakeholder))
  Comm.VOL$Stakeholder<-trimws(as.character(Comm.VOL$Stakeholder))
  # Comm.VOL$Jurisdiction0<-NULL
  
  if (sum(unique(Comm.Mult.Data2$Species %in% "Other Gear")) == 1) {
    Comm.Mult.Data2$Species<-NULL
    Comm.Data<-merge(x = Comm.VOL, y = Comm.Mult.Data2,
                     by = c("Stakeholder", "GearType", "Jurisdiction"))
    # Comm.Data$Species<-Comm.Data$Species.x
    # Comm.Data$Species.x<-Comm.Data$Species.y<-NULL
    # Comm.Data$Jurisdiction<-Comm.Data$Jurisdiction.x
    # Comm.Data$Jurisdiction.x<-Comm.Data$Jurisdiction.y<-NULL
    
  } else {
    Comm.Data<-merge(x = Comm.VOL, y = Comm.Mult.Data2,
                     by = c("Stakeholder", "GearType", "Species", "Jurisdiction"))
  }
  rownames(Comm.Data) <- NULL
  print("Summarize by Stakeholder and Imports")
  
  
  
  #Personal Income Impacts (PII)
  Comm.Data$PII_DirImp <- Comm.Data$ValueOfLandings *
    Comm.Data$DirectImpacts.PersonalIncomeMultipliers * Comm.Data$RPC
  Comm.Data$PII_IIndir <- Comm.Data$ValueOfLandings *
    Comm.Data$IndirectImpacts.PersonalIncomeMultipliers * Comm.Data$RPC
  Comm.Data$PII_IInduc <- Comm.Data$ValueOfLandings *
    Comm.Data$InducedImpacts.PersonalIncomeMultipliers * Comm.Data$RPC
  Comm.Data$PII_Tot <- rowSums(na.rm = T,
                               x = data.frame(Comm.Data$PII_DirImp,
                                              Comm.Data$PII_IIndir,
                                              Comm.Data$PII_IInduc))
  
  #Output (Out)
  Comm.Data$Out_DirImp <- Comm.Data$ValueOfLandings *
    Comm.Data$DirectImpacts.OutputMultipliers * Comm.Data$RPC
  Comm.Data$Out_IIndir <- Comm.Data$ValueOfLandings *
    Comm.Data$IndirectImpacts.OutputMultipliers * Comm.Data$RPC
  Comm.Data$Out_IInduc <- Comm.Data$ValueOfLandings *
    Comm.Data$InducedImpacts.OutputMultipliers * Comm.Data$RPC
  Comm.Data$Out_Tot <- rowSums(na.rm = T,
                               x = data.frame(Comm.Data$Out_DirImp,
                                              Comm.Data$Out_IIndir,
                                              Comm.Data$Out_IInduc))
  
  #Employer (Emp)/Job
  Comm.Data$Emp_DirImp <- (Comm.Data$ValueOfLandings *
                             Comm.Data$DirectImpacts.EmploymentMultipliers * Comm.Data$RPC ) / 1e6
  Comm.Data$Emp_IIndir <- (Comm.Data$ValueOfLandings *
                             Comm.Data$IndirectImpacts.EmploymentMultipliers * Comm.Data$RPC) / 1e6
  Comm.Data$Emp_IInduc <- (Comm.Data$ValueOfLandings *
                             Comm.Data$InducedImpacts.EmploymentMultipliers * Comm.Data$RPC) / 1e6
  Comm.Data$Emp_Tot <- rowSums(na.rm = T,
                               x = data.frame(Comm.Data$Emp_DirImp,
                                              Comm.Data$Emp_IIndir,
                                              Comm.Data$Emp_IInduc))
  
  # Value Added (VA)
  Comm.Data$VA_DirImp <- Comm.Data$ValueOfLandings *
    Comm.Data$DirectImpacts.ValueAdded * Comm.Data$RPC
  Comm.Data$VA_IIndir <- Comm.Data$ValueOfLandings *
    Comm.Data$IndirectImpacts.ValueAdded * Comm.Data$RPC
  Comm.Data$VA_IInduc <- Comm.Data$ValueOfLandings *
    Comm.Data$InducedImpacts.ValueAdded * Comm.Data$RPC
  Comm.Data$VA_Tot <- rowSums(na.rm = T,
                              x = data.frame(Comm.Data$VA_DirImp,
                                             Comm.Data$VA_IIndir,
                                             Comm.Data$VA_IInduc))
  
  
  aa<-unique(Comm.Data[c("Stakeholder", "Import")])
  for (i in 1:nrow(aa)) {
    stake <- as.character(aa$Stakeholder[i])
    import<- as.character(aa$Import[i])
    
    #Combine and Total each
    lead<-data.frame(t(rep_len(x = NA, length.out = ncol(Comm.Data))))
    names(lead)<-names(Comm.Data)
    
    lead$Jurisdiction <- st
    lead$Stakeholder <- stake
    lead$Import <- import
    lead$GearType <- NA
    lead$Species <- "Total"
    lead[,c("ValueOfSeaFoodInput", "ValueOfLandings")]<-
      t(data.frame(colSums(x = Comm.Data[Comm.Data$Stakeholder %in% stake & Comm.Data$Import %in% import,
                                         names(Comm.Data) %in% c("ValueOfSeaFoodInput", "ValueOfLandings")],
                           na.rm = T)))
    
    
    lead[,which(names(Comm.Data) %in% c("PII_DirImp")):which(names(Comm.Data) %in% c("VA_Tot"))]<-
      t(data.frame(colSums(x = Comm.Data[Comm.Data$Stakeholder %in% stake,
                                         which(names(Comm.Data) %in% c("PII_DirImp")):which(names(Comm.Data) %in% c("VA_Tot"))],
                           na.rm = T)))
    
    row.names(lead) <- NULL
    
    Comm.Data <- rbind.data.frame(lead, Comm.Data)
  }
  print("Prepare Outputs")
  
  #convert values from multiplyer YearIn number to the year you actualy want to output to (YearOut)
  for (i in which(names(Comm.Data) %in% c("PII_DirImp")):which(names(Comm.Data) %in% c("VA_Tot"))) {
    IPD <-
      IPDCalc(YearIn = YearIn.Mult,
                    YearOut = YearOut,
                    ImplictPriceDeflator)
    Comm.Data[, i] <-
      Comm.Data[, i] * ifelse(YearOut < YearIn.Mult, 1 / IPD, IPD)
  }
  
  ######***Create Outputs
  tempnames <- c("Stakeholder", "Species", "GearType", "Import", "Direct Impacts", "Indirect Impacts", "Induced Impacts", "Total Impacts")
  tempnames.orig <- function(prefix) {return(c("Stakeholder", "Species", "GearType", "Import", paste0(paste0(prefix, "_"), c("DirImp", "IIndir", "IInduc", "Tot"))))}
  
  Out <- list()
  
  ####FEUS
  if (sum(Stakeholders0 %in% c("Harvesters",  "Processors",  "Wholesalers", "Grocers","Restaurants")) ==
      length(c("Harvesters",  "Processors",  "Wholesalers", "Grocers","Restaurants")) &
      sum(names(Imports.Comm) %in% c("Domestic With Imports", "Just Domestic")) ==
      length(c("Domestic With Imports", "Just Domestic"))) {
    
    FEUS_with<-rbind.data.frame(cbind.data.frame(
      Stakeholder = "Commercial Harvesters",
      Comm.Data[Comm.Data$Stakeholder %in% "Harvesters" &
                  Comm.Data$Import %in% "Domestic With Imports" &
                  Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")]),
      cbind.data.frame(
        Stakeholder = "Seafood Processors & Dealers",
        Comm.Data[Comm.Data$Stakeholder %in% "Processors" &
                    Comm.Data$Import %in% "Domestic With Imports" &
                    Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")]),
      cbind.data.frame(
        Stakeholder = "Seafood Wholesalers & Distributors",
        Comm.Data[Comm.Data$Stakeholder %in% "Wholesalers" &
                    Comm.Data$Import %in% "Domestic With Imports" &
                    Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")]),
      cbind.data.frame(
        Stakeholder = "Retail",
        t(colSums(rbind.data.frame(Comm.Data[Comm.Data$Stakeholder %in% "Grocers" &
                                               Comm.Data$Import %in% "Domestic With Imports" &
                                               Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")],
                                   Comm.Data[Comm.Data$Stakeholder %in% "Restaurants" &
                                               Comm.Data$Import %in% "Domestic With Imports" &
                                               Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")]), na.rm = T))))
    
    rownames(FEUS_with)<-FEUS_with$Stakeholder
    FEUS_with$Stakeholder<-NULL
    names(FEUS_with)<-paste0("With Imports ", c("#Jobs", "Sales", "Income", "Value-Added"))
    
    
    FEUS_without<-rbind.data.frame(cbind.data.frame(
      Stakeholder = "Commercial Harvesters",
      Comm.Data[Comm.Data$Stakeholder %in% "Harvesters" &
                  Comm.Data$Import %in% "Just Domestic" &
                  Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")]),
      cbind.data.frame(
        Stakeholder = "Seafood Processors & Dealers",
        Comm.Data[Comm.Data$Stakeholder %in% "Processors" &
                    Comm.Data$Import %in% "Just Domestic" &
                    Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")]),
      cbind.data.frame(
        Stakeholder = "Seafood Wholesalers & Distributors",
        Comm.Data[Comm.Data$Stakeholder %in% "Wholesalers" &
                    Comm.Data$Import %in% "Just Domestic" &
                    Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")]),
      cbind.data.frame(
        Stakeholder = "Retail",
        t(colSums(rbind.data.frame(Comm.Data[Comm.Data$Stakeholder %in% "Grocers" &
                                               Comm.Data$Import %in% "Just Domestic" &
                                               Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")],
                                   Comm.Data[Comm.Data$Stakeholder %in% "Restaurants" &
                                               Comm.Data$Import %in% "Just Domestic" &
                                               Comm.Data$Species %in% "Total",c("Emp_Tot", "Out_Tot", "PII_Tot", "VA_Tot")]), na.rm = T))))
    
    rownames(FEUS_without)<-FEUS_without$Stakeholder
    FEUS_without$Stakeholder<-NULL
    names(FEUS_without)<-paste0("Without Imports ", c("#Jobs", "Sales", "Income", "Value-Added"))
    
    
    a<-cbind.data.frame(FEUS_with, FEUS_without)
    a<-rbind.data.frame(colSums(a, na.rm = T), a)
    rownames(a)[1]<-"Total Impacts"
    a<-cbind.data.frame(rownames(a), a)
    names(a)[1]<-"Stakeholder"
    
  } else {
    a<-'To run the results for the FEUS format table, you will need to enter data for the "Harvesters", "Processors", "Wholesalers", "Grocers", and "Restaurants" sectors as well as import data so that both "Domestic With Imports" and "Just Domestic" can be evaluated.'
  }
  
  Out$FEUS<-a
  
  
  ####Other Parameters
  
  Out$PII <-
    Comm.Data[, tempnames.orig("PII")]
  names(Out$PII) <- tempnames
  names(Out)[length(Out)]<-"Summary of Personal Labor Income Impacts"
  Out$Out <-
    Comm.Data[, tempnames.orig("Out")]
  names(Out$Out) <- tempnames
  names(Out)[length(Out)]<-"Summary of Sales Output Impacts"
  Out$Emp <-
    Comm.Data[, tempnames.orig("Emp")]
  names(Out$Emp) <- tempnames
  names(Out)[length(Out)]<-"Summary of Employment Impacts"
  Out$VA <-
    Comm.Data[, tempnames.orig("VA")]
  names(Out$VA) <- tempnames
  names(Out)[length(Out)]<-"Summary of Added-Value Impacts"
  
  tempnames <- c("Multiplier", tempnames)
  
  temp.allspecies <- data.frame()
  for (iii in 1:length(unique(Comm.Data$Species))) {
    spp0 <- as.character(unique(Comm.Data$Species)[iii])
    a <- cbind("Personal Income", Comm.Data[Comm.Data$Species %in% spp0, tempnames.orig("PII")])
    b <- cbind("Output", Comm.Data[Comm.Data$Species %in% spp0, tempnames.orig("Out")])
    c <- cbind("Employer", Comm.Data[Comm.Data$Species %in% spp0, tempnames.orig("Emp")])
    d <- cbind("Value Added", Comm.Data[Comm.Data$Species %in% spp0, tempnames.orig("VA")])
    
    names(a) <- tempnames
    names(b) <- tempnames
    names(c) <- tempnames
    names(d) <- tempnames
    
    Out$temp <- rbind.data.frame(a, b, c, d)
    names(Out)[names(Out) %in% "temp"] <- paste0("Summary of Impacts on ", spp0)
    temp.allspecies <- rbind.data.frame(temp.allspecies,
                                        a, b, c, d)
  }
  
  Out$AllSpecies <- temp.allspecies
  
  names(Out)[length(Out)] <- "Summary of Each Species Impacts"
  
  
  return(Out)
  
}
