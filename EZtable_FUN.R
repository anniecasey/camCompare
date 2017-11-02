## file         = original raw data
                  # file needs YMD & HMS as (6) separate columns
## stationCol   = column NAME recording station name/number in file
## speciesCol1  = column NAME recording species in file
## ...          = additional data columns of file to be included in end result
                  # c(colnames(file)) for every column
## speciesCol2  = optional secondary species column NAME (default NULL)
## speciesCol3  = optional additional species column NAME (default NULL)
                  # up to 3 species columns allowed

# Creates easy to read table from original raw metadata
# columns created by function start with "EZ" and are necessary for functions (sortKing & sameRange) to run
# Creates 5 EZ columns, one being EZ_Dec which converts the time to a decimal number based on a 24-hour day
EZtable <- function(file, stationCol, speciesCol1, speciesCol2 = NULL, speciesCol3 = NULL)
{
  library(lubridate)

  if(!is.element(stationCol, colnames(file)))                               return("AC:: UNKNOWN STATION COLUMN NAME")
  if(!is.element(speciesCol1, colnames(file)))                              return("AC:: UNKNOWN SPECIES1 COLUMN NAME")
  if(length(speciesCol2) > 0 && !is.element(speciesCol2, colnames(file)))   return("AC:: UNKNOWN SPECIES2 COLUMN NAME")
  if(length(speciesCol3) > 0 && !is.element(speciesCol3, colnames(file)))   return("AC:: UNKNOWN SPECIES3 COLUMN NAME")

  file                  <- as.data.frame(file)
  file$'Start DateTime' <-   make_datetime(year  = file$Year,
                                           month = file$Month,
                                           day   = file$Day,
                                           hour  = file$Hour,
                                           min   = file$Minute,
                                           sec   = file$Second)
  x <- list()
  y <- list()
  if(!is.null(speciesCol2))
        {
          x <- better_columns(file,
                              speciesCol1 = speciesCol1,
                              speciesColx = speciesCol2)
          #x[,speciesCol2] <- NA
        }
  if(!is.null(speciesCol3))
        {
          y <- better_columns(file,
                              speciesCol1 = speciesCol1,
                              speciesColx = speciesCol3)
          #y[,speciesCol3] <- NA
        }

  z <- rbind(file, x, y)
  z <- as.data.frame(z)
  z <- z[order(z$'Start DateTime'),]
  z <- z[order(z$Station),]

  file          <-   as.data.frame(z)
  file$Station  <-   file[[stationCol]]
  file$Species1 <-   gsub(" ", "_", tolower(file[[speciesCol1]]))
  file$Date     <-   make_date(year  = file$Year,
                               month = file$Month,
                               day   = file$Day)
  file$'ST.Dec' <-   round(decimate_time(file), 6)

  # args <- list(...)
  # if(length(args) > 0)
  #       {
  #         for(i in 1:length(args))
  #         {
  #           file$args[[i]] <- args[[i]]
  #         }
  #       }
  df <- file[,c("Station", "Species1", "Date", "Start DateTime", "ST.Dec")]
  df
}

#annie <- EZtable(METADATA_2013, "Station", "Species01", "Temperature", "Moon Phase", speciesCol2 = "Species02", speciesCol3 = "Species03")

