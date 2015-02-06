plot1<-function(){
  library(dplyr)
  ## Read the file, from unzipped file in working directory
  table<-read.table("household_power_consumption.txt", sep=";", na.string="?", header=TRUE)
  ## Subset file in order to keep only the lines for the 2 required days
  table<-mutate(table, Date=as.character(Date))
  sousensemble<-filter(table, Date=="1/2/2007"|Date=="2/2/2007")
  ## Draw plot 1 and save to file plot1.png
  hist(sousensemble$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
  dev.copy(png, file = "plot1.png", width = 480, height = 480)
  dev.off()
}