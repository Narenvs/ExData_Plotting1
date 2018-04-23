setwd("C:/Naren/R/Assignments/Exploratory_data_analysis")
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./dataset")) {dir.create("./dataset")}
download.file(fileurl,destfile = "./dataset/household_power_consumption.zip")
unzip("./dataset/household_power_consumption.zip",exdir = "./dataset")
file.remove("./dataset/household_power_consumption.zip")

library(readr)
powercon <- read_delim("./dataset/household_power_consumption.txt",delim = ";",na = c("?"))
#powercon <- read.table("./dataset/household_power_consumption.txt",sep = ";",header = TRUE,na.strings = "?")
#View(powercon)
powercon$Date <- strptime(powercon$Date,"%d/%m/%Y")
testdata <- powercon[(powercon$Date >= "2007-02-01" & powercon$Date <= "2007-02-02"),]
testdata$datetime <- paste(testdata$Date,testdata$Time)
testdata$datetime <- strptime(testdata$datetime,"%Y-%m-%d %H:%M:%S")

par(mfrow = c(2,2))
# 1st plot
with(testdata,plot(datetime,Global_active_power,type="l",xlab = "",ylab = "Global Active Power (Kilowatts)"))
# 2nd plot
with(testdata,plot(datetime,Voltage,type="l"))
# 3rd plot
with(testdata,plot((Date+Time),Sub_metering_1,type="n",xlab = "",ylab = "Energy sub metering"))
with(testdata,points((Date+Time),Sub_metering_1,type="l",col="black"))
with(testdata,points((Date+Time),Sub_metering_2,type="l",col="red"))
with(testdata,points((Date+Time),Sub_metering_3,type="l",col="blue"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),lty = 1,cex = 0.5,adj = 0.05)
# 4th plot
with(testdata,plot(datetime,Global_reactive_power,type = "h"))

dev.copy(png,file="plot4.png",width=480,height=480,units="px")
dev.off()
rm(list = (ls(pattern="^power|^test")))
