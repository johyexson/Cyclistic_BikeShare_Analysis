# Cyclistic_BikeShare_Analysis 
![](Intro_image.jpg)
# Table of Contents
- [Case Study](#case-study)
- [Data Source](#data-source)
- [Hypothesis](#hypothesis)
- [Tools](#tools)
- [Method of Analysis](#method-of-analysis)
- [Code](#code)
- [Summary of Findings](#summary-of-findings)
- [Key Observation](#key-observation)
- [Recommendations](#recommendations)
- [Dashboard](#dashboard)
# Case Study
A fictional bike share company named Cyclistic, which has a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago, is looking for ways to convert its casual riders to annual members.
# Data Source
The data used was made available by a real bike share Company named Divvy.It includes tripdata originally stored in csv files and organized by different months of each year. [Link](https://divvy-tripdata.s3.amazonaws.com/index.html)
# Hypothesis 
This is my assumption based on the business task:
- Casual riders are more likely to become annual members if compelling incentives are offered. This is because offering bike commuting incentives have a better track record of getting people to make the switch.
# Tools
- Excel
- [R](https://github.com/johyexson/Cyclistic_BikeShare/blob/main/My_Capstone_Project.R)
- [Tableau](https://public.tableau.com/app/profile/joy.johnson5229/viz/Cyclistic_BikeShare_16944692451940/CyclisticBikeShareDashboard)
# Approach and Analysis Methods
I decided to analyse the tripdata for year 2022 from January to December and year 2023 from January to July being the most recently updated tripdata. The analysis process are as follows:
- **Data Cleaning and Transformation**:
Imported the libraries and packages such as(Tidyverse, Lubridate, Dlookr, Readr, etc.) in RStudio for cleaning and transforming the data. Removed missing values and duplicate rows, converted data types and removed irrelevant columns
- **Exploratory Data Analysis**:
Carried out statistical calculations to answer the business task. Extracted insights from the data using aggregating functions and modules in R.
- **Data Visualization**:
Exported the file in order to create a dashboard to visualize the findings of the analysis in Tableau.
# Code
You can explore the codes I wrote for the analysis [here](https://github.com/johyexson/Cyclistic_BikeShare/blob/main/My_Capstone_Project.R)
# Summary of Findings
A comparison of the tripdata from the previous year and the present year shows the historical pattern  and consistency in rider preferences

![](Graph_1.png)
- Both members and casual riders frequently used classic bikes compared to other bike types
- Docked bikes were only used by casual riders, while classic and electric bikes were used by both member and casual riders

![](Graph_2.png)
- Members had the highest trip counts and the most frequent rides during the week

![](Graph_3.png)
- Saturday was the day with the most frequent rides by both members and casual riders
# Key Observation
Casual riders that frequently use classic bikes have higher chances of being converted to annual members, therefore the advertising campaigns should be directed towards them
# Recommendations
1. Advertising campaigns should be strategized and geared towards improving the quality of classic bikes in order to attract the interest of more casual riders.
2. Free test rides with the remodified classic bikes should be introduced to the casual riders to arouse their interest.
3. Incentives such as discounts should be included for casual riders, especially those using classic bikes.

# Dashboard
The dashboard I created in Tableau can be viewed [here.](https://public.tableau.com/app/profile/joy.johnson5229/viz/Cyclistic_BikeShare_16944692451940/CyclisticBikeShareDashboard)
