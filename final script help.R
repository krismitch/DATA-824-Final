# setup

library(tidyverse)
library(readxl)

#install.packages("writexl")
library(writexl)

# import data sets

GHG <- read_excel("~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/GHG Data_project.xlsx")
temp <- read_excel("~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/Global Temp_project.xlsx")

# manipulate data sets

GHG <- GHG[GHG$year >=1949, ]
GHG <- select(GHG, "country", "year", "co2")

GHG_wide <- GHG %>% 
  spread(year, co2)

GHG_world <- data.frame(colMeans(GHG_wide[,-1], na.rm = TRUE))
colnames(GHG_world) <- "Average Global CO2"

temp <- temp[temp$Year >= 1949,]
temp <- temp[temp$Year <= 2020,]

GHG_world$Temp <- as.numeric(temp$'J-D')
GHG_world$Year <- temp$Year
GHG_world <- GHG_world[,c(3,1,2)]

# save new data frame as excel file

write_xlsx(GHG_world, "~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/GHG_world.xlsx")

GHG_world <- read_excel("~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/GHG_world.xlsx")

library(readxl)
GHG_world <- read_excel("~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/GHG_world.xlsx")
# test plot 

#ggplot(GHG_world) +
#  geom_point(aes(x = Year, y = GHG_world$'Average Global CO2')) 
  
  