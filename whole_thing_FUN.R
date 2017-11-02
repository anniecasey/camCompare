
## Creates new dataset of species visits sorted by station including input columns

# file must have YMD and HMS as separate columns
# whole_thing <- function(EZdata)
#{
  ### NOT working for some reason
  # EZdata       <- EZtable(file, stationCol, speciesCol, ...)
# Creates new dataset containing columns EZ_Station, EZ_Species, EZ_DateTime, EZ_Dec
  # species_list <- sort(unique(EZdata$EZ_Species))
  # station_list <- unique(EZdata$EZ_Station)
#}

library(readxl)
METADATA_2013 <- read_excel("~/Desktop/Lajuma Project/Data/METADATA 2013.xlsx")
METADATA_2013[327143:331234, "Station"] <- "14TOLO"
METADATA_2013[331235:335324, "Station"] <- "16TOLO"
METADATA_2013[335325:336159, "Station"] <- "18TOLO"
METADATA_2013[336160:338528, "Station"] <- "20TOLO"
EZdata <- EZtable(METADATA_2013, "Station", "Species01", "Moon Phase", "Temperature")
species_list <- sort(unique(EZdata$EZ_Species))
station_list <- unique(EZdata$EZ_Station)

  start <- tapply(station_list, 1:length(station_list), dev)
  end <- tapply(station_list, 1:length(station_list), dem)
  new_dataset    <- EZdata[as.numeric(unlist(start)), ]
  endtimes_data  <- EZdata[as.numeric(unlist(end)), "EZ_DateTime"]
  endtimes_dec   <- EZdata[as.numeric(unlist(end)), "EZ_Dec"]
  new_dataset$End_Time <- endtimes_data
  new_dataset$ET.Dec <- endtimes_dec

  names(new_dataset) <- c("Station", "Species", "Start Time", "ST.Dec",
                          "Moon Phase", "Temperature",
                          "End Time", "ET.Dec")
  new_dataset <- new_dataset[,c("Station", "Species", "Start Time", "ST.Dec", "End Time", "ET.Dec",
                   "Moon Phase", "Temperature")]
  new_dataset <- new_dataset[order(new_dataset$`Start Time`),]
  done <- new_dataset[order(new_dataset$Station),]
  done

#done <- whole_thing(METADATA_2013, "Station", "Species01", "Moon Phase", "Temperature")
#write.xlsx(x = done, file = "visits_by_station(ALL).xlsx")
