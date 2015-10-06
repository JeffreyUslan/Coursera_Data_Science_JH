library(ggplot2)
library(dplyr)
data(mtcars)
?mtcars
mtcars=tbl_df(mtcars)
mtcars




# Is an automatic or manual transmission better for MPG?
mtcars$Transmission=NA
mtcars$Transmission[which(mtcars$am==0)]="Automatic"
mtcars$Transmission[which(mtcars$am==1)]="Manual"

mtcars %>% group_by(Transmission) %>% summarise(min(mpg),mean(mpg),median(mpg),max(mpg))
t.test(data=mtcars,mpg~Transmission)







  


# Quantify the MPG difference between automatic and manual transmissions
mostly_numeric_model=lm(mpg~Transmission+cyl+hp+disp+drat+wt+qsec,data=mtcars)
summary(mostly_numeric_model)

stepwise_model=step(mostly_numeric_model,k=log(nrow(mtcars)))
summary(stepwise_model)

anova(mostly_numeric_model,stepwise_model, test="Chi")
# The P-value is larger than 0.05. So, according to our criterion, 
# we would fail to reject the more simplified model,



categorical_fit=lm(mpg~Transmission,data=mtcars)
summary(categorical_fit)

anova(stepwise_model, categorical_fit, test="Chi")
# The P-value is smaller than 0.05. So, according to our criterion, 
# we would reject the more simplified model,


ggplot(data=mtcars)+theme_bw()+geom_density(aes(x=mpg,color=Transmission))+
  ggtitle("Fuel Efficiency by Transmission type")+xlab("Miles Per Gallon (MPG)")+ylab("Density")


ggplot(data=mtcars)+theme_bw()+geom_point(aes(y=wt,x=mpg,color=Transmission))+
  geom_smooth(method=lm,aes(y=wt,x=mpg,color=Transmission))+
  ggtitle("Fuel Efficiency by Weight")+ylab("Miles Per Gallon (MPG)")+xlab("Weight")


qplot(fitted(stepwise_model),residuals(stepwise_model))+geom_hline(yintercept=0)+theme_bw()
qqnorm(residuals(stepwise_model))



 