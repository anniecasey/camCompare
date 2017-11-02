# This function sorts out which indexes are the end times from the sorted_indexes function

end_times <- function(file, colname, spec)
{
  glist <- sorted_indexes(file, colname, spec)

  endtimes <- list()
  for(i in 1:(length(glist)-1))
  {
    time1 <- date_time(file, as.numeric(glist[i]))
    time2 <- date_time(file, as.numeric(glist[i+1]))
    difference <- difftime(time2,
                           time1,
                           units="mins")

    if (as.numeric(difference) > 30)
    {
      endtimes[i] <- glist[i]
    }
  }

  endtimes <- c(endtimes, glist[length(glist)])
  endtimes <- endtimes[!unlist(lapply(endtimes, is.null))]
  endtimes <- as.numeric(endtimes)

  endtimes
}
