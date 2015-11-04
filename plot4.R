##Plot4 for EDA Course Project1

##open png file
png(file="plot4.png")

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

##select variable Global_active_power
gaptime<-select(feben,Date,Time,Global_active_power)
gaptime<-mutate(gaptime,"Global_active_power"=
                  as.numeric(as.character(Global_active_power)))

##select variable Sub_metering 1 through 3
subtime<-select(feben,Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3)
subtime<-mutate(subtime,"Sub_metering_1"=as.numeric(Sub_metering_1),
                "Sub_metering_2"=as.numeric(Sub_metering_2))

##select variable Global_reactive_power
reactime<-select(feben,Date,Time,Global_reactive_power)
reactime<-mutate(reactime,"Global_reactive_power"=
                   as.numeric(as.character(Global_reactive_power)))

##select Variable Voltage
voltime<-select(feben,Date,Time,Voltage)
voltime<-mutate(voltime,"Voltage"=
                   as.numeric(as.character(Voltage)))

##create parameters for 4 panel plot
par(mfcol=c(2,2))

##create plot for gaptime and format
plot(gaptime$Time,gaptime$Global_active_power,type="l",
     ylab="Global Active Power (kilowatts)",xlab=""
     )

##create plot for Submetering 1 through 3 and format
plot(subtime$Time,subtime$Sub_metering_3,type="n",ylim=c(0,38),
    ylab="Energy Sub metering",xlab=""
    )
lines(subtime$Time,subtime$Sub_metering_1,col="black")
lines(subtime$Time,subtime$Sub_metering_2,col="red")
lines(subtime$Time,subtime$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1",
          "Sub_metering_2","Sub_metering_3"),
           col=c("black","red","blue"),lwd=1,lty=c(1,1,1)
           )

##create plot for Voltage and format
plot(voltime$Time,voltime$Voltage,type="l",
     ylab="Voltage",xlab="datetime"
)


##create plot for Reactime and format
plot(reactime$Time,reactime$Global_reactive_power,type="l",
     ylab="Global_reactive_time",xlab="datetime"
     )

##close device
dev.off()