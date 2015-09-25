library(ggplot2)
library(tidyr)
library(zoo)
library(dplyr)
library(stringr)
library(gridExtra)





if (!exists("storm")) storm <- read.csv(bzfile("repdata-data-StormData.csv.bz2"))
storm <- tbl_df(storm)
storm

storm$year <- as.numeric(format(as.Date(storm$BGN_DATE, format = "%m/%d/%Y %H:%M:%S"), "%Y"))
ggplot(data=storm)+theme_bw()+
  geom_histogram(aes(x=year))+xlab("Year")+ylab("Frequency")+ggtitle("Histogram of Storm Year")

# Limit to dense data after 1995  
storm = storm[storm$year>=1995,]

# Across the United States, which types of events (as indicated in the EVTYPE variable) 
# are most harmful with respect to population health?
storm$EVTYPE= as.factor(tolower(storm$EVTYPE))
storm %>% group_by(EVTYPE) %>% summarise(Count=n()) %>% arrange(desc(Count))

storm$simplfied_EVTYPE=as.character(storm$EVTYPE)

word="fld"
rep_ind=grep(word,storm$simplfied_EVTYPE)
storm$simplfied_EVTYPE[rep_ind]="flood" 

replacement_words=c("hail","wind","flood","snow","lightning","rain","winter","funnel cloud",
                    "waterspout","fire","blizzard","drought","ice","heat","fog","freeze",
                    "surf","tropical","cold","dust","avalanche","hurricane","tide",
                    "landslide","warm","current","dry","tornado","storm")
for (word in replacement_words) {
  
  rep_ind=grep(word,storm$simplfied_EVTYPE) 
  storm$simplfied_EVTYPE[rep_ind]=word 
  
}
Storm_Health=storm %>% group_by(simplfied_EVTYPE) %>% 
  summarise(Fatalities=sum(FATALITIES),Injuries=sum(INJURIES),
            Count=n()) 
Storm_Health %>% arrange(desc(Count))
Storm_Health %>% arrange(desc(Fatalities))
Storm_Health %>% arrange(desc(Injuries))


worst_fatalities=(Storm_Health %>% arrange(desc(Fatalities)))$simplfied_EVTYPE[1:10]
temp_plot_data=Storm_Health %>% arrange(desc(Fatalities))
temp_plot_data=temp_plot_data[temp_plot_data$simplfied_EVTYPE %in% worst_fatalities,] 
fatality_plot <- ggplot(temp_plot_data) + theme_bw() +
  geom_bar(aes(x =simplfied_EVTYPE,weight=Fatalities ))+
  scale_y_continuous("Total of Fatalities") + 
  theme(axis.text.x = element_text(angle = 45,hjust = 1)) + 
  xlab("Weather Event Type") + 
  ggtitle("Total Fatalities by Weather Event Type \n")

worst_Injuries=(Storm_Health %>% arrange(desc(Injuries)))$simplfied_EVTYPE[1:10]
temp_plot_data=Storm_Health %>% arrange(desc(Injuries))
temp_plot_data=temp_plot_data[temp_plot_data$simplfied_EVTYPE %in% worst_Injuries,] 
injury_plot <-  ggplot(temp_plot_data) + theme_bw() +
  geom_bar(aes(x =simplfied_EVTYPE,weight=Injuries ))+
  scale_y_continuous("Total of Injuries") + 
  theme(axis.text.x = element_text(angle = 45,hjust = 1)) + 
  xlab("Weather Event Type") + 
  ggtitle("Total Injuries by Weather Event Type \n")
grid.arrange(fatality_plot, injury_plot, ncol = 2)

 # word="storm"
 # rep_ind=grep(word,storm$simplfied_EVTYPE) 
 # temp_data=storm[rep_ind,]
 # arrange(temp_data %>% group_by(simplfied_EVTYPE) %>% summarise(Count=n()),desc(Count))


# Across the United States, which types of events have the greatest economic consequences?
storm_backup=storm
storm$PROPDMG[storm$PROPDMGEXP=="B"]=(storm$PROPDMG[storm$PROPDMGEXP=="B"]*(10^9))/(10^6)
storm$PROPDMG[storm$PROPDMGEXP=="M"]=(storm$PROPDMG[storm$PROPDMGEXP=="M"]*(10^6))/(10^6)
storm$PROPDMG[storm$PROPDMGEXP=="K"]=(storm$PROPDMG[storm$PROPDMGEXP=="K"]*(10^3))/(10^6)
storm$PROPDMG[storm$PROPDMGEXP=="H"]=(storm$PROPDMG[storm$PROPDMGEXP=="H"]*(10^2))/(10^6)

storm$CROPDMG[storm$CROPDMGEXP=="B"]=(storm$CROPDMG[storm$CROPDMGEXP=="B"]*(10^9))/(10^6)
storm$CROPDMG[storm$CROPDMGEXP=="M"]=(storm$CROPDMG[storm$CROPDMGEXP=="M"]*(10^6))/(10^6)
storm$CROPDMG[storm$CROPDMGEXP=="K"]=(storm$CROPDMG[storm$CROPDMGEXP=="K"]*(10^3))/(10^6)
storm$CROPDMG[storm$CROPDMGEXP=="H"]=(storm$CROPDMG[storm$CROPDMGEXP=="H"]*(10^2))/(10^6)

Storm_Economy=storm %>% group_by(simplfied_EVTYPE) %>% 
  summarise(Property=sum(PROPDMG),Crop=sum(CROPDMG),
            Count=n()) 

Storm_Economy %>% arrange(desc(Property))
Storm_Economy %>% arrange(desc(Crop))



ind_1=(Storm_Economy %>% arrange(desc(Property)))$simplfied_EVTYPE[1:10]
temp_plot_data=Storm_Economy %>% arrange(desc(Property))
temp_plot_data=temp_plot_data[temp_plot_data$simplfied_EVTYPE %in% ind_1,] 
property_plot <- ggplot(temp_plot_data) + theme_bw() +
  geom_bar(aes(x =simplfied_EVTYPE,weight=Property ))+
  scale_y_continuous("Total of Property Damage in Millions of  US Dollars") + 
  theme(axis.text.x = element_text(angle = 45,hjust = 1)) + 
  xlab("Weather Event Type") + 
  ggtitle("Total Property Damage by Weather Event Type \n")

ind_2=(Storm_Economy %>% arrange(desc(Crop)))$simplfied_EVTYPE[1:10]
temp_plot_data=Storm_Economy %>% arrange(desc(Crop))
temp_plot_data=temp_plot_data[temp_plot_data$simplfied_EVTYPE %in% ind_2,] 
crop_plot <-  ggplot(temp_plot_data) + theme_bw() +
  geom_bar(aes(x =simplfied_EVTYPE,weight=Crop ))+
  scale_y_continuous("Total of Crop Damage in Millions of US Dollars") + 
  theme(axis.text.x = element_text(angle = 45,hjust = 1)) + 
  xlab("Weather Event Type") + 
  ggtitle("Total Crop Damage by Weather Event Type \n")
grid.arrange(property_plot, crop_plot, ncol = 2)




