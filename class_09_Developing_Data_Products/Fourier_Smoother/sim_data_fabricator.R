
len=1000

#time indicator
x=seq(1:len)
time     <- 1
w        <- 2*pi/time
ts       <- seq(time/len,time,1/len)
#simple noise
noise=rnorm(len,mean=0,sd=.3)
#heteroscedastic noise
#sinusoidals
sin_1=.99*sin(1*w*ts)
sin_2=.9*sin(6*w*ts)
sin_4=.5*sin(26*w*ts)
sin_8=.8*sin(133*w*ts)
sin_16=.7*sin(400*w*ts)
clean_period=sin_1+sin_2+sin_4+sin_8+sin_16
plot(clean_period)

sim_data = clean_period+noise
plot(sim_data)

save(sim_data,file ="sim_data.rda")

