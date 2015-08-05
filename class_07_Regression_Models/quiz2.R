#q1

# Consider the following data with x as the predictor and y as as the outcome.

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
# Give a P-value for the two sided hypothesis test of whether β1 from a linear regression model is 0 or not.
q1_model=lm(y~x)
summary(q1_model)

# q2
sqrt(deviance(q1_model)/df.residual(q1_model))


# q3
# In the mtcars data set, fit a linear regression model of weight (predictor) on mpg (outcome). 
# Get a 95% confidence interval for the expected mpg at the average weight. 
# What is the lower endpoint?

data(mtcars)
mtcars=mtcars

q3_model=lm(mpg~ wt,data=mtcars)
predict(q3_model,newdata=data.frame(wt=mean(mtcars$wt)),interval = ("confidence"))

# q4
# Refer to the previous question. Read the help file for mtcars. What is the weight coefficient interpreted as?
# The estimated expected change in mpg per 1,000 lb increase in weight.

# q5
# Consider again the mtcars data set and a linear regression model with mpg 
# as predicted by weight (1,000 lbs). A new car is coming weighing 3000 pounds. 
# Construct a 95% prediction interval for its mpg. What is the upper endpoint?
predict(q3_model,newdata=data.frame(wt=3),interval = ("prediction"))


# q6
# Consider again the mtcars data set and a linear regression model 
# with mpg as predicted by weight (in 1,000 lbs). 
# A “short” ton is defined as 2,000 lbs. 
# Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight. 
# Give the lower endpoint.
q6_model <- lm(mpg ~ I(wt / 2),data=mtcars)
tbl <- summary(q6_model)$coefficients
mean <- tbl[2,1]      
se <- tbl[2,2] 
df <- q6_model$df
#Two sides T-Tests
mean + c(-1,1) * qt(0.975, df=df) * se



# q7
# If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?
# It would get multiplied by 100


# q9
fitRes <- q3_model$residuals ^ 2
fitIntercept <- lm(mpg ~ 1, mtcars)
fitInterceptRes <- fitIntercept$residuals ^ 2
sum(fitRes) /sum(fitInterceptRes)

