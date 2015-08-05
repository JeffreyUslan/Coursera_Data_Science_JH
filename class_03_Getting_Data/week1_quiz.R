#q1
q1=read.table("./data/getdata-data-ss06hid.csv",sep=",",header=TRUE)
summary(q1$VAL)
length(which(q1$VAL>=24))


#q2
#see data dictionary

#q3
dat <- read.xlsx("./data/getdata-data-DATA.gov_NGAP.xlsx",
                 sheetIndex=1,header=TRUE,
                 startRow=18,endRow=23)[,7:15]
sum(dat$Zip*dat$Ext,na.rm=T) 

#q4
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile="./localFile.xml", quiet=T)
doc <- xmlTreeParse("./localFile.xml", useInternal=T)
rootNode <- xmlRoot(doc)
zips=xpathSApply(rootNode,"//zipcode",xmlValue)
length(which(zips=="21231"))


#q5
fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/q5.csv")
# q5=read.table("./data/q5.csv",sep=",",header=TRUE)
DT=fread("./data/q5.csv")
DT[,mean(pwgtp15),by=SEX]


