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

png("plot2.png", width = 480, height = 480, units = "px")

plot(powerSubset$Date_time, powerSubset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()