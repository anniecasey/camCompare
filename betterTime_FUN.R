## file    = original raw data
## dateCol = column NAME containing date
## timeCol = column NAME containing time
## dsep    = character separating values in dateCol (default /)
## tsep    = character separating values in timeCol (deafult :)

# Adds necessary date and time columns to original dataset file
# Year, Month, Day, Hour, Minute, Second columns all required for sortKing function
betterTime <- function(file, dateCol, timeCol, dsep= "/", tsep = ":")
{

  dates <- file[[dateCol]]
  Day <- list()
  Month <- list()
  Year <- list()
  for(i in 1:length(dates))
  {
    ## dd/mm/yyyy format
    d <- as.numeric(unlist(strsplit(dates[i], dsep)))
    Day[i] <- d[1]
    Month[i] <- d[2]
    Year[i] <- d[3]
  }

  times <- file[[timeCol]]
  Hour <- list()
  Minute <- list()
  Second <- list()
  for(i in 1:length(times))
  {
    ## HH:MM:SS format
    t <- as.numeric(unlist(strsplit(times[i], tsep)))
    Hour[i] <- t[1]
    Minute[i] <- t[2]
    Second[i] <- t[3]
  }

  all <- cbind(Year, Month, Day, Hour, Minute, Second)
  data <- as.data.frame(all)
  col <- 1:ncol(data)
  data[,col] <- unlist(data[,col])
  cbind(file, data)
}
