## file = original raw data

# Creates decimal format based on 24 hour days
# file must contain separate "Hour", "Minute", and "Second" columns
decimate_time <- function(file)
{
  (file$Hour*3600 + file$Minute*60 + file$Second)/86400
}
