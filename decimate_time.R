

# Creates decimal format based on 24 hour days
decimate_time <- function(datetime)
{
  time <- format(as.POSIXct(datetime), format = "%H:%M:%S")
  time <- as.numeric(unlist(strsplit(time, ":")))
  time <- ((time[1]*3600 +
             time[2]*60 +
             time[3])
                /86400)
}
