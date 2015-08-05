#q1
q1=read.table("./data/getdata-data-ss06hid.csv",sep=",",header=TRUE)
ind_cev=which(q1$ACR==3 & q1$AGS==6)

#q2
library(jpeg)
jeff=readJPEG("./data/getdata-jeff.jpg",native=TRUE)
quantile(jeff, probs = c(0.3, 0.8) )

#q3
q3a=read.csv("./data/getdata-data-GDP.csv",header=FALSE, skip=5,nrows=190)
q3b=read.csv("./data/getdata-data-EDSTATS_Country.csv",header=TRUE)
length(intersect(q3a$V1,q3b$CountryCode))
data=merge(x=q3a,y=q3b,by.x="V1",by.y="CountryCode")
data=data[order(data$V2,decreasing=TRUE),]

#q4
mean(data[data$Income.Group=='High income: OECD',]$V2)
mean(data[data$Income.Group=='High income: nonOECD',]$V2)

#q5

q <- quantile(data$V2, seq(0,1,1/5))
q1 <- data$V2 <= 38

xtabs(q1 ~ data$Income.Group)
length(which(data$Income.Group=="Lower middle income" & data$V2 <= 38))
