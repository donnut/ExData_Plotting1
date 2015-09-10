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

# plot 3
png(file="plot3.png")
with(period, {
  plot(DT, Sub_metering_1, type="n", xlab = "", ylab="Energy Sub Metering")
  lines(DT, Sub_metering_1, col="black")
  lines(DT, Sub_metering_2, col="red")
  lines(DT, Sub_metering_3, col="blue")
  legend("topright", cex=0.8, lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()