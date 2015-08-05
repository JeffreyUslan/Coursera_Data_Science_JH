#downloading files
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")
list.files("./data")

#reading local files
cameras=read.table("./data/cameras.csv",sep=",",header=TRUE)

#reading excel files
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.xlsx",mode="wb")

library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,header=TRUE)
head(cameraData)


#Reading xml files
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
xmlSApply(rootNode,xmlValue)
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)

#reading html files
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams

#Reading JSON files
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/JeffreyUslan/repos")
names(jsonData)

names(jsonData$owner)
jsonData$owner$login

#convert to and from JSON format
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)




