---
title: "Code Book"
author: "Jeffrey Uslan"
date: "Monday, June 15, 2015"
output: html_document
---

1. Merges the training and the test sets to create one data set.

```{r}
#Reading in the features
X_train=read.table("./data/UCI HAR Dataset/train/X_train.txt")
X_test=read.table("./data/UCI HAR Dataset/test/X_test.txt")
X=rbind(X_train,X_test)

#Reading in the activiy indicators
y_train=read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test=read.table("./data/UCI HAR Dataset/test/y_test.txt")
y=rbind(y_train,y_test)

#Reading in the subject indicators
subject_train=read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test=read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subject=rbind(subject_train,subject_test)

data=cbind(y,subject,X)

```

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

```{r}

features=read.table("./data/UCI HAR Dataset/features.txt")
#grepping mean values
mean_features=grep("mean",features[,2])
#grepping standard deviation values
std_features=grep("std",features[,2])
keep_inds=c(mean_features,std_features)

data=data[c(1,2,keep_inds+2)]
```




3.  Uses descriptive activity names to name the activities in the data set
```{r}
activity_labels=read.table("./data/UCI HAR Dataset/activity_labels.txt")
class(data[,1])="character"
for (i in 1:nrow(activity_labels)) {
  ind=as.character(activity_labels[i,1])
  replacement=as.character(activity_labels[i,2])
  rep_ind=which(data[,1]==ind)
  data[rep_ind,1]=replacement
}
```


4.  Appropriately labels the data set with descriptive variable names. 
```{r}
feat_names=as.character(features[keep_inds[order(keep_inds)],2])
names(data)=c("Activity","Subject",feat_names)
```


5. From the data set in step 4, creates a second, 
 independent tidy data set with the average of each variable for each activity and each subject.
```{r}
library(dplyr)
data2=tbl_df(data)
tidy_set=data2 %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))
write.table(tidy_set,file="./data/final_project.txt",row.name=FALSE) 
```