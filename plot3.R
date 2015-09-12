##This file constructs a line graph of Sub_metering 1,2 and 3 for a two day interval in February 2007

##Read the data and change the class of the Date column
consumptionData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
consumptionData$Date <- as.Date(consumptionData$Date, format = "%d/%m/%Y")

##Select the correct sample from the dataset and name it plot3data
sample <- consumptionData$Date == "2007-02-01" | consumptionData$Date == "2007-02-02"
plot3data <- consumptionData[sample,]

##Add a column FormatTime which combines the date and time using strptime
plot3data$FormatTime <- strptime(paste(plot3data$Date, plot3data$Time, sep =" "), format = "%Y-%m-%d %H:%M:%S")

##Change the class of sub_metering 1 and 2 from factor into numeric (sub_metering 3 is already numeric)
plot3data$Sub_metering_1 <- as.numeric(levels(plot3data$Sub_metering_1))[plot3data$Sub_metering_1]
plot3data$Sub_metering_2 <- as.numeric(levels(plot3data$Sub_metering_2))[plot3data$Sub_metering_2]

##Set the right parameters for the graph
par(mfrow = c(1,1), mar = c(4,4,2,4))

##First construct an empty plot and add the three sum_metering variables one by one. Finally add a legend
png("plot3.png")
with(plot3data, plot(plot3data$FormatTime, plot3data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
lines(plot3data$FormatTime, plot3data$Sub_metering_1)
lines(plot3data$FormatTime, plot3data$Sub_metering_2, col = "red")
lines(plot3data$FormatTime, plot3data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = c("_","_","_"), col = c("black", "red", "blue"))
dev.off()