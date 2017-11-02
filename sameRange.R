## Create subset of file1 to match the date range of file2
### Must be in EZtable format

sameRange <- function(EZtable1, EZtable2)
{
  min <- min(EZtable2$EZ_Date)
  max <- max(EZtable2$EZ_Date)

  modified <- EZtable1[EZtable1$EZ_Date > min & EZtable1$EZ_Date < max,]

}

