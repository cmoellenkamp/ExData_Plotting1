##Plot3 for EDA Course Project1

##open png file
png(file="plot3.png")

##read in Energy Consumption table and reduce to 2-1-07 and 2-2-07
Allen<-read.table("household_power_consumption.txt",header=TRUE,sep=";")
Allen$Sub_metering_1<-as.character(Allen$Sub_metering_1)
Allen$Sub_metering_2<-as.character(Allen$Sub_metering_2)
Allen$Date<-as.character(Allen$Date)
Allen$Time<-as.character(Allen$Time)
Allen$Time<-as.POSIXct(paste(Allen$Date,Allen$Time),format="%d/%m/%Y %H:%M:%S")
library(dplyr)
Allend<-mutate(Allen,"Date"=as.Date(Date,"%d/%m/%Y"))
feben<-Allend[Allend$Date=="2007-02-01"|Allend$Date=="2007-02-02",]

##select variable Sub_metering 1 through 3
subtime<-select(feben,Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3)
subtime<-mutate(subtime,"Sub_metering_1"=as.numeric(Sub_metering_1),
                "Sub_metering_2"=as.numeric(Sub_metering_2))

##create plot and format
plot(subtime$Time,subtime$Sub_metering_3,type="n",ylim=c(0,38),
    ylab="Energy sub metering",xlab=""
    )
lines(subtime$Time,subtime$Sub_metering_1,col="black")
lines(subtime$Time,subtime$Sub_metering_2,col="red")
lines(subtime$Time,subtime$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1",
          "Sub_metering_2","Sub_metering_3"),
           col=c("black","red","blue"),lwd=1,lty=c(1,1,1)
           )

##close device
dev.off()