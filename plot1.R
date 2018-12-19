library(dplyr)
library(lubridate)

power <- read.table("household_power_consumptionmain.txt", header = TRUE, sep = ";", dec=".", stringsAsFactors = FALSE)

powernew <- power %>% mutate(Datenew = as.POSIXct(strptime(power$Date, format="%d/%m/%Y")))
powernew2 <- powernew %>% filter(Datenew >= "2007-02-01" & Datenew <= "2007-02-02")

powernew2$Global_active_power<- as.numeric(powernew2$Global_active_power)


#plot1
png("plot1.png", width=480, height=480)
with(powernew2, hist(Global_active_power,
                     col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
)
dev.off() 