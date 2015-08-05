

# q1
library(caret)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 

vowel.train$y=as.factor(vowel.train$y)
vowel.test$y=as.factor(vowel.test$y)
set.seed(33833)

modRF=train(y~.,data=vowel.train,method="rf",prox=TRUE)
predRf=predict(modRF,newdata=vowel.test)
confusionMatrix(vowel.test$y,predRf)


modgbm=train(y~.,data=vowel.train,method="gbm",verbose=FALSE)
predGBM=predict(modgbm,newdata=vowel.test)
confusionMatrix(vowel.test$y,predGBM)


pred <- data.frame(predRf, predGBM, y=vowel.test$y, agree=predRf == predGBM)

accuracy <- sum(predRf[pred$agree] == pred$y[pred$agree]) / sum(pred$agree)
accuracy



#q2
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
set.seed(62433)
fitRf <- train(diagnosis ~ ., data=training, method="rf")
fitGBM <- train(diagnosis ~ ., data=training, method="gbm")
fitLDA <- train(diagnosis ~ ., data=training, method="lda")
predRf <- predict(fitRf, testing)
predGBM <- predict(fitGBM, testing)
predLDA <- predict(fitLDA, testing)
pred <- data.frame(predRf, predGBM, predLDA, diagnosis=testing$diagnosis)

fit <- train(diagnosis ~., data=pred, method="rf")
predFit <- predict(fit, testing)
c1 <- confusionMatrix(predRf, testing$diagnosis)$overall[1]
c2 <- confusionMatrix(predGBM, testing$diagnosis)$overall[1]
c3 <- confusionMatrix(predLDA, testing$diagnosis)$overall[1]
c4 <- confusionMatrix(predFit, testing$diagnosis)$overall[1]
print(paste(c1, c2, c3, c4)) 


#q3
set.seed(3523)
library(AppliedPredictiveModeling)
library(elasticnet)
data(concrete)
inTrain <- createDataPartition(concrete$CompressiveStrength, 
                               p=3/4)[[1]]
training <- concrete[inTrain, ]
testing <- concrete[-inTrain, ]
set.seed(233)
fit <- train(CompressiveStrength ~ ., data=training, method="lasso")
fit
plot.enet(fit$finalModel, xvar="penalty", use.color=T) # Cement


#q4
library(lubridate)  
library(forecast)
dat <- read.csv("./gaData.csv")
training <- dat[year(dat$date) < 2012, ]
testing <- dat[(year(dat$date)) > 2011, ]
tstrain <- ts(training$visitsTumblr)
fit <- bats(tstrain)
fit
pred <- forecast(fit, level=95, h=dim(testing)[1])
names(data.frame(pred))
predComb <- cbind(testing, data.frame(pred))
names(testing)
names(predComb)
predComb$in95 <- (predComb$Lo.95 < predComb$visitsTumblr) & 
  (predComb$visitsTumblr < predComb$Hi.95)

prop.table(table(predComb$in95))[2] 


#Q5
set.seed(3523)
library(AppliedPredictiveModeling)
library(e1071)
data(concrete)
inTrain <- createDataPartition(concrete$CompressiveStrength, p=3/4)[[1]]
training <- concrete[inTrain, ]
testing <- concrete[-inTrain, ]
set.seed(325)
fit <- svm(CompressiveStrength ~., data=training)

pred <- predict(fit, testing)
acc <- accuracy(pred, testing$CompressiveStrength)
acc

