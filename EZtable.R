### Creates new table of input file and specified columns with new column of EZdate
# file should be dataset of metadata
# station should be whatever the column name is that lists the camera station names/numbers
# species should be whatever the column name is that contains the species
# cols should be whatever other columns the user wishes to add (EX. Station or Temperature)

#IF the user wants to use EZdate, they must have YMD and HMS columns in their original dataset

# figure out how to make third argument "EZdate = TRUE", if set to false, don't include EZdate column

EZtable <- function(file, station, species, cols=NULL)
{
  # IF ezdate = TRUE
  file$EZdate <- EZdate(file)

  file$Station <- file[[station]]

  file$Species <- gsub(" ", "_", tolower(file[[species]]))

  file[, c("Station", "Species", "EZdate", cols)]
}

EZdata <- EZtable(METADATA_2013, "Station", "Species01")

