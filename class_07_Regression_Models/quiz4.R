# q1
# Consider the space shuttle data ?shuttle in the MASS library. 
# Consider modeling the use of the autolander as the outcome (variable name use). 
# Fit a logistic regression model with autolander (variable auto) 
# use (labeled as "auto" 1) versus not (0) as predicted by wind sign (variable wind). 
# Give the estimated odds ratio for autolander use comparing head winds, 
# labeled as "head" in the variable headwind (numerator) to tail winds (denominator).
library(MASS)
data(shuttle)
shuttle=shuttle
summary(shuttle)
shuttle$wind=as.factor(shuttle$wind)
shuttle$use <- as.numeric(shuttle$use == "auto")
table(shuttle$wind,shuttle$use)
q1_fit=glm(use ~ wind+0, data = shuttle,family="binomial")
exp_coef=exp(summary(q1_fit)$coef)
exp_coef[1]/exp_coef[2]


# q2
# Consider the previous problem. 
# Give the estimated odds ratio for autolander use comparing head winds (numerator) 
# to tail winds (denominator) adjusting for wind strength from the variable magn.
q2_fit=glm(use ~ wind+magn+0, data = shuttle,family="binomial")
exp_coef=exp(summary(q2_fit)$coef)
exp_coef[1]/exp_coef[2]


# q4
# Consider the insect spray data InsectSprays. 
# Fit a Poisson model using spray as a factor level. 
# Report the estimated relative rate comapring spray A (numerator) to spray B (denominator).

data(InsectSprays)
InsectSprays=InsectSprays
summary(InsectSprays)
q4_fit=glm(count~spray+0,family="poisson",data=InsectSprays)
exp_coef=exp(coef(q4_fit))
exp_coef[1]/exp_coef[2]






# q6
# Consider the data

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
# Using a knot point at 0, fit a linear model that looks like a hockey stick 
# with two lines meeting at x=0. Include an intercept term, x and the knot point term. 
# What is the estimated slope of the line after 0?
knots <- 0
spline <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMatrix <- cbind(1, x, spline)
q6_fit <- lm(y ~ xMatrix +0)
pred <- predict(q6_fit)
plot(x, y)
lines(x, pred, col=2)

 coef(q6_fit)[1]+coef(q6_fit)[2]
coef(q6_fit)[2]+coef(q6_fit)[3]


