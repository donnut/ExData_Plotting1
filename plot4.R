library(dplyr)
library(lubridate)

# assure English labels texts
Sys.setlocale("LC_TIME", "en_US.utf8")

data <- read.csv("household_power_consumption.txt", header = TRUE, na.strings = "?", sep=";")

df <- tbl_df(data)

# create on time-date colum
df <- mutate(df, DT = dmy(Date) + hms(Time))

# reduce the period 
period <- filter(df, dmy(Date) %in% c(dmy("1/2/2007", "2/2/2007")))

#plot 4
png(file="plot4.png")
par(mfrow=c(2,2))
with(period, {
  plot(DT, Global_active_power, type="l", xlab = "",  ylab = "Global Active Power")
  plot(DT, Voltage, type="l", xlab="datetime")
  plot(DT, Sub_metering_1, type="n", xlab = "", ylab="Energy Sub Metering")
  lines(DT, Sub_metering_1, col="black")
  lines(DT, Sub_metering_2, col="red")
  lines(DT, Sub_metering_3, col="blue")
  legend("topright", cex=0.8, lty=c(1,1,1), bty="n", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DT, Global_reactive_power, type="l", xlab="datetime")
})
dev.off()