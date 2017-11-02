## x = species name to search for

# Returns indexes from entire dataset that match the given species
species_FUN <- function(x)
{
  if (!is.element(x, species_list)) return("AC:: UNKNOWN SPECIES")
  which(EZdata$Species1 == x)
}
