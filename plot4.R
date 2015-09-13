library(datasets)

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

png(filename = "plot4.png", width=504, height = 504)
par(mfrow=c(2,2))

# Active global power plot
with(usage, plot(dateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Voltage plot
with(usage, plot(dateTime, Voltage, type = "l", xlab = "datetime", ylab = "Volate"))

# Sub metering plot
plot(usage$dateTime, usage$Sub_metering_1, type = "n", xlab = "", ylab="Energy sub metering")
lines(usage$dateTime, usage$Sub_metering_1, col="black")
lines(usage$dateTime, usage$Sub_metering_2, col="red")
lines(usage$dateTime, usage$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(1,1,1), bty = "n")

# Global reactive power plot
with(usage, plot(dateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()