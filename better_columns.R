

## Creates new rows to be added into the original file
better_columns <- function(file, speciesCol1, speciesColx)
{
  file <- as.data.frame(file)

  add <- list()
  for (i in 1:nrow(file))
  {
    if (!is.na(as.character(file[i,speciesColx])))
    {
      add[[i]] <- i
    }
  }
add <- unlist(add)

  x <- file[add,]

  temp <- x[[speciesColx]]

  x[,speciesCol1] <- temp

  x
}
