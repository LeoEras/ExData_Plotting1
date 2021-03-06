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

#STEP 2. Join Date and Time, converting our variables to numeric
data<-mutate(data, Date = paste(Date, Time))
data$Date<-as.POSIXct(data$Date, format = "%d/%m/%Y %H:%M:%S")
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
data$Voltage<-as.numeric(data$Voltage)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)

#STEP 4. Draw our nice graphic
png("data/plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(1,1,1,1))
with(data, plot(Date, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))
with(data, plot(Date, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))
with(data, plot(Date, Sub_metering_1, type="n", lty = 1, lwd = 1, xlab = "", ylab = "Energy sub metering"))
with(data, lines(Date, Sub_metering_1))
with(data, lines(Date, Sub_metering_2, col="red"))
with(data, lines(Date, Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_mettering_1", "Sub_mettering_2", "Sub_mettering_3"), col = c("black", "red", "blue"), lty="solid", bty = 'n')
with(data, plot(Date, Global_reactive_power, type="l", lty = 1, lwd = 1, xlab = "datetime"))
dev.off()
