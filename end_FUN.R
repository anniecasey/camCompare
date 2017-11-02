## glist = list of indexes

# Creates list of end time indexes according to species (glist)
end_FUN <- function(glist)
{
  if (length(glist) <= 0)   return("AC:: EMPTY LIST")

  endtimes <- list()
  for(i in 1:(length(glist)-1))
  {
    time1      <- EZdata$'Start DateTime'[glist[i]]
    time2      <- EZdata$'Start DateTime'[glist[i+1]]
    difference <- as.numeric(difftime(time2,
                                      time1,
                                      units="mins"))
      if(is.na(difference)) break
          while(difference > visit)
          {
            endtimes[i] <- glist[i]
            break
          }
  }
  endtimes <- c(endtimes, glist[length(glist)])
  endtimes <- endtimes[!unlist(lapply(endtimes, is.null))]
  endtimes <- as.numeric(endtimes)
  endtimes

}
