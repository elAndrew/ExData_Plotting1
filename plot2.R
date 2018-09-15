dir <-"/Users/andrew/ExData_Plotting1"
setwd(dir)

#Download our data

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./data/")){
  file.create("./data/")
}

if(!file.exists("./data/household_power_consumption.zip")){
  download.file(fileURL, "./data/household_power_consumption.zip")
}

if(!file.exists("./data/household_power_consumption.txt")){
  unzip("./data/household_power_consumption.zip", exdir = "./data/")
}


#Explore the dataset

dataset <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

head(dataset)


#Use lubrridate to make Date variable into an easier to use format

library(lubridate)

dataset$Date <- dmy(dataset$Date)


#Subset dataset to dates 2007-02-01 and 2007-02-02

library(dplyr)

datasub <- dataset %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")


#Make a datetime variable, and a dayofweek variable

datasub$datetime <- 
  with(datasub, ymd(Date) + hms(Time))

datasub$dayofweek <- 
  wday(datasub$datetime, label = TRUE)


#Plot 2: Line Plot

png(file = "plot2.png", 
    width = 480,
    height = 480)

plot(datasub$datetime, datasub$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

dev.off()
