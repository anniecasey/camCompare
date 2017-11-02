#' Start Times Indexes
#'
#' Sorts out the start time indexes from the sorted indexes
#'
#' @param file The metadata file containing your camera trap data. NOTE: Make sure your file has the following columns: "Year", "Month", "Day", "Hour", "Minute", "Second"
#' @param colname The name of the column in the metadata file to search for the selected species. EX: "Species01" or "Species"
#' @param spec The selected species to search for or to sort by. NOTE: Make sure you write the species name in quotation marks. Ignores capitalization. Don't worry bru!
#' @return List of sorted indexes according to input species file.
#'
#'
#' @author Annie Casey, \email{annie.casey15@gmail.com}
#' @keywords metadata species indexes
#'
#'
#' @examples
#' sorted_indexes(file     = "/Users/control/Desktop/Lajuma Project/Compare",
#'                colname  = "Species01",
#'                spec     =  "warthog")
#'
#' @export

start_times <- function(file, colname, spec)
{
  glist <- sorted_indexes(file, colname, spec)

  starttimes <-list()
  for(i in 1:(length(glist)-1))
  {
    time1 <- date_time(file, as.numeric(glist[i]))
    time2 <- date_time(file, as.numeric(glist[i+1]))
    difference <- difftime(time2,
                           time1,
                           units="mins")

    if (as.numeric(difference) > 30)
    {
      starttimes[i] <- glist[i+1]
    }
  }

  starttimes <- c(glist[1], starttimes)
  starttimes <- starttimes[!unlist(lapply(starttimes, is.null))]
  starttimes <- as.numeric(starttimes)

  starttimes
}
