EZdata <- EZtable(METADATA_2013, "Station", "Species01")
species_list <- sort(unique(EZdata$EZ_Species))
station_list <- unique(EZdata$EZ_Station)
all <- tapply(station_list, 1:length(station_list), station_FUN)
# summary(all) should match filter by station in Excel

casey <- function(spec)
{
  if (!is.element(spec, species_list)) return("AC:: UNKNOWN SPECIES")

  start <- list()
  end   <- list()
  for (i in 1:length(station_list))
  {
    glist <- list()
    glist <- all[[i]]
    x     <- which(EZdata[glist,"EZ_Species"] == spec)
    glist <- glist[x]
    if (length(glist) <= 0) next

    start[[i]] <- start_FUN(glist)
    end[[i]]  <- end_FUN(glist)
  }

  new_dataset    <- EZdata[as.numeric(unlist(start)), ]
  endtimes_data  <- EZdata[as.numeric(unlist(end)), "EZ_DateTime"]
  new_dataset$End_Time <- endtimes_data
  names(new_dataset) <- c("Station", "Species", "Start Time", "ST.Dec", "End Time", "ET.Dec")
  new_dataset
}
### BAD EXAMPLE:: banded_mongoose

