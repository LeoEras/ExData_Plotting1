#STEP 0, data preparation
library(dplyr)
library(data.table)

if(!file.exists("data")){
  dir.create("data")
}

#The zip URL
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="data/dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="data/dataset.zip", exdir="data")

#STEP 1. Read the file contents and filter by stated dates
#If you have already done the previous steps, I suggest you start here by this step in the other .R files as well
file<-"data/household_power_consumption.txt"
data<-fread(file)
data<-filter(data, Date %in% c("1/2/2007","2/2/2007"))

#STEP 2. Join Date and Time
data<-mutate(data, Date = paste(Date, Time))
data$Date<-as.POSIXct(data$Date, format = "%d/%m/%Y %H:%M:%S")
data$Global_active_power<-as.numeric(data$Global_active_power)

#STEP 3. Draw our nice graphic
png("data/plot2.png", width = 480, height = 480)
with(data, plot(Date, Global_active_power, type="l", lty = 1, lwd = 1, xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
