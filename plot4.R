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


#Plot 4: Multiple Plots

png(file = "plot4.png", 
    width = 480,
    height = 480)

par(mfrow = c(2,2))

plot(datasub$datetime, datasub$Global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

plot(datasub$datetime, datasub$Voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

plot(datasub$datetime, datasub$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     col = "black")
lines(datasub$datetime, datasub$Sub_metering_2,
      col = "red")
lines(datasub$datetime, datasub$Sub_metering_3,
      col = "blue")
legend("topright", 
       legend = names(datasub)[7:9],
       lty = 1,
       col = c("black", "red", "blue"),
       bty = "n")

plot(datasub$datetime, datasub$Global_reactive_power,
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "l")

dev.off()