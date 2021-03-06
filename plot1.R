library(datasets)

# household_power_consumption.txt must be found in the working directory
houseData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                    colClasses = c("factor", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert Date and Time columns 
houseData$Date <- as.Date(houseData$Date, format='%d/%m/%Y')
houseData$Time <- strptime(houseData$Time, format='%X')
houseData$Time <- format(houseData$Time, format='%H:%M:%S')

# Only dates from 2-day period in February, 2007
usage <- houseData[houseData$Date >= "2007-02-01" & houseData$Date <= "2007-02-02", ]

# Create plot and save as PNG
png(filename = "plot1.png", width=504, height = 504)
with(usage, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()