library(datasets)
library(dplyr)

# household_power_consumption.txt must be found in the working directory
houseData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert Date and Time columns 
houseData$Date <- as.Date(houseData$Date, format='%d/%m/%Y')

# Convert date and time rows to single date time column. 
# With help from https://class.coursera.org/exdata-032/forum/thread?thread_id=75

dateTime <- paste(houseData$Date, houseData$Time)
dateTime <- strptime(dateTime, format = "%Y-%m-%d %H:%M:%S")
houseData$dateTime <- dateTime

# Only dates from 2-day period in February, 2007
usage <- houseData[houseData$Date >= "2007-02-01" & houseData$Date <= "2007-02-02", ]

# Recreate reference plot
with(usage, plot(dateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file="plot2.png")
dev.off()