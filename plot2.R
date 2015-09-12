##This file constructs a line graph of the household power consumption on 1 and 2 February 2007 (measured per minute)

##Read the data and change the class of the Date column
consumptionData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
consumptionData$Date <- as.Date(consumptionData$Date, format = "%d/%m/%Y")

##Select the correct sample from the dataset and name it plot2data
sample <- consumptionData$Date == "2007-02-01" | consumptionData$Date == "2007-02-02"
plot2data <- consumptionData[sample,]

##Add a column FormatTime which combines the date and time using strptime
plot2data$FormatTime <- strptime(paste(plot2data$Date, plot2data$Time, sep =" "), format = "%Y-%m-%d %H:%M:%S")

##Change the class of the global active power column from factor to numeric
plot2data$Global_active_power <- as.numeric(levels(plot2data$Global_active_power))[plot2data$Global_active_power]

##Set the right parameters for the graph
par(mfrow = c(1,1), mar = c(4,4,2,4))

##Plot the line graph using the required settings and write it to png file
png("plot2.png")
plot(plot2data$FormatTime, plot2data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()