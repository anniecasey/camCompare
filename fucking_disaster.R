EZdata       <- EZtable(METADATA_2013, "Station", "Species01")
species_list <- sort(unique(EZdata$EZ_Species))
station_list <- unique(EZdata$EZ_Station)
all <- tapply(station_list, 1:length(station_list), station_FUN)

### GOOD NEWS, THIS DOESN'T WORK AND I HATE MYSELF

annie <- function(spec)
{
  glist <- list()
      for(i in 1:length(all))
      {
      EZdata <- EZtable(METADATA_2013, "Station", "Species01")
      EZdata <- EZdata[as.numeric(unlist(all[i])),]
      species <- list()
      species <- which(EZdata$EZ_Species == spec)
      glist[[i]] <- species
      }

        for(j in 1:length(all))
        {
            if(length(as.numeric(unlist(glist[j]))) == 0)
            {
              glist[j] <- NA
            }
        }
  #List of species occurences by station
  glist <- setNames(glist, station_list)
  glist <- glist[!is.na(glist)]
}

##############################################################################

  EZdata <- EZtable(METADATA_2013, "Station", "Species01")
  start <- list()
  for(i in 1:(length(glist)))
  {
    set <- glist[[i]]
    starttimes <- list()
          for(k in 1:(length(set)-1))
          {
            time1 <- EZdata$EZ_DateTime[set[k]]
            time2 <- EZdata$EZ_DateTime[set[k+1]]
            difference <- difftime(time2,time1,units="mins")
                if(as.numeric(difference) > 30)
                {
                  starttimes[k] <- set[k+1]
                }
          }
    starttimes <- starttimes[!unlist(lapply(starttimes, is.null))]
    starttimes <- as.numeric(starttimes)
    starttimes <- c(set[1], starttimes)
    #starttimes
    start[[i]] <- starttimes
    }
##############################################################################
  end <- list()
  for(i in 1:(length(glist)))
  {
    set <- glist[[i]]
    endtimes <- list()
    for(k in 1:(length(set)-1))
    {
      time1 <- EZdata$EZ_DateTime[set[k]]
      time2 <- EZdata$EZ_DateTime[set[k+1]]
      difference <- difftime(time2,time1,units="mins")
      if(as.numeric(difference) > 30)
      {
        endtimes[k] <- set[k]
      }
    }
    endtimes <- endtimes[!unlist(lapply(endtimes, is.null))]
    endtimes <- as.numeric(endtimes)
    endtimes <- c(endtimes, set[length(set)])
    #endttimes
    end[[i]] <- endtimes
  }

  new_dataset <- EZdata[start, ]
  endtimes_data  <- EZdata[end, "EZ_DateTime"]
  new_dataset$End_Time <- endtimes_data
  # names(new_dataset) <- c("Station", "Species", "Start Time", "End Time")
  # new_dataset
}
casey <- annie("common_warthog")






glist <- function(x)
{
  starttimes <-list()
  for(i in 1:(length(x)-1))
  {
    time1 <- EZdata$EZ_DateTime[x[i]]
    time2 <- EZdata$EZ_DateTime[x[i+1]]
    difference <- difftime(time2,
                           time1,
                           units="mins")
    if(as.numeric(difference > 30))
    {
      starttimes[i] <- x[i+1]
    }
  }
  starttimes <- starttimes[!unlist(lapply(starttimes, is.null))]
  starttimes <- as.numeric(starttimes)
  starttimes <- c(x[1], starttimes)
  starttimes

}

tapply(all, 1:length(all), station_test)

station_test <- function(x)
{
  for(i in 1:length(all))
  {
    st <- as.numeric(unlist(all[i]))
    alist <- list()
    if(st %in% )

    EZdata <- EZdata[st, ]
    start_FUN(EZdata, )
  }


}
