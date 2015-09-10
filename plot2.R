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

# plot 2
png(file="plot2.png")
with(period, plot(DT, Global_active_power, type="l", xlab = "",  ylab = "Global Active Power (kilowatts)"))
dev.off()