# read data from file
data<-read.table(file = "household_power_consumption.txt"
                 , header = TRUE
                 , sep = ";"
                 , na.strings = "?"
                 , stringsAsFactors = FALSE)

# subset data for 2 days [2007-02-01 to 2007-02-02]
data.sub<-data[as.Date(data$Date,"%d/%m/%Y")>=as.Date("01/02/2007","%d/%m/%Y") 
               & as.Date(data$Date,"%d/%m/%Y")<=as.Date("02/02/2007","%d/%m/%Y"),]

# create datetime class
data.sub.dates<-data.sub$Date
data.sub.times<-data.sub$Time
data.sub.date.time<-paste(data.sub.dates,data.sub.times)
data.sub.datetime<-strptime(data.sub.date.time, "%d/%m/%Y %H:%M:%S")

# start png graphic device
png("plot4.png")

# create plot
par(mfrow=c(2,2))

plot(data.sub.datetime
     ,data.sub$Global_active_power
     ,type="l"
     ,xlab=""
     ,ylab="Global Active Power")

plot(data.sub.datetime
     ,data.sub$Voltage
     ,type="l"
     ,xlab="datetime"
     ,ylab="Voltage")

plot(data.sub.datetime
     ,data.sub$Sub_metering_1
     ,type="l"
     ,xlab=""
     ,ylab="Energy sub metering")
points(data.sub.datetime
       ,data.sub$Sub_metering_2
       ,type="l"
       ,col="red")
points(data.sub.datetime
       ,data.sub$Sub_metering_3
       ,type="l"
       ,col="blue")
legend("topright"
       ,lty=c(1,1,1)
       ,col=c("black","red","blue")
       ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(data.sub.datetime
     ,data.sub$Global_reactive_power
     ,type="l"
     ,xlab="datetime"
     ,ylab="Global_reactive_power")

# flush plot to png graphic device
dev.off()
