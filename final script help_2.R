# setup

library(tidyverse)
library(readxl)
library(shiny)
library(writexl)

# import data sets

GHG <- read_excel("~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/GHG Data_project.xlsx")
temp <- read_excel("~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/Global Temp_project.xlsx")

# manipulate data sets

GHG <- GHG[GHG$year >=1880, ]

GHG <- GHG[grep("World", GHG$country),]

GHG <- select(GHG, "Year" = "year", "CO2" = "co2")

temp <- temp[temp$Year <= 2020,]

GHG$Temp <- as.numeric(temp$'J-D')

# save new data frame as excel file

write_xlsx(GHG, "~/KU MSASDS/KU-DATA 824-Data Vis/DATA 824 Week 7/Homework 7/Capstone Final/GHG_data_for_APP.xlsx")
