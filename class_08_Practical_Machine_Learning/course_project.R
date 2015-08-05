library(zoo)
library(AppliedPredictiveModeling)
library(caret)
library(Hmisc)
library(Rcpp)
library(ggplot2)
library(rpart)
library(randomForest)
data=read.csv("./pml-training.csv")
data=data[,-1]
final_test=read.csv("./pml-testing.csv")
final_test=final_test[,-1]

#identify variables in the testing set with only missing values
NA_cols=apply(final_test,2,function(x){sum(is.na(x))==length(x)})
NA_vars=names(final_test)[NA_cols]

#remove those from both datasets
data=data[,!(names(data) %in% NA_vars)]

################################
# Cleaning
#################################
n_nums=sapply(data,is.numeric)
data[,n_nums]=na.approx(data[,n_nums])


#drop low variance variables
NZV=nearZeroVar(data, saveMetrics=TRUE)
poor_var=which(NZV$nzv)
rm_vars=c(which(names(data)=="cvtd_timestamp"),poor_var)
data=data[,-rm_vars]

classe_ind=which(names(data)=="classe")
n_nums=which(sapply(data,is.numeric))
data2=na.omit(data[,c(n_nums,classe_ind)])




inTrain = createDataPartition(y=data2$classe, p = .6)[[1]]
training = data2[ inTrain,]
testing = data2[-inTrain,]


# modFit <- train(classe ~ ., method = "rpart", data = training)

# modFit <- rpart(classe ~ ., data=training, method="class")
modFit <- randomForest(classe ~. , data=training)

pred=predict(modFit,newdata= training, type = "class")
confusionMatrix(training$classe, pred)
pred=predict(modFit, testing, type = "class")
confusionMatrix(testing$classe,pred)



###################################
# apply to true test set
########################
#first clean in the same way

final_test=final_test[,!(names(final_test) %in% NA_vars)]
################################
# Cleaning
#################################
n_nums=sapply(final_test,is.numeric)
final_test[,n_nums]=na.approx(final_test[,n_nums])



#drop low variance variables
#same variables dropped as before
final_test=final_test[,-rm_vars]


n_nums=which(sapply(final_test,is.numeric))
final_test=final_test[,c(n_nums)]


pred=predict(modFit,newdata= final_test, type = "class")

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(pred)


