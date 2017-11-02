# This script sorts out the species visits according to the indexes in the METADATA_2013 data frame.
# This is the direction to use when needing to sort out every species visits in the data frame...
library(lubridate)

# Correcting Station Column in METADATA_2013 from double to string
library(readxl)
METADATA_2013 <- read_excel("~/Desktop/Lajuma Project/Data/METADATA 2013.xlsx")
METADATA_2013[327143:331234, "Station"] <- "14TOLO"
METADATA_2013[331235:335324, "Station"] <- "16TOLO"
METADATA_2013[335325:336159, "Station"] <- "18TOLO"
METADATA_2013[336160:338528, "Station"] <- "20TOLO"

EZtable <- function(file, stationCol, speciesCol)
{
  # file needs YMD & HMS as separate columns
  file             <-   as.data.frame(file)
  file$EZ_Station  <-   file[[stationCol]]
  file$EZ_Species  <- gsub(" ", "_", tolower(file[[speciesCol]]))
  file$EZ_DateTime <-   make_datetime(year  = file$Year,
                                      month = file$Month,
                                      day   = file$Day,
                                      hour  = file$Hour,
                                      min   = file$Minute,
                                      sec   = file$Second)
  file[, c("EZ_Station", "EZ_Species", "EZ_DateTime")]
}
EZdata       <- EZtable(METADATA_2013, "Station", "Species01")
species_list <- sort(unique(EZdata$EZ_Species))
station_list <- unique(EZdata$EZ_Station)


station_FUN <- function(x)
{
  which(EZdata$EZ_Station == x)
}

all <- tapply(station_list, 1:length(station_list), station_FUN)

start_FUN <- function(spec)
{
  starttimes <-list()

glist <- which(EZdata$EZ_Species == spec)


for(i in 1:(length(glist)-1))
{
  time1 <- EZdata$EZ_DateTime[glist[i]]
  time2 <- EZdata$EZ_DateTime[glist[i+1]]
  difference <- difftime(time2,
                         time1,
                         units="mins")
  if(as.numeric(difference > 30))
  {
    starttimes[i] <- glist[i+1]
  }
}
  starttimes <- starttimes[!unlist(lapply(starttimes, is.null))]
  starttimes <- as.numeric(starttimes)
  starttimes <- c(glist[1], starttimes)
  starttimes

}



######################################################

end_FUN <- function(spec)
{

glist <- which(EZdata$EZ_Species == spec)

endtimes <- list()

for(i in 1:(length(glist)-1))
  {
    time1 <- EZdata$EZ_DateTime[glist[i]]
    time2 <- EZdata$EZ_DateTime[glist[i+1]]
    difference <- difftime(time2,
                           time1,
                           units="mins")
    if(as.numeric(difference > 30))
    {
      endtimes[i] <- glist[i]
    }
  }
  endtimes <- endtimes[!unlist(lapply(endtimes, is.null))]
  endtimes <- as.numeric(endtimes)
  endtimes <- c(endtimes, glist[length(glist)])
  endtimes

}



start <- tapply(short, 1:length(short), start_FUN)
start <- sort(unique(unlist(start)))

end <-tapply(short, 1:length(short), end_FUN)
end <- sort(unique(unlist(end)))

new_dataset    <- EZdata[start, ]
endtimes_data  <- EZdata[end, "EZ_DateTime"]
new_dataset$End_Time <- endtimes_data
names(new_dataset) <- c("Station", "Species", "Start Time", "End Time")
new_dataset
