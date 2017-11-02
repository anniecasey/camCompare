
station_FUN <- function(x)
{
  if (!is.element(x, station_list))      return("AC:: UNKNOWN STATION")
  which(EZdata$EZ_Station == x)
}

