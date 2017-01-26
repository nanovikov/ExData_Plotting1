# Read a subset of the data from the dates of 
# 2007-02-01 and 2007-02-02
#
# The line number of the appropriate rows was 
# obtained using the grep function in terminal: 
# grep -n 01/02/2007 
# grep 01/02/2007 | wc -l 
# grep 02/02/2007 | wc -l
power_data <- read.table(file = "household_power_consumption.txt", 
                         header = F, 
                         sep = ";",
                         na.strings = "?", 
                         skip = 66637, 
                         nrows = 2880, 
                         stringsAsFactors = F)

# Read just the first line of the data file
# to obtain the header information. 
# Assign the header to the data frame 'power_data'
power_header <- read.table(file = "household_power_consumption.txt", 
                           header = F, 
                           sep = ";", 
                           nrows = 1, 
                           stringsAsFactors = F)
names(power_data) <- unlist(power_header)

# Convert the Date and Time information into objects of class 'Date'
# from the lubridate package
power_data$Date <- dmy(power_data$Date)
power_data$Time <- hms(power_data$Time)

# Construct fourth plot consisting of 4 plots: 
# 1. plot 2 above
# 2. Voltage = f ( datetime)
# 3. plot 3 above
# 4. Global_reactive_power = f (datetime)
png(filename = "plot4.png")
par(mfrow = c (2, 2))
plot(power_data$Date + power_data$Time, 
     power_data$Global_active_power, 
     t= "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")
plot(power_data$Date + power_data$Time,
     power_data$Voltage, 
     t = "l", 
     ylab = "Voltage",
     xlab = "datetime"
)
plot(power_data$Date + power_data$Time,
     power_data$Sub_metering_1, 
     t= "l", 
     ylab = "Energy sub metering", 
     xlab = "")
lines(power_data$Date + power_data$Time,
      power_data$Sub_metering_2, 
      col = "red")
lines(power_data$Date + power_data$Time,
      power_data$Sub_metering_3, 
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"), 
       col = c("black", 
               "red", 
               "blue"), 
       lty = 1, 
       lwd = 1, 
       bty = "n")
plot(power_data$Date + power_data$Time,
     power_data$Global_reactive_power, 
     t = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power"
)
dev.off()