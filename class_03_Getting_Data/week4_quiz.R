
#q1
q1=read.csv("./data/getdata-data-ss06hid.csv")
strsplit(names(q1),"wgtp")[[123]]


#q2
q2=read.csv("./data/getdata-data-GDP.csv",header=FALSE, skip=5,nrows=190)
head(q2$V5)
this=q2$V5
this=sapply(this,function(x) x=str_trim(x))
this=sapply(this,function(x) x=sub(",","",x))
mean(as.numeric(this))


#q3
countryNames=q2$V4
grep("^United",countryNames)
length(grep("^United",countryNames))


#q4
q4=read.csv("./data/getdata-data-EDSTATS_Country.csv",header=TRUE)
table(apply(q4,2,class))
q4=apply(q4,2,str_trim)
data=merge(x=q2,y=q4,by.x="V1",by.y="CountryCode")
fis_notes=grep("[Ff]isc",data$Special.Notes)
fisc_June=grep("[Jj]une",data$Special.Notes[fis_notes])
length(fisc_June)
data$Special.Notes[fis_notes][fisc_June]


#q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
length(grep("2012",sampleTimes))
length(grep("Mon",weekdays(sampleTimes[grep("2012",sampleTimes)])))




