
final_start <- function(file, colname)
{
  list <- unique(species_list(file, colname))
  # Applies start_time function to list of species (Creates 1 big list of start time indexes)
  multi_start_lists <- tapply(list, 1:length(list), start_times, file = file, colname = colname)
  start_list <- sort(unique(unlist(multi_start_lists)))

}


final_end <- function(file, colname)
{
  list <- unique(species_list(file, colname))
  # Applies end_time function to list of species (Creates 1 big list of end time indexes)
  multi_end_lists <- tapply(list, 1:length(list), end_times, file = file, colname = colname)
  end_list <- sort(unique(unlist(multi_end_lists)))
}


