#Installing packages for data cleaning, manipulation and visualization
install.packages("tidyverse")
library("tidyverse")#to wrangle data
install.packages("lubridate")
library("lubridate")#for working with dates
install.packages("readr")
library("readr")#to read csv files
install.packages("dplyr")
library("dplyr")#for data manipulation and transformation
install.packages("tidyr")
library("tidyr")#for data cleaning
library("dlookr")#to explore and diagnose data
library("ggplot2")#to visualize data

#import the data
Jan22<- read_csv("2022-01-divvy-tripdata.csv")
Feb22<- read_csv("2022-02-divvy-tripdata.csv")
Mar22<- read_csv("2022-03-divvy-tripdata.csv")
Apr22<- read_csv("2022-04-divvy-tripdata.csv")
May22<- read_csv("2022-05-divvy-tripdata.csv")
Jun22<- read_csv("2022-06-divvy-tripdata.csv")
Jul22<- read_csv("2022-07-divvy-tripdata.csv")
Aug22<- read_csv("2022-08-divvy-tripdata.csv")
Sep22<- read_csv("2022-09-divvy-tripdata.csv")
Oct22<- read_csv("2022-10-divvy-tripdata.csv")
Nov22<- read_csv("2022-11-divvy-tripdata.csv")
Dec22<- read_csv("2022-12-divvy-tripdata.csv")

#combine rows to form a single dataframe
Tripdata<- bind_rows(Jan22,Feb22,Mar22,Apr22,May22,Jun22,Jul22,Aug22,Sep22,Oct22,Nov22,Dec22)
View(Tripdata)
#observe the data
diagnose(Tripdata)
str(Tripdata)
summary(Tripdata)
sum(is.na(Tripdata))

#remove duplicate rows
Tripdata[!duplicated(Tripdata),]
View(Tripdata)

#change character format to datetime for two columns
class(Tripdata$started_at)
class(Tripdata$ended_at)
Tripdata$started_at<- as.POSIXct(Tripdata$started_at,format="%m/%d/%Y %H:%M")
Tripdata$ended_at<- as.POSIXct(Tripdata$ended_at,format="%m/%d/%Y %H:%M")
class(Tripdata$started_at)
class(Tripdata$ended_at)
#check if changes have been implemented
summary(Tripdata)
diagnose(Tripdata)
sum(is.na(Tripdata))

#remove missing values
Tripdata_22<- Tripdata %>% 
  select(ride_id:day_of_week) %>% 
  filter(complete.cases(.))
View(Tripdata_22)
#check again if changes have been implemented
diagnose(Tripdata_22)
summary(Tripdata_22)
sum(is.na(Tripdata_22))

#check and filter out ride_length that exceeds 24-hours which is the required maximum for single day passes
Tripdata_22<- Tripdata_22[!(Tripdata_22$ride_length>=86400),]
View(Tripdata_22)
#check and filter out ride lengths that are below a second as it is irrelevant to the analysis
Tripdata_22<- Tripdata_22[!(Tripdata_22$ride_length<=0),]
View(Tripdata_22)
#check again if changes have been implemented
diagnose(Tripdata_22)
str(Tripdata_22)

#Calculate count of trips by rideable type
Tripdata_22 %>% 
  group_by(member_casual,rideable_type) %>% 
  count(rideable_type)#total rides by rider and bike type
Tripdata_22 %>% 
  group_by(rideable_type) %>% 
  count(rideable_type)#total rides by bike type
#Calculate count of trips by rider type
Tripdata_22 %>% 
  group_by(member_casual) %>% 
  count(member_casual)#total rides by rider type

