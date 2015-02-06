plot4<-function(){
  library(dplyr)
  ## Read the file, from unzipped file in working directory
  table<-read.table("household_power_consumption.txt", sep=";", na.string="?", header=TRUE)
  ## Subset file in order to keep only the lines for the 2 required days
  table<-mutate(table, Date=as.character(Date))
  sousensemble<-filter(table, Date=="1/2/2007"|Date=="2/2/2007")
  ## Prepare date and time in the right format for plotting
  sousensemble<-mutate(sousensemble, Date=as.Date(Date, "%d/%m/%Y"))
  sousensemble<-mutate(sousensemble, Time=as.character(Time))
  sousensemble<-mutate(sousensemble, Date=paste(Date, Time))
  sousensemble<-transform(sousensemble, Date=strptime(Date,"%Y-%m-%d %H:%M:%S", tz = "EST"))
  ## Draw plots 4 and legend and save to file plot4.png
  png(file="plot4.png", width = 480, height = 480)
  par(mfrow=c(2,2))
  
  ## Plot the 4 graphs
  plot(sousensemble$Date, sousensemble$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="n")
  lines(sousensemble$Date, sousensemble$Global_active_power)
  plot(sousensemble$Date, sousensemble$Voltage, xlab="datetime", ylab="Voltage", type="n")
  lines(sousensemble$Date, sousensemble$Voltage)
  plot(sousensemble$Date, sousensemble$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
  lines(sousensemble$Date, sousensemble$Sub_metering_1, col="black")
  lines(sousensemble$Date, sousensemble$Sub_metering_2, col="red")
  lines(sousensemble$Date, sousensemble$Sub_metering_3, col="blue")
  legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), cex=0.64)
  plot(sousensemble$Date, sousensemble$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="n")
  lines(sousensemble$Date, sousensemble$Global_reactive_power)
  ## Close the file connection
  dev.off()
}