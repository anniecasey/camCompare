## Figure out how to search for exact string in grep
# ex. "rat" should only result in 75 indexes

speciesIndex <- function(spec)
{
  grep(spec, EZdata$Species, fixed = TRUE)

}




