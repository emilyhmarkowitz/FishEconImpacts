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

Comm_Catch_Edit<-function(Comm.Catch.Data, Comm.Catch.Spp.List, Catch.GearType.Data,
                          st, YearIn, Catch.Type) {
  
  Comm.Catch.Data0<-Comm.Catch.Data
  
  ######Subset Landings Data by Region
  
  if (sum((st) %in% c("PAC", "NE", "MA", "SA", "GOM"))>0) {
    # if (sum(names(st) %in% c("Pacific", "Northeast", "Mid-Atlantic", "South Atlantic", "Gulf of Mexico"))>0) {
    # area<-list("Pacific" = c("California", "Oregon", "Washington"),
    #          "Northeast" = c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island"),
    #          "Mid-Atlantic" = c("Delaware", "Maryland", "New Jersey", "New York", "Virginia"),
    #          "South Atlantic" = c("Florida", "East Florida", "Georgia", "North Carolina", "South Carolina"),
    #          "Gulf of Mexico" = c("Alabama", "Florida", "West Florida", "Louisiana", "Mississippi", "Texas") )
    
    area<-list("PAC" = c("California", "Oregon", "Washington"),
               "NE" = c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island"),
               "MA" = c("Delaware", "Maryland", "New Jersey", "New York", "Virginia"),
               "SA" = c("Florida", "East Florida", "Georgia", "North Carolina", "South Carolina"),
               "GOM" = c("Alabama", "Florida", "West Florida", "Louisiana", "Mississippi", "Texas") )
    
    # area<-list("Pacific" = "PCR",
    #            "Northeast" = "NER",
    #            "Mid-Atlantic" = "MAR",
    #            "South Atlantic" = "SAR",
    #            "Gulf of Mexico" = "GMR" )
    
    Comm.Catch.Data0<-Comm.Catch.Data0[Comm.Catch.Data0$State %in% (area[(st)][[1]]) &
                                         Comm.Catch.Data0$Year %in% YearIn, ]
    
    
  } else {
    Comm.Catch.Data0<-Comm.Catch.Data0[Comm.Catch.Data0$Year %in% YearIn, ]
  }
  
  Comm.Catch.Data0<-aggregate(x = Comm.Catch.Data0[names(Comm.Catch.Data0) %in% c("Pounds", "Dollars")],
                              by = list("Species" = Comm.Catch.Data0$Species,
                                        "Year" = Comm.Catch.Data0$Year), FUN = sum, na.rm= T)
  Comm.Catch.Data0$State<-st
  
  ###########Species
  if (Catch.Type %in% c("Enter.SppGroup", "Upload.SppGroup")) {
    
    Comm.Catch.Data0$GearType<-NA
    
  } else {
    
    Catch.Species.Data1<-Comm.Catch.Spp.List#spp.listdf2list(Catch.Species.Data)
    
    whichrows<-function(keys, df, refcol) {
      rows<-c()
      if (length(keys) %in% 0) { rows<-0} else {
        for (i in 1:length(keys)) {
          rows <- c(rows, grep(pattern = keys[i], x = df[,names(df) %in% refcol], ignore.case = T))
        }
      }
      if (length(rows) %in% 0) { rows<-0}
      return(rows)
    }
    
    refcol <- "Species"
    df <- Comm.Catch.Data0
    fishtotals<-data.frame()
    spp.incl<-list()
    for (i in 1:length(Catch.Species.Data1$add)) {
      fishtotals<-rbind.data.frame(fishtotals,
                                   cbind.data.frame(Year = YearIn,
                                                    State = st,
                                                    Species = names(Catch.Species.Data1$add)[i],
                                                    Pounds = abs(sum(Comm.Catch.Data0[whichrows(keys = Catch.Species.Data1$add[[i]], df, refcol),
                                                                                      names(Comm.Catch.Data0) %in% "Pounds"], na.rm = T) -
                                                                   sum(Comm.Catch.Data0[whichrows(keys = Catch.Species.Data1$subtract[[i]], df, refcol),
                                                                                        names(Comm.Catch.Data0) %in% "Pounds"], na.rm = T)),
                                                    Dollars = abs(sum(Comm.Catch.Data0[whichrows(keys = Catch.Species.Data1$add[[i]], df, refcol),
                                                                                       names(Comm.Catch.Data0) %in% "Dollars"], na.rm = T) -
                                                                    sum(Comm.Catch.Data0[whichrows(keys = Catch.Species.Data1$subtract[[i]], df, refcol),
                                                                                         names(Comm.Catch.Data0) %in% "Dollars"], na.rm = T)),
                                                    GearType = NA))
      
      spp.incl[i]<-(ifelse((length(Catch.Species.Data1$subtract[[i]] %in% "NA") == 0 |
                              is.null(Catch.Species.Data1$subtract[[i]])), #if there is nothing to substract
                           list(Comm.Catch.Data0$Species[whichrows(keys = Catch.Species.Data1$add[[i]], df, refcol)]),
                           list(setdiff(Comm.Catch.Data0$Species[whichrows(keys = Catch.Species.Data1$add[[i]], df, refcol)],
                                        Comm.Catch.Data0$Species[whichrows(keys = Catch.Species.Data1$subtract[[i]], df, refcol)]))))
      # spp.incl[i]<-spp.incl[i][!(is.na(spp.incl[i]))]
      names(spp.incl)[[i]]<-names(Catch.Species.Data1$add)[i]
    }
    
    Comm.Catch.Data0<-fishtotals
  }
  Comm.Catch.Data0<-data.frame(Comm.Catch.Data0)
  
  ############Calculate Grand Totals
  if (sum(Comm.Catch.Data0$Species %in% "GRAND TOTALS")>0) {
    Comm.Catch.Data0<-Comm.Catch.Data0[-which(Comm.Catch.Data0$Species %in% "GRAND TOTALS"),]
  }
  
  ###########Gear Type
  if (is.data.frame(Catch.GearType.Data)) { #If there are zero non-NA gear type data /or/ at least one of the enteries in the gear type column is not NA
    Comm.Catch.Data00<-c()
    
    for (j in 1:length(unique(Comm.Catch.GearType$Species))) {
      # for (j in 1:length(unique(Comm.Catch.GearType$Species))) {
      
      spp<-as.character(unique(Comm.Catch.GearType$Species)[j])
      
      Comm.Catch.GearType0<-Comm.Catch.GearType[ Comm.Catch.GearType$Species %in% spp,]
      
      Comm.Catch.Data00<-rbind.data.frame(Comm.Catch.Data00,
                                          cbind.data.frame("Year"  = YearIn,#rep_len(x = YearIn, length.out = nrow(Comm.Catch.GearType0)),
                                                           "State" = as.character(st),#rep_len(x = st, length.out = nrow(Comm.Catch.GearType0)),
                                                           "Species" = spp,#rep_len(x = spp, length.out = nrow(Comm.Catch.GearType0)),
                                                           "Pounds" = Comm.Catch.Data0$Pounds[Comm.Catch.Data0$Species %in% spp] * Comm.Catch.GearType0$percent,
                                                           "Dollars" = Comm.Catch.Data0$Dollars[Comm.Catch.Data0$Species %in% spp] * Comm.Catch.GearType0$percent,
                                                           "GearType" = Comm.Catch.GearType0$GearType))
      
    }
    Comm.Catch.Data0<-Comm.Catch.Data00
    
    # Comm.Catch.Data0$Species0<-Comm.Catch.Data0$Species
    # Comm.Catch.Data0$Species<-paste0(Comm.Catch.Data0$Species," - ", Comm.Catch.Data0$GearType)
    
  }
  
  # names(Comm.Catch.Data0)[names(Comm.Catch.Data0) %in% "spp"]<-"Species"
  Comm.Catch.Data0$Species<-trimws(as.character(Comm.Catch.Data0$Species))
  # names(Comm.Catch.Data0)[1:2]<-c("Year", "State")
  Comm.Catch.Data0$State<-trimws(as.character(Comm.Catch.Data0$State))
  Comm.Catch.Data0$GearType<-trimws(as.character(Comm.Catch.Data0$GearType))
  
  return(data.frame(Comm.Catch.Data0))
}
