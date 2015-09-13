library(datasets)
library(dplyr)

houseData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert Date and Time columns 
#houseData$Date <- as.Date(houseData$Date, format='%d/%m/%Y')
#houseData$Time <- strptime(houseData$Time, format='%X')
#houseData$Time <- format(houseData$Time, format='%H:%M:%S')

DateTime <- paste(usage$Date, usage$Time)
dateTime <- strptime(format = "%Y-%m-%d %H:%M:%S")
usage$dateTime <- dateTime

# Only dates from 2-day period in February, 2007
usage <- houseData[houseData$Date >= "2007-02-01" & houseData$Date <= "2007-02-02", ]

DateTime <- paste(usage$Date, usage$Time)
dateTime <- strptime(format = "%Y-%m-%d %H:%M:%S")
usage$dateTime <- dateTime

with(usage, plot(dateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file="plot2.png")
dev.off()