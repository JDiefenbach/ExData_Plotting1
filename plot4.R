##This file constructs 4 graphs as a function of Date: Global Active Power, Voltage, Energy sub metering, Global reactive power

##Read the data and change the class of the Date column
consumptionData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
consumptionData$Date <- as.Date(consumptionData$Date, format = "%d/%m/%Y")

##Select the correct sample from the dataset and name it plot4data
sample <- consumptionData$Date == "2007-02-01" | consumptionData$Date == "2007-02-02"
plot4data <- consumptionData[sample,]

##Add a column FormatTime which combines the date and time using strptime
plot4data$FormatTime <- strptime(paste(plot4data$Date, plot4data$Time, sep =" "), format = "%Y-%m-%d %H:%M:%S")

##Change the class of the required columns from factor to numeric
plot4data$Sub_metering_1 <- as.numeric(levels(plot4data$Sub_metering_1))[plot4data$Sub_metering_1]
plot4data$Sub_metering_2 <- as.numeric(levels(plot4data$Sub_metering_2))[plot4data$Sub_metering_2]
plot4data$Global_active_power <- as.numeric(levels(plot4data$Global_active_power))[plot4data$Global_active_power]
plot4data$Global_reactive_power <- as.numeric(levels(plot4data$Global_reactive_power))[plot4data$Global_reactive_power]
plot4data$Voltage <- as.numeric(levels(plot4data$Voltage))[plot4data$Voltage]

##Open png file
png("plot4.png")

##Divide the screen into 4 different plots
par(mfrow = c(2,2), mar = c(4,4,2,4))

##Plot 1: Global Active Power as a function of Date
plot(plot4data$FormatTime, plot4data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

##Plot 2: Voltage as a function of Date
plot(plot4data$FormatTime, plot4data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

##Plot 3: Sub metering as a function of Date
with(plot4data, plot(plot4data$FormatTime, plot4data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
lines(plot4data$FormatTime, plot4data$Sub_metering_1)
lines(plot4data$FormatTime, plot4data$Sub_metering_2, col = "red")
lines(plot4data$FormatTime, plot4data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = c("_","_","_"), col = c("black", "red", "blue"))

##Plot 4: Global reactive power as a function of Date
plot(plot4data$FormatTime, plot4data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()