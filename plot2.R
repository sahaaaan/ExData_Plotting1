library(dplyr)
library(lubridate)

power <- read.table("household_power_consumptionmain.txt", header = TRUE, sep = ";", dec=".", stringsAsFactors = FALSE)

powernew <- power %>% mutate(Datenew = as.POSIXct(strptime(power$Date, format="%d/%m/%Y")))
powernew2 <- powernew %>% filter(Datenew >= "2007-02-01" & Datenew <= "2007-02-02")

powernew2$Global_active_power<- as.numeric(powernew2$Global_active_power)


powernew2$datetime <- strptime(paste(powernew2$Date, powernew2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 


#plot2
png("plot2.png", width=480, height=480)
with(powernew2, 
     plot(datetime, Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)"))
dev.off() 