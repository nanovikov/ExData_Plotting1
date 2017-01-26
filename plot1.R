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

# Construct the first plot: histogram of global active power
png(filename = "plot1.png")
hist(power_data$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     main = "Global Active Power")
dev.off()