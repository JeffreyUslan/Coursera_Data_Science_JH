library(ggplot2)
library(tidyr)
library(zoo)
library(dplyr)

# Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?

# Across the United States, which types of events have the greatest economic consequences?

storm <- read.csv(bzfile("repdata-data-StormData.csv.bz2"))
storm <- tbl_df(storm)
storm
summary(storm)
names(storm)

class(storm$EVTYPE)
