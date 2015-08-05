# source("http://d396qusza40orc.cloudfront.net/rprog%2Fscripts%2Fsubmitscript3.R")
source("submitscript3.R")
# submit
hospital=read.csv(file="./hospital-data.csv")

# problem 1
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])
# problem 2: finding the best hospitals in a state
source("best.R")
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

# problem 3: ranking hospitals by outcome in a state

# problem 4: ranking hospitals in all states




