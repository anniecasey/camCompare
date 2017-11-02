#' Adding to Dataset
#'
#' Adds column for properly formatted datetime, and column for ST.Dec
#'
#' @param file The metadata file containing your camera trap data. NOTE: Make sure your file has the following columns: "Year", "Month", "Day", "Hour", "Minute", "Second"
#'
#'
#' @author Annie Casey, \email{annie.casey15@gmail.com}
#' @keywords metadata species indexes
#'
#'
#' @examples
#'
#' @export

add_columns <- function(file, colname)
{

  start_list <- final_start(file, colname)
    end_list <- final_end(file, colname)

  df <- as.data.frame(file)
  df$Species <- species_list(file, colname)
  df$Date_and_Time <- date_time(file, 1:nrow(file))

  timecol <- list()
  for (i in 1:nrow(file))
  {
    datetimes <- date_time(file, 1:nrow(file))
    timecol[i] <- decimate_time(datetimes[i])

  }
  df$ST.Dec <- as.numeric(timecol)

  endtimes_data <- df[end_list, "Date_and_Time"]       # List of Datetimes according to indexes

  new_dataset <- df[start_list, c("Species", "Date_and_Time", "ST.Dec")]         # dataframe according to indexes

  new_dataset$End_Time <- endtimes_data
  new_dataset
}

# Save into new excel file
# library(xlsx)
# write.xlsx(x = new_dataset, file = "43_Species_Visits(2013).xlsx")
