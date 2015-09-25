Fourier Smoothing and De-noising
========================================================
author: Jeffrey Uslan
date: 9/22/2015


========================================================
# Coursera Reproducible Pitch
## See the Web Application here:
 - https://jeffreyuslan.shinyapps.io/Fourier_Smoother
 
This shiny app is intended to showcase the trend finding and de-noising power of Fourier methods.

========================================================
# Simulated Data

Creating  simulated time series data:


```r
len=1000
x=seq(1:len)
time     <- 1
w        <- 2*pi/time
ts       <- seq(time/len,time,1/len)


sin_1=.99*sin(1*w*ts)
sin_2=.9*sin(6*w*ts)
sin_4=.5*sin(26*w*ts)
sin_8=.8*sin(133*w*ts)
sin_16=.7*sin(400*w*ts)

clean_period=sin_1+sin_2+sin_4+sin_8+sin_16


noise=rnorm(len,mean=0,sd=.5)
sim_data = clean_period+noise
plot.df=data.frame(x=1:len,sim_data=sim_data)
```



========================================================



```
Error in eval(expr, envir, enclos) : could not find function "ggplot"
```
