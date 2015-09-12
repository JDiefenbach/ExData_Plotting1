##This file constructs a histogram of the household power consumption on 1 and 2 February 2007

##Read the data and change the class of the Date column
consumptionData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
consumptionData$Date <- as.Date(consumptionData$Date, format = "%d/%m/%Y")

##Select the correct sample out of the total dataset and name it correctData
sample <- consumptionData$Date == "2007-02-01" | consumptionData$Date == "2007-02-02"
correctData <- consumptionData[sample,]

##Change the class of the Global_active-power observations from factor to numeric
correctData$Global_active_power <- as.numeric(levels(correctData$Global_active_power))[correctData$Global_active_power]

##Set the right parameters for the graph
par(mfrow = c(1,1), mar = c(4,4,2,4))

##Construct the histogram using the required settings and write it to plot1.png
png("plot1.png")
hist(correctData$Global_active_power, xlab = "Global active power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power")
dev.off()    