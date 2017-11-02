EZdata <- EZtable(METADATA_2013, "Station", "Species01")
species_list <- sort(unique(EZdata$EZ_Species))
station_list <- unique(EZdata$EZ_Station)
all <- tapply(species_list, 1:length(species_list), species_FUN)
# summary(all) should match filter by station in Excel

annie <- function(station)
{
  if (!is.element(station, station_list)) return("AC:: UNKNOWN STATION")

  start <- list()
  end   <- list()
  for (i in 1:length(species_list))
  {
    glist <- list()
    glist <- all[[i]]
    x     <- which(EZdata[glist,"EZ_Station"] == station)
    glist <- glist[x]
    if (length(glist) <= 0) next

    start[[i]] <- start_FUN(glist)
    end[[i]]  <- end_FUN(glist)
  }
}

new_dataset    <- EZdata[as.numeric(unlist(start)), ]
endtimes_data  <- EZdata[as.numeric(unlist(end)), "EZ_DateTime"]
endtimes_dec   <- EZdata[as.numeric(unlist(end)), "EZ_Dec"]
new_dataset$End_Time <- endtimes_data
new_dataset$ET.Dec <- endtimes_dec
names(new_dataset) <- c("Station", "Species", "Start Time", "ST.Dec", "End Time", "ET.Dec")


