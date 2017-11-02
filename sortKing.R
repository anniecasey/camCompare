## file         = original raw file
## visit        = number of minutes defined in a "visit" (default = 30 minutes)
## stationCol   = column NAME recording station number/name
                    # assign stationCol to "character" class in read_excel
## speciesCol1  = column NAME recording species
                    # assign speciesCol1 to "character" class in read_excel
## ...          = additional data columns to be included in end result
                    # assign additional columns to "character" class in read_excel
                    # only records extra column data according to start time
                    # e.g. "Temperature", "Moon Phase"
## speciesCol2  = column NAME of additional species column (default NULL)
## speciesCol3  = column NAME of additional species column (default NULL)
                    # up to 3 different species columns allowed

# Sorts raw metadata by visits according to station and species
# station and species columns are required, include whatever additional columns you want
# file needs to include 6 columns for YMD and HMS

sortKing <- function(file, visit = 30, stationCol, speciesCol1, ..., speciesCol2 = NULL, speciesCol3 = NULL)
{
  visit  <<- visit
  EZdata <<- EZtable(file, stationCol, speciesCol1, speciesCol2 = speciesCol2, speciesCol3 = speciesCol3)

  species_list <<- sort(unique(EZdata$Species1))
  station_list <<- unique(EZdata$Station)

  start        <- tapply(station_list, 1:length(station_list), allStart)
  end          <- tapply(station_list, 1:length(station_list), allEnd)

  new_dataset    <- EZdata[as.numeric(unlist(start)), ]
  endtimes_data  <- EZdata[as.numeric(unlist(end)), "Start DateTime"]
  endtimes_dec   <- EZdata[as.numeric(unlist(end)), "ST.Dec"]

  new_dataset$'End DateTime'  <- endtimes_data
  new_dataset$ET.Dec          <- endtimes_dec

  args <- list(...)
  add_columns <- list()
  if(length(args) > 0)
  {
    a             <- unlist(args)
    add_columns   <- file[a]
    new_dataset   <- cbind(new_dataset, add_columns[as.numeric(unlist(start)),])
  }

  new_dataset <- new_dataset[order(new_dataset$`Start DateTime`),]
  done        <- new_dataset[order(new_dataset$Station),]
  done

}

#### EX: sortKing(METADATA_2013, visit = 30, "Station", "Species01", "Temperature", "Moon Phase", speciesCol2 = "Species02", speciesCol3 = "Species03")
