# q1

# Consider influenza epidemics for two parent heterosexual families. 
# Suppose that the probability is 17% that at least one of the parents has contracted the disease.
# The probability that the father has contracted influenza is 12%
# while the probability that both the mother and father have contracted the disease is 6%. 
# What is the probability that the mother has contracted influenza?
p_one_parent_or_more=.17
p_father=.12
p_both=.06
p_mother=p_both-p_father+p_one_parent_or_more
p_mother


#q2

# A random variable, X is uniform, a box from 0 to 1 of height 1. 
# (So that its density is f(x)=1 for 0≤x≤1.) What is its 75th percentile? 
qunif(.75,0,1)

#q3

# You are playing a game with a friend where you flip a coin and if it comes up heads 
# you give her X dollars and if it comes up tails she gives you Y dollars. 
# The probability that the coin is heads is p (some number between 0 and 1.) 
# What has to be true about X and Y to make so that both of your expected total earnings is 0. 
# The game would then be called “fair”. 
p*X=(1-p)*Y


#q4
# A density that looks like a normal density (but may or may not be exactly normal) 
# is exactly symmetric about zero. (Symmetric means if you flip it around zero it looks the same.)
# What is its median? 

# The median must be 0.


# q5
# Consider the following PMF shown below in R
x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp
sum(x*p)



#q6

# A web site (www.medicine.ox.ac.uk/bandolier/band64/b64-7.html) for home pregnancy tests 
# cites the following: “When the subjects using the test were women who collected and
# tested their own samples, the overall sensitivity was 75%. Specificity was also low,
# in the range 52% to 75%.” Assume the lower value for the specificity. 
# Suppose a subject has a positive test and that 30% of women taking pregnancy tests
# are actually pregnant. What number is closest to the probability of pregnancy given 
# the positive test?
spec=.75
sens=.52
true_positive=.3
p_given_positive=spec*true_positive/(spec*true_positive+sens*(1-true_positive))
p_given_positive








 


