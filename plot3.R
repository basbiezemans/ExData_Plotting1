#
# This file constructs a plot and saves it to a PNG file 
# with a width of 480 pixels and a height of 480 pixels.

library(data.table)

# Read the power data file
powerData <- fread("household_power_consumption.txt", na.strings = "?")

# Merge the Date and Time columns into Date_time
powerData$Date_time <- paste(powerData$Date, powerData$Time, sep = " ")

# Remove the Date and Time columns
powerData <- subset(powerData, select = -c(Date, Time))

# Convert Date_time strings to POSIX
powerData$Date_time <- as.POSIXct(strptime(powerData$Date_time, "%d/%m/%Y %H:%M:%S"))

# Create a subset for February 1st and 2nd, 2007
powerSubset <- subset(powerData, Date_time %between% c("2007-02-01 00:00:00","2007-02-03 00:00:00"))

# Get ranges for the x and y axis
xrange <- with(powerSubset, range(Date_time))
yrange <- with(powerSubset, range(Sub_metering_1, Sub_metering_2, Sub_metering_3))

png("plot3.png", width = 480, height = 480, units = "px")

plot(xrange, yrange, type = "n", xlab = "", ylab = "Energy sub metering")

with(powerSubset, {
    lines(Date_time, Sub_metering_1, col = "black")
    lines(Date_time, Sub_metering_2, col = "red")
    lines(Date_time, Sub_metering_3, col = "blue")
})

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
