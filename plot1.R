#STEP 0, data preparation & useful libraries
library(dplyr)
library(data.table)

if(!file.exists("data")){
  dir.create("data")
}

#The zip URL
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="data/dataset.zip")

# Unzip dataSet to /data directory, save the filename in file variable
unzip(zipfile="data/dataset.zip", exdir="data")
file<-"data/household_power_consumption.txt"

#STEP 1. Read the file contents and filter by stated dates
#If you have already done the previous steps, I suggest you start here by this step in the other .R files as well
data<-fread(file)
data<-filter(data, Date %in% c("1/2/2007","2/2/2007"))

#STEP 2. Convert types of data
data$Global_active_power<-as.numeric(data$Global_active_power)

#STEP 3. Draw our nice graphic
png("data/plot1.png", width = 480, height = 480)
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()
