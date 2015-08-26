# q1
# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that includes number of cylinders as a factor variable 
# and weight as confounder. 
# Give the adjusted estimate for the expected change in mpg comparing 8 cylinders to 4.

data(mtcars)
mtcars=mtcars
mtcars$cyl=as.factor(mtcars$cyl)
levels(mtcars$cyl)
q1_fit=lm(mpg~cyl+wt,data=mtcars)


# q2

# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that includes number of cylinders as a factor variable 
# and weight as a possible confounding variable. 
# Compare the effect of 8 versus 4 cylinders on mpg for the adjusted and unadjusted by weight models. 
# Here, adjusted means including the weight variable as a term in the regression model 
# and unadjusted means the model without weight included. 
# What can be said about the effect comparing 8 and 4 cylinders after looking at models 
# with and without weight included?.
q2_fit=lm(mpg~cyl,data=mtcars)


q1_fit
q2_fit
# Holding weight constant, cylinder appears to have more of an impact on mpg than if weight is disregarded.


# q3
# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that considers number of cylinders as a factor variable 
# and weight as confounder. 
# Now fit a second model with mpg as the outcome model that considers 
# the interaction between number of cylinders (as a factor variable) and weight. 
# Give the P-value for the likelihood ratio test comparing the two models and 
# suggest a model using 0.05 as a type I error rate significance benchmark.

q3_fit=lm(mpg~cyl*wt,data=mtcars)
summary(q3_fit)
result <- anova(q1_fit, q3_fit, test="Chi")
result

# The P-value is larger than 0.05. So, according to our criterion, we would fail to reject, 
# which suggests that the interaction terms may not be necessary.


# q4
# Consider the mtcars data set. Fit a model with mpg as the outcome that includes number of cylinders 
# as a factor variable and weight inlcuded in the model as

lm(mpg ~ I(wt * 0.5) + cyl, data = mtcars)
# How is the wt coefficient interpretted?

# The estimated expected change in MPG per half ton increase in weight for for a specific number of cylinders (4, 6, 8).


# q5
# Consider the following data set

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# Give the hat diagonal for the most influential point
plot(x,y)
max(hatvalues(lm(y~x)))


# q6
# Consider the following data set

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# Give the slope dfbeta for the point with the highest hat value.
highest_hat=as.integer(which(hatvalues(lm(y~x))==max(hatvalues(lm(y~x)))))
dfbetas(lm(y~x))[highest_hat,]

# q7

# Consider a regression relationship between Y and X with and without adjustment 
# for a third variable Z. 
# Which of the following is true about comparing the regression coefficient 
# between Y and X with and without adjustment for Z.

# It is possible for the coefficient to reverse sign after adjustment. For example, it can be strongly significant and positive before adjustment and strongly significant and negative after adjustment.