#rearranging weekdays in a proper order
Tripdata_22$day_of_week<- as.factor(Tripdata_22$day_of_week)
class(Tripdata_22$day_of_week)
Tripdata_22$day_of_week<- factor(Tripdata_22$day_of_week,levels=c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"))

#Calculate count of trips by weekdays
Tripdata_22 %>% 
  group_by(member_casual,day_of_week) %>%
  arrange(member_casual,day_of_week) %>% 
  count(day_of_week)#total rides by rider type per weekdays
Tripdata_22 %>% 
  count(day_of_week)#total rides per week days

#statistical calculations of ride durations
summarise(Tripdata_22,avg_ride_length=mean(ride_length,na.rm=T))
summarise(Tripdata_22,highest_ride_length=max(ride_length,na.rm=T))
summarise(Tripdata_22,lowest_ride_length=min(ride_length,na.rm=T))

#visualization of plot graphs
Tripdata_22 %>% 
  group_by(member_casual,rideable_type) %>% 
  summarise(Trip_count= n()) %>% 
  ggplot(aes(x=rideable_type,y=Trip_count,fill=member_casual,colour=member_casual))+
  geom_bar(stat = 'identity',position = 'dodge')+
  theme_bw()+
  labs(title = "Number of trips per bike type",x="Bike type",y="Trip counts")

Tripdata_22 %>% 
  group_by(member_casual,day_of_week) %>% 
  arrange(member_casual,day_of_week) %>% 
  ggplot(aes(x=day_of_week,y=rideable_type,fill=member_casual,colour=member_casual))+
  geom_bar(stat = 'identity',position = 'dodge')+
  theme_bw()+
  labs(title = "Bike rides per week",x="Day",y="Ride type")

Tripdata_22 %>% 
  group_by(member_casual,day_of_week) %>% 
  summarise(Trip_count= n()) %>% 
  arrange(member_casual,day_of_week) %>% 
  ggplot(aes(x=day_of_week,y=Trip_count,fill=member_casual,colour=member_casual))+
  geom_bar(stat = 'identity',position = 'dodge')+
  theme_bw()+
  labs(title = "Number of trips per week",x="Day",y="Trip counts")

#export file in order to carry out further analysis and visualization in Tableau
write.csv(Tripdata_22,"Tripdata_2022.csv")

#Replicating the analysis on 2023 tripdata

#Import the data
Jan23<- read_csv("2023-01-divvy-tripdata.csv")
Feb23<- read_csv("2023-02-divvy-tripdata.csv")
Mar23<- read_csv("2023-03-divvy-tripdata.csv")
Apr23<- read_csv("2023-04-divvy-tripdata.csv")
May23<- read_csv("2023-05-divvy-tripdata.csv")
Jun23<- read_csv("2023-06-divvy-tripdata.csv")
Jul23<- read_csv("2023-07-divvy-tripdata.csv")

#combine rows to form a single dataframe
Tripdata_2023<- bind_rows(Jan23,Feb23,Mar23,Apr23,May23,Jun23,Jul23)
View(Tripdata_2023)
#observe the data
diagnose(Tripdata_2023)
str(Tripdata_2023)
summary(Tripdata_2023)
sum(is.na(Tripdata_2023))

#removing duplicate rows
Tripdata_2023[!duplicated(Tripdata_2023),]
View(Tripdata_2023)

#change character format to datetime for two columns
class(Tripdata_2023$started_at)
class(Tripdata_2023$ended_at)
Tripdata_2023$started_at<- as.POSIXct(Tripdata_2023$started_at,format="%m/%d/%Y %H:%M")
Tripdata_2023$ended_at<- as.POSIXct(Tripdata_2023$ended_at,format="%m/%d/%Y %H:%M")
class(Tripdata_2023$started_at)
class(Tripdata_2023$ended_at)
#check if changes have been implemented
summary(Tripdata_2023)
diagnose(Tripdata_2023)
sum(is.na(Tripdata_2023))

#removing missing values#
Tripdata_23<- Tripdata_2023 %>% 
  select(ride_id:day_of_week) %>% 
  filter(complete.cases(.))
View(Tripdata_23)
#check again if changes have been implemented
diagnose(Tripdata_23)
summary(Tripdata_23)
sum(is.na(Tripdata_23))

#check for ride_length that exceeds 24-hours which is the required maximum for single day passes
Tripdata_23<- Tripdata_23[!(Tripdata_23$ride_length>=86400),]
View(Tripdata_23)
#check for and filter out ride lengths that are below a second as it is irrelevant to the analysis
Tripdata_23<- Tripdata_23[!(Tripdata_23$ride_length<=0),]
View(Tripdata_23)
#check again if changes have been implemented
diagnose(Tripdata_23)
str(Tripdata_23)

#Calculate count of trips by rideable type#
Tripdata_23 %>% 
  group_by(member_casual,rideable_type) %>% 
  count(rideable_type)#total rides by rider and bike type
Tripdata_23 %>% 
  group_by(rideable_type) %>% 
  count(rideable_type)#total rides by bike type
#Calculate count of trips by rider type#
Tripdata_23 %>% 
  group_by(member_casual) %>% 
  count(member_casual)#total rides by rider type

#rearranging weekdays in a proper order#
Tripdata_23$day_of_week<- as.factor(Tripdata_23$day_of_week)
class(Tripdata_23$day_of_week)
Tripdata_23$day_of_week<- factor(Tripdata_23$day_of_week,levels=c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"))

#Calculate count of trips by day_of_week#
Tripdata_23 %>% 
  group_by(member_casual,day_of_week) %>%
  arrange(member_casual,day_of_week) %>% 
  count(day_of_week)##total rides by rider type per weekdays
Tripdata_23 %>% 
  count(day_of_week)#total rides per weekdays

#statistical calculations for ride durations
summarise(Tripdata_23,avg_ride_length=mean(ride_length,na.rm=T))
summarise(Tripdata_23,highest_ride_length=max(ride_length,na.rm=T))
summarise(Tripdata_23,lowest_ride_length=min(ride_length,na.rm=T))

#visualization of plot graphs
Tripdata_23 %>% 
  group_by(member_casual,rideable_type) %>% 
  summarise(Trip_count= n()) %>% 
  ggplot(aes(x=rideable_type,y=Trip_count,fill=member_casual,colour=member_casual))+
  geom_bar(stat = 'identity',position = 'dodge')+
  theme_bw()+
  labs(title = "Number of trips per bike type",x="Bike type",y="Trip counts")

Tripdata_23 %>% 
  group_by(member_casual,day_of_week) %>% 
  summarise(Trip_count= n()) %>% 
  arrange(member_casual,day_of_week) %>% 
  ggplot(aes(x=day_of_week,y=Trip_count,fill=member_casual,colour=member_casual))+
  geom_bar(stat = 'identity',position = 'dodge')+
  theme_bw()+
  labs(title = "Number of trips per week",x="Day",y="Trip counts")

Tripdata_23 %>% 
  group_by(member_casual,day_of_week) %>% 
  arrange(member_casual,day_of_week) %>% 
  ggplot(aes(x=day_of_week,y=rideable_type,fill=member_casual,colour=member_casual))+
  geom_bar(stat = 'identity',position = 'dodge')+
  theme_bw()+
  labs(title = "Bike rides per week",x="Day",y="Ride type")

#export file in order to carry out further analysis and visualization in Tableau
write.csv(Tripdata_23,"Tripdata_2023.csv")


