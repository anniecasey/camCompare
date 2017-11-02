## glist = list of indexes

# Creates list of start time indexes according to species (glist)
start_FUN <- function(glist)
{
  if (length(glist) <= 0)   return("AC:: EMPTY LIST")

  starttimes <-list()
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
            starttimes[i] <- glist[i+1]
            break
          }
  }
  starttimes <- c(glist[1], starttimes)
  starttimes <- starttimes[!unlist(lapply(starttimes, is.null))]
  starttimes <- as.numeric(starttimes)
  starttimes

}
