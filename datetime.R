
date_time <- function(file,x)
{
# data and time metadata converted to proper format for comparison
datetime <- make_datetime(year = file$Year,
                          month = file$Month,
                          day = file$Day,
                          hour = file$Hour,
                          min = file$Minute,
                          sec = file$Second,
                          tz = "UTC")
datetime[x]
}
