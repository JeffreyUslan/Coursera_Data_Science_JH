

#q1
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
data=segmentationOriginal

#1. Subset the data to a training set and testing set based on the
# Case variable in the data set. 
testIndex=which(data$Case == "Train")
training = data[testIndex,]
testing = data[!testIndex,]

# 2. Set the seed to 125 and fit a CART model with the rpart method using all
# predictor variables and default caret settings. 
set.seed(125)
modFit=train(Class~.,method="rpart",data=training)
modFit$finalModel
# plot(modFit$finalModel,uniform=TRUE)
# text(modFit$finalModel,use.n=TRUE,all=TRUE)
# 3. In the final model what would be the final model prediction for cases with the following variable values:
#   a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2 
# PS
# b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100 
# WS
# c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100 
# PS
# d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2 
#not possible


#q2
# If K is small in a K-fold cross validation is the bias in the estimate 
# of out-of-sample (test set) accuracy smaller or bigger? 
# If K is small is the variance in the estimate of out-of-sample (test set) 
# accuracy smaller or bigger. 
# Is K large or small in leave one out cross validation?


#q3
library(pgmm)
data(olive)
olive = olive[,-1]
# These data contain information on 572 different Italian olive oils from
# multiple regions in Italy. Fit a classification tree where Area is the
# outcome variable. Then predict the value of area for the following 
# data frame using the tree command with all defaults
treeModel <- train(Area ~ ., data=olive, method="rpart")

newdata = as.data.frame(t(colMeans(olive)))
predict(treeModel, newdata)

#q4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)
fitModel <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl,
                   data=trainSA, method="glm",family="binomial")

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

missClass(trainSA$chd, predict(fitModel,trainSA)) 
# Test Set Misclassification rate
missClass(testSA$chd, predict(fitModel,testSA)) 


#q5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

vowel.train$y=as.factor(vowel.train$y)
vowel.test$y=as.factor(vowel.test$y)
set.seed(33833)

modFit=train(y~.,data=vowel.train,method="rf",prox=TRUE)
varImp(modFit)

