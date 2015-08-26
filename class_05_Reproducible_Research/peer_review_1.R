library(ggplot2)
library(tidyr)
library(zoo)
library(dplyr)

# Loading and preprocessing the data
activity<-tbl_df(read.csv(unzip("./activity.csv")))
activity
summary(activity)
names(activity)
length(unique(activity$date))


# What is mean total number of steps taken per day?
# Calculate the total number of steps taken per day
sum_steps <- activity %>% group_by(date) %>% summarise(daily_steps=sum(steps))
# Make a histogram of the total number of steps taken each day
ggplot(sum_steps,aes(x=daily_steps))+geom_histogram()+theme_bw()+
  xlab("Daily Steps")+ggtitle("Total Daily Steps")
# Calculate and report the mean and median of the total number of steps taken per day
sum_steps %>%   na.omit()  %>% summarise(mean(daily_steps),median(daily_steps)) 


# What is the average daily activity pattern?
# Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) 
# and the average number of steps taken, averaged across all days (y-axis)
ggplot(activity,aes(x=interval,y=steps))+geom_point()+geom_smooth(aes(group=1))+
  xlab("Interval")+ylab("Steps")+ggtitle("Total Daily Steps")
# Which 5-minute interval, on average across all the days in the dataset, 
# contains the maximum number of steps?
activity$interval=as.factor(activity$interval)
mean_steps <- activity %>% na.omit() %>% group_by(interval) %>% summarise(interval_steps=mean(steps))
mean_steps[which(mean_steps$interval_steps==max(mean_steps$interval_steps)),]


# Imputing missing values
# Calculate and report the total number of missing values in the dataset 
# (i.e. the total number of rows with NAs)
apply(activity,2,function(x){
  sum(is.na(x))
})
# Devise a strategy for filling in all of the missing values in the dataset. 
# The strategy does not need to be sophisticated. For example, 
# you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

# Create a new dataset that is equal to the original dataset but with the missing data filled in.
imputed_activity<-apply(activity,1,function(x){
  if (is.na(x[1])){
    ind=which(x[3]==mean_steps$interval)
    x[1]=round(mean_steps$interval_steps[ind])
    
  }
  return(x)
}
)

imputed_activity=as.data.frame(t(imputed_activity))
imputed_activity$steps=as.numeric(as.character(imputed_activity$steps))
apply(imputed_activity,2,function(x){
  sum(is.na(x))
})
summary(imputed_activity$steps)
summary(activity$steps)

# Make a histogram of the total number of steps taken each day and 


imputed_sum_steps <- imputed_activity %>% group_by(date) %>% summarise(daily_steps=sum(steps))
ggplot(imputed_sum_steps,aes(x=daily_steps))+geom_histogram()+theme_bw()+
  xlab("Daily Steps")+ggtitle("Imputed Total Daily Steps")
# Calculate and report the mean and median total number of steps taken per day. 
imputed_sum_steps %>%   na.omit()  %>% summarise(mean(daily_steps),median(daily_steps)) 
# Do these values differ from the estimates from the first part of the assignment? 
sum_steps %>%   na.omit()  %>% summarise(mean(daily_steps),median(daily_steps)) 
# What is the impact of imputing missing data on the estimates of the total daily number of steps?


# Are there differences in activity patterns between weekdays and weekends?
# Create a new factor variable in the dataset with two levels – 
# “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.
imputed_activity$date=as.POSIXct(activity$date)
week_break <- function(date) {
  day <- weekdays(date)
  if (day %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")){
    return("Weekday")
  }
  else { (day %in% c("Saturday", "Sunday"))
    return("Weekend")
  }
}
imputed_activity$week_break<-sapply(imputed_activity$date,FUN=week_break)
# Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval 
# (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). 
# See the README file in the GitHub repository to see an example of what this plot should 
# look like using simulated data.
imputed_sum_steps_weekday <- imputed_activity %>% group_by(date,week_break) %>% summarise(daily_steps=sum(steps))
ggplot(imputed_activity,aes(x=interval,y=steps))+geom_point()+geom_smooth(aes(group=1))+
  xlab("Interval")+ylab("Steps")+ggtitle("Total Daily Steps")+facet_grid(week_break~.)

