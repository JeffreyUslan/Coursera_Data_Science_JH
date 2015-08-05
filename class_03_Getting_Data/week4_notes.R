#Editing Text Variables
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

tolower(names(cameraData)) 

splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]

splitNames[[6]]

mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews.csv")
download.file(fileUrl2,destfile="./data/solutions.csv")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)

sub("_","",names(reviews),)

grep("Alameda",cameraData$intersection)

table(grepl("Alameda",cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),] 

library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek",1,7)
paste0("Jeffrey","Leek")
str_trim("Jeff      ")


#Working with Dates
d1 = date()
d2 = Sys.Date()
format(d2,"%a %b %d")
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%Y")
as.numeric(z[1]-z[2])
weekdays(d2)
months(d2)
julian(d2)

library(lubridate)
ymd("20140108")
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
Sys.timezone()
