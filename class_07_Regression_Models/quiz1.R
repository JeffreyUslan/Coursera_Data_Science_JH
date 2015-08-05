#q1
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)

sum(x * w)/sum(w)


# q2

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)


lm(y~x+0)



# q3
data(mtcars)
mtcars=mtcars


lm(mpg~wt ,data=mtcars)


# q4
# Consider data with an outcome (Y) and a predictor (X). 
# The standard deviation of the predictor is one half that of the outcome. 
# The correlation between the two variables is .5. 
# What value would the slope coefficient for the regression model 
# with Y as the outcome and X as the predictor?

# B_1=cor(Y,x)*(sd(Y)/sd(X))
.5*(1/.5)

# q5
# Students were given two hard tests and scores were normalized to have empirical mean 0 and variance 1.
# The correlation between the scores on the two tests was 0.4. 
# What would be the expected score on Quiz 2 for a student who had a normalized score of 1.5 on Quiz 1?

b_1=.4*(1/1)
pred=0+1.5*b_1
pred



# q6

x <- c(8.58, 10.46, 9.01, 9.64, 8.86)

# What is the value of the first measurement if x were normalized (to have mean 0 and variance 1)?
(x-mean(x))/sd(x)


# q7
# Consider the following data set (used above as well). 
# What is the intercept for fitting the model with x as the predictor and y as the outcome?

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

lm(y~x)


# q8
# You know that both the predictor and response have mean 0.
# What can be said about the intercept when you fit a linear regression?

# B_0=mean(y)-B_1*mean(x)

# It must be identically 0.


# q9

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
# What value minimizes the sum of the squared distances between these points and itself?
mean(x)


# q10

# Let the slope having fit Y as the outcome and X as the predictor be denoted as β1. 
# Let the slope from fitting X as the outcome and Y as the predictor be denoted as γ1. 
# Suppose that you divide β1 by γ1; 
# in other words consider β1/γ1. What is this ratio always equal to?

β1=cor(y,x)*(sd(y)/sd(x))
γ1=cor(x,y)*(sd(x)/sd(y))

β1/γ1=cor(y,x)*(sd(y)/sd(x))  /  cor(x,y)*(sd(x)/sd(y))

Var(Y)/Var(X)








