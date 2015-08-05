####Reading from MySQL
library(RMySQL)
# http://genome.ucsc.edu/goldenPath/help/mysql.html
#Access database
ucscDb <- dbConnect(MySQL(),user="genome", 
                    host="genome-mysql.cse.ucsc.edu")
#Get list of datatables in the database
result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb);
#Make connection for hg19
hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
#show table in datatable hg19
allTables <- dbListTables(hg19)
length(allTables)
head(allTables)

#variable names
dbListFields(hg19,"affyU133Plus2")

affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)


query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)

affyMisSmall <- fetch(query,n=10)
dbClearResult(query);

dim(affyMisSmall)

dbDisconnect(hg19)


## Reading HDF5
#Heirarchical data format
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created=h5createFile("example.h5")
created=h5createGroup("example.h5","foo")
created=h5createGroup("example.h5","baa")
created=h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

A= matrix(1:10,nr=5,nc=2)
h5write(A,"example.h5","foo/A")
B=array(seq(.1,2,by=.1),dim=c(2,2))
attr(B,"scale") <-"liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")

df=data.frame(1L:5L,seq(0,1,length.out=5),
              c("ab","cde","fghi","a","s"),stringsAsFactors=FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

readA=h5read("example.h5","foo/A")

##Reading Date from the Web
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html, "//title", xmlValue)

xpathSApply(html, "//td[@id='col-citedby']", xmlValue)


library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2


google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")


##Reading from APIs, application programming interfaces
library(httr)
myapp = oauth_app("twitter",
                  key="1YTM43k7Ti6cf5b4oP7Yq3lSY ",secret="FuivKymjbXtj0L7eXqzdIlMFZWM32VjeRhevPZFSIgKr0TirqR")
sig = sign_oauth1.0(myapp,
                    token = "3240115562-j6SCKEF8rFe8yFHGmQ837q6k72XSREDeDQIVOW5",
                    token_secret = "PdDbF4xyQm1oDuYVqssaJhS6ZE2L3CLDewE0E4GTH654w")

homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
library(jsonlite)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]
