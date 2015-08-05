library(AppliedPredictiveModeling)
library(caret)
library(Hmisc)

#q1
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]


#q2
data(concrete)
set.seed(975)

inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]


splitOn <- cut2(training$Age, g = 4)

splitOn <- mapvalues(splitOn, 
                     from = levels(factor(splitOn)), 
                     to = c("red", "blue", "yellow", "green"))


# automatically includes index of samples
plot(training$CompressiveStrength, col = splitOn)

# Answer: There is a step-like pattern in the plot of outcome versus index in 
# the training set that isn't explained by any of the predictor variables so 
# there may be a variable missing.


#q3
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

ggplot(data = training) + geom_histogram(aes(x = Superplasticizer))+theme_bw()
ggplot(data = training) + geom_histogram(aes(x = log(Superplasticizer+1)))+theme_bw()



#q4
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

IL_variables <- grep("^IL", names(training), value = TRUE)
preProc <- preProcess(training[, IL_variables], method = "pca", thresh = 0.9)
preProc





#q5
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]



## grep the predictors starting with 'IL'
IL_str <- grep("^IL", colnames(training))
training=training[,c(1,IL_str)]
testing=testing[,c(1,IL_str)]


## train the data using the first method
modelFit <- train(diagnosis ~ ., method = "glm", data = training)


predictions <- predict(modelFit, newdata = testing)

## get the confusion matrix for the first method
C1 <- confusionMatrix(predictions, testing$diagnosis)
print(C1$overall[1])


## do similar steps with PCA

# preObj=preProcess(training[,-1],method=c("pca"),preProcOptions=list(thresh=.8))
# trainPC=predict(preObj,training[,-1])
# modelFit_pca <- train(training$diagnosis ~ ., method = "glm", data = trainPC)

modelFit_pca <- train(training$diagnosis ~ ., method = "glm", data = training,
                  preProcess = "pca", 
                  trControl=trainControl(preProcOptions=list(thresh=0.8)))

C2 <- confusionMatrix(testing$diagnosis, predict(modelFit_pca, testing))
print(C2$overall[1])

