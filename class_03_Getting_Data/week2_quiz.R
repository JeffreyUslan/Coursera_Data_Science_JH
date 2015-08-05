#q1
# Register an application with the Github API here https://github.com/settings/applications.
# Access the API to get information on your instructors repositories 
# (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. What time was it created? 
# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.
library(httr)
library(httpuv)
library(curl)
oauth_endpoints("github")
# 51191f604af65b0544324f3beb915e61b8eeb336
myapp <- oauth_app("github",
                   "c5fe1ed743e57cb22599",
                   "2e9fe3c75b6212c66ae247125c05ae2e4eeb62b9")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)

BROWSE("https://api.github.com/users/jtleek/repos",authenticate("Access Token","x-oauth-basic","basic"))
# CTRL_F "datasharing"
# "created_at": "2013-11-07T13:25:07Z"


#q2
# The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might 
# send with the dbSendQuery command in RMySQL. 
# Download the American Community Survey data and load it into an R object called
library(sqldf)
acs <- read.csv("./data/getdata-data-ss06pid.csv", header=T, sep=",")
sqldf("select pwgtp1 from acs where AGEP < 50")

#q3
# Using the same data frame you created in the previous problem, 
# what is the equivalent function to unique(acs$AGEP)
a=unique(acs$AGEP)
b=sqldf("select distinct AGEP from acs")

#q4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:   
#   http://biostat.jhsph.edu/~jleek/contact.html 
# (Hint: the nchar() function in R may be helpful)
hurl <- "http://biostat.jhsph.edu/~jleek/contact.html" 
con <- url(hurl)
htmlCode <- readLines(con)
close(con)
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

#q5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns. 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
data <- read.csv("./data/getdata-wksst8110.for")
head(data)
data <- read.fwf("./data/getdata-wksst8110.for",widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
sum(data[,4])

