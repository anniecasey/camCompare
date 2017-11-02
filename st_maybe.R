start_times <- function(spec)
{
  glist <- speciesIndex(spec)

  starttimes <-list()
  for(i in 1:(length(glist)-1))
  {
    a <- as.numeric(glist[i])
    b <- as.numeric(glist[i+1])

    time1 <- EZdata$EZdate[a]
    time2 <- EZdata$EZdate[b]

    difference <- difftime(time2,
                           time1,
                           units="mins")

    st1 <- EZdata$Station[a]
    st2 <- EZdata$Station[b]

    if (as.numeric(difference) > 30 && st1 == st2)
    {
      starttimes[i] <- glist[i+1]
    }
  }

  starttimes <- c(glist[1], starttimes)
  starttimes <- starttimes[!unlist(lapply(starttimes, is.null))]
  starttimes <- as.numeric(starttimes)

  starttimes
}
