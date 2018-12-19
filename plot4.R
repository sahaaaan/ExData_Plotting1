library(dplyr)
library(lubridate)

power <- read.table("household_power_consumptionmain.txt", header = TRUE, sep = ";", dec=".", stringsAsFactors = FALSE)

powernew <- power %>% mutate(Datenew = as.POSIXct(strptime(power$Date, format="%d/%m/%Y")))
powernew2 <- powernew %>% filter(Datenew >= "2007-02-01" & Datenew <= "2007-02-02")

powernew2$Global_active_power<- as.numeric(powernew2$Global_active_power)


powernew2$datetime <- strptime(paste(powernew2$Date, powernew2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 



#plot4
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,2), oma= c(2,2,2,0))
with(powernew2, {
  plot(datetime, Global_active_power, type="l", xlab="", ylab = "Global Active Power")
  plot(datetime, Voltage, type="l", xlab="datetime", ylab = "Voltage")
  plot(datetime, Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
  legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1",  "Sub_metering_2", "Sub_metering_3"), lty=1, cex = 0.6, bty = "n")
  plot(datetime, Global_reactive_power, type="l", xlab="datetime", ylab = "Global_reactive_power")
}
)
dev.off() 
