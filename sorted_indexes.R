#' Sort Indexes
#'
#' Sorts camera trap indexes according to input species
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
#' sorted_indexes(file     = example_dataset,
#'                colname  = "Species01",
#'                spec     =  "warthog")
#'
#' @export

sorted_indexes <- function(file, colname, spec) {

# list of indexes, according to file, matching specified species
  grep(pattern = spec,
       x = file[[colname]],
       fixed = TRUE)

}
