library(ggplot2)
library(dplyr)
library(tidyr)
library(datasets)
library(reshape)

data(ToothGrowth)
toothGrowth=ToothGrowth
toothGrowth=tbl_df(toothGrowth)
toothGrowth$dose=as.factor(toothGrowth$dose)

# 1. Load the ToothGrowth data and perform some basic exploratory data analyses 
str(toothGrowth)

ggplot(data=toothGrowth)+theme_bw()+geom_density(aes(x=len))
ggplot(data=toothGrowth)+theme_bw()+geom_density(aes(x=len,color=supp))
ggplot(data=toothGrowth)+theme_bw()+geom_density(aes(x=len,color=supp))+facet_grid(dose~.)
ggplot(data=toothGrowth)+theme_bw()+geom_density(aes(x=len,color=dose))
ggplot(data=toothGrowth)+theme_bw()+geom_density(aes(x=len,color=dose))+facet_grid(supp~.)

# 2. Provide a basic summary of the data.
summary(toothGrowth)
table(toothGrowth$supp,toothGrowth$dose)

toothGrowth %>% group_by(supp) %>% summarise(min(len),mean(len),max(len))
toothGrowth %>% group_by(dose) %>% summarise(min(len),mean(len),max(len))



# 3. Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. 
# (Only use the techniques from class, even if there's other approaches worth considering)

ind_.5=which(toothGrowth$dose==.5)
conf_.5=t.test(x = toothGrowth$len[ind_.5])$conf.int[1:2]
conf_.5
ind_1=which(toothGrowth$dose==1)
conf_1=t.test(x = toothGrowth$len[ind_1])$conf.int[1:2]
conf_1
ind_2=which(toothGrowth$dose==2)
conf_2=t.test(x = toothGrowth$len[ind_2])$conf.int[1:2]
conf_2



OJ_ind=which(toothGrowth$supp=="OJ")
oj_conf=t.test(x = toothGrowth$len[OJ_ind])$conf.int[1:2]
oj_conf
vc_conf=t.test(x = toothGrowth$len[-OJ_ind])$conf.int[1:2]
vc_conf
t.test(x = toothGrowth$len[OJ_ind], y = toothGrowth$len[-OJ_ind], alt = "two.sided", paired = T)





