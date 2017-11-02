## station = station number/name to search for

# Creates list of all start indexes according to species and station
allStart <- function(station)
{
  if (!is.element(station, station_list))   return("AC:: UNKNOWN STATION")

  all   <- tapply(species_list, 1:length(species_list), species_FUN)
  start <- list()
  for (i in 1:length(species_list))
  {
    glist <- list()
    glist <- all[[i]]
    x     <- which(EZdata[glist,"Station"] == station)
    glist <- glist[x]
        if (length(glist) <= 0) next
    start[[i]] <- start_FUN(glist)
  }
  start
}
