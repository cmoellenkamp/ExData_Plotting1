##Plot1 for EDA Course Project1

##open png file
png(file="plot1.png")

##read in Energy Consumption table and reduce to 2-1-07 and 2-2-07
Allen<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
library(dplyr)
Allend<-mutate(Allen,"Date"=as.Date(Date,"%d/%m/%Y"))
feben<-Allend[Allend$Date=="2007-02-01"|Allend$Date=="2007-02-02",]

##select variable Global_active_power
gap<-select(feben,Date,Global_active_power)
gap<-mutate(gap,"Global_active_power"=as.numeric(as.character(Global_active_power)))

##create histogram and add format plot
hist(gap$Global_active_power,
    xlab="Global Active Power (kilowatts)",
    col="red",main="Global Active Power"
    )

##close device
dev.off()
