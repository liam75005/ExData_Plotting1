plot2<-function(){
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
  ## Draw plot 2 and save to file plot2.png
  plot(sousensemble$Date, sousensemble$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="n")
  lines(sousensemble$Date, sousensemble$Global_active_power)
  dev.copy(png, file = "plot2.png", width = 480, height = 480)
  dev.off()
}