# q1
# What is the variance of the distribution of the average an IID draw of n observations
# from a population with mean μ and variance σ2.


# s^2/n


#q2

# Suppose that diastolic blood pressures (DBPs) for men aged 35-44 are normally distributed
# with a mean of 80 (mm Hg) and a standard deviation of 10. About what is the probability 
# that a random 35-44 year old has a DBP less than 70?
mu=80
sd=10
targ=70
pnorm(targ,mu,sd)


#q3

# Brain volume for adult women is normally distributed with a mean of about 1,100 cc 
# for women with a standard deviation of 75 cc. What brain volume represents the 95th percentile?
mu=1100
sd=75
pc=.95
qnorm(pc,mu,sd)

#q4
# Refer to the previous question. Brain volume for adult women is about 1,100 cc
# for women with a standard deviation of 75 cc. Consider the sample mean of 100 
# random adult women from this population. 
# What is the 95th percentile of the distribution of that sample mean?
quan=.95
n=100
SE <- sd/sqrt(n)
qnorm(quan,mu,SE)

#q5
# You flip a fair coin 5 times, about what's the probability of getting 4 or 5 heads?
(choose(5,4)+choose(5,5))/2^5


#q6
# The respiratory disturbance index (RDI), a measure of sleep disturbance, 
# for a specific population has a mean of 15 (sleep events per hour) and a standard deviation of 10.
# They are not normally distributed. 
# Give your best estimate of the probability that a sample 
# mean RDI of 100 people is between 14 and 16 events per hour?

mean=15
sd=10
n=100
SE=sd/sqrt(n)

ul=16
ll=14
pnorm(ul,mean,SE)-pnorm(ll,mean,SE)


#q7

# Consider a standard uniform density. 
# The mean for this density is .5 and the variance is 1 / 12. 
# You sample 1,000 observations from this distribution and take the sample mean, 
# what value would you expect it to be near?
mean=.5
sd=1/sqrt(12)
n=1000
SE=sd/sqrt(n)
qnorm(.5,mean,SE)


#q8
# The number of people showing up at a bus stop is assumed to be 
# Poisson with a mean of 5 people per hour. 
# You watch the bus stop for 3 hours. 
# About what's the probability of viewing 10 or fewer people?
mean=5
t=3
sd=sqrt(mean)
ppl=10
ppois(ppl,mean*t)













