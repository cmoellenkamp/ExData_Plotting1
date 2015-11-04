##Plot2 for EDA Course Project1

##open png file
png(file="plot2.png")

##read in Energy Consumption table and reduce to 2-1-07 and 2-2-07
Allen<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
Allen$Date<-as.character(Allen$Date)
Allen$Time<-as.character(Allen$Time)
Allen$Time<-as.POSIXct(paste(Allen$Date,Allen$Time),format="%d/%m/%Y %H:%M:%S")
library(dplyr)
Allend<-mutate(Allen,"Date"=as.Date(Date,"%d/%m/%Y"))
feben<-Allend[Allend$Date=="2007-02-01"|Allend$Date=="2007-02-02",]

##select variable Global_active_power
gaptime<-select(feben,Date,Time,Global_active_power)
gaptime<-mutate(gaptime,"Global_active_power"=
                  as.numeric(as.character(Global_active_power)))

##create plot and format
plot(gaptime$Time,gaptime$Global_active_power,type="l",
    ylab="Global Active Power (kilowatts)",xlab=""
    )

##close device
dev.off()