# q1
subject <- c(1,2,3,4,5)
baseline <- c(140,138,150,148,135)
week_2 <- c(132,135,151,146,130)
examinations <- data.frame(subject, baseline, week_2)
examinations

 t.test(x = examinations$baseline, y = examinations$week_2, alt = "two.sided", paired = T)



# q2


n <- 9
mu <- 1100
sd <- 30
quant = 0.975 # 
mu + c(-1, 1) * qt(quantile, df=n-1) * sd / sqrt(n)



#q3

n <- 4
x <- 3
 binom.test(x=x, n=n, alt="greater")

# q4
rate <- .01
err <- 10
days <- 1787
poisson.test(err, T = days, r = rate, alt="less")





# q5

n <- 9 
s_1 <- 1.5
s_2 <- 1.8
mu_1 <- -3
mu_2 <- 1


s_p <- (((n - 1) * s_2^2 + (n - 1) * s_1^2)/(n + n - 2))
 pt((mu_1 - mu_2) / (s_p * (1 / n + 1 / n)^.5), df=n + n -2)


# q6
# No, it is in the CI


# q7

n <- 100 
mu <- 0.01
sd <- 0.04
p <- 0.05 

power.t.test(n=n, delta=mu, sd=sd , sig.level=p, type="one.sample", alt="one.sided")$power



# q8

mu <- 0.01
sd <- 0.04
p <- 0.05 
pow <- 0.9

 power.t.test(power=pow, delta=mu, sd=sd , sig.level=p, type="one.sample", alt="one.sided")$n





