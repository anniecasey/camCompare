species_list <- function(file, colname)
{

# Add new list of Species to the file so there are no discrepancies in the species names
  species_list <- tolower(file[[colname]])
  species_list <- gsub(" ", "_", species_list, fixed=TRUE)

}
