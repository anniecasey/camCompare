library(readxl)
library(lubridate)

## SPECIFIC COLUMN TYPES FOR METADATA_2013
cols <- c("text", "text", "text", "text", "text", "text", "text", "date", "date",
          "text", "text", "text", "text", "numeric", "numeric", "numeric", "numeric",
          "numeric", "numeric")
METADATA_2013      <- read_excel("~/Desktop/Lajuma Project/Data/METADATA 2013.xlsx",
                                 col_types = cols)

All_Visit_Activity <- read_excel("~/Desktop/Lajuma Project/Data/All - Visit Activity.xlsx",
                                 col_types = "list")

# fix METADATA_2013 due to NA in "Station" column
# METADATA_2013[327143:331234, "Station"] <- "14TOLO"
# METADATA_2013[331235:335324, "Station"] <- "16TOLO"
# METADATA_2013[335325:336159, "Station"] <- "18TOLO"
# METADATA_2013[336160:338528, "Station"] <- "20TOLO"

METADATA_2013[,"Year"]   <- as.numeric(METADATA_2013$Year)
METADATA_2013[,"Month"]  <- as.numeric(METADATA_2013$Month)
METADATA_2013[,"Day"]    <- as.numeric(METADATA_2013$Day)
METADATA_2013[,"Hour"]   <- as.numeric(METADATA_2013$Hour)
METADATA_2013[,"Minute"] <- as.numeric(METADATA_2013$Minute)
METADATA_2013[,"Second"] <- as.numeric(METADATA_2013$Second)

METADATA_2013[,"Station"] <- as.character(METADATA_2013$Station)
# Create EZtable formats
laj <- EZtable(METADATA_2013,
               "Station", "Species01",
               c(colnames(METADATA_2013)))
all <- betterTime(All_Visit_Activity,
                  "Start.Date", "Start.Time",
                  dsep = "/", tsep = ":")
all <- EZtable(all, "Field", "Species")

# Edit METADATA_2013 to match date range of All_Visit_Activity
new_laj <- sameRange(laj, all)

# Sort edited METADATA_2013 into species visits according to station
laj <- sortKing(new_laj,
                "Station", "Species01",
                "Moon Phase", "Temperature")

#library(xlsx)
#write.xlsx(x = laj, file = "lajuma_visits.xlsx")



