
EZdate <- function(file)
{
  make_datetime(year  = file$Year,
                month = file$Month,
                day   = file$Day,
                hour  = file$Hour,
                min   = file$Minute,
                sec   = file$Second)
}

