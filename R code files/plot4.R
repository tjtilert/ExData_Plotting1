
#######################################################
# Set the working directory
#######################################################
setwd("~/Dropbox/Coursera/Exploratory Data Analysis/Data")


#######################################################
# Read in the data file - 
#  use classes and # of records for efficiency
#######################################################
classes=c(Date ="character", 
          Time ="character",
          Global_active_power = "numeric", 
          Global_reactive_power = "numeric",
          Voltage = "numeric",
          Global_intensity = "numeric",
          Sub_metering_1 = "numeric",
          Sub_metering_2 = "numeric",
          Sub_metering_3 = "numeric")

hpc1 <- read.table("household_power_consumption.txt", header = TRUE, 
          sep=";", na.strings="?", colClasses = classes, nrows = 2075259)

str(hpc1)
summary(hpc1)


#######################################################
# Convert character dates and times to a single R 
# datetime (POSIXct) value, then subset only two dates:
# 2007-02-01 and 2007-02-02
#######################################################
hpc1$r_datetime = as.POSIXct(paste(hpc1$Date, hpc1$Time), format="%d/%m/%Y %H:%M:%S")
hpc = subset(hpc1, Date == "1/2/2007" | Date == "2/2/2007")


#######################################################
# Create the fourth plot (plot4.png)
#######################################################
setwd("~/Documents/ExData_Plotting1/plot files")
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

# plot(1,1) = plot #2 but no "(kilowatts)" in y-axis label
par(mar=c(5.1,4.1,3.1,1.1))
plot(hpc$r_datetime, hpc$Global_active_power, xlab=NA, ylab="Global Active Power",
     type="o", pch=NA)

# plot(1,2) = similar to plot #2 but voltage vs datetime and 
#             x-axis label = "datetime"
par(mar=c(5.1,5.1,3.1,0.2))
plot(hpc$r_datetime, hpc$Voltage, xlab="datetime", ylab="Voltage",
     type="o", pch=NA)

# plot(2,1) = plot #3 but no box around the legend
par(mar=c(4.1,4.1,4.1,1.1))
with(hpc, plot(r_datetime, Sub_metering_1, xlab=NA, ylab="Energy sub metering",
               type="o", pch=NA))
with(hpc,lines(r_datetime, Sub_metering_2, col="red", pch=NA)) 
with(hpc,lines(r_datetime, Sub_metering_3, col="blue", pch=NA)) 
legend("topright", lty=c(1,1,1), lwd=c(1,1,1), col = c("black","blue","red"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n")

# plot(2,2) = similar to plot #2 but Global_reactive_power vs datetime and 
#             x-axis label = "datetime"
par(mar=c(4.1,5.1,4.1,0.2))
plot(hpc$r_datetime, hpc$Global_reactive_power, xlab="datetime", 
     ylab="Global_reactive_power", type="o", pch=NA)

dev.off()

