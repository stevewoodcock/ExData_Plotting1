library(dplyr)

epc <-
  readLines(pipe("egrep '^(Date|[12]/2/2007)' household_power_consumption.txt")) %>%
  textConnection() %>%
  read.csv(header=T, sep=";", na.strings="?") %>%
  tbl_df %>%
  mutate(
    datetimechar = paste(as.character(Date), as.character(Time)),
    datetime = as.POSIXct(strptime(datetimechar, "%d/%m/%Y %H:%M:%S")))

png('plot4.png')
par(mfrow=c(2,2))

with(epc,
     plot(datetime, Global_active_power,
          type="l",
          ylab="Global Active Power",
          xlab=""))

with(epc,
     plot(datetime, Voltage,
          type="l",
          ylab="Voltage"))

with(epc,
     plot(datetime, Sub_metering_1,
          type="l",
          ylab="Energy sub metering",
          xlab=""))
lines(epc$datetime, epc$Sub_metering_2, col="red")
lines(epc$datetime, epc$Sub_metering_3, col="blue")
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=c(1,1),
       bty="n")

with(epc,
     plot(datetime, Global_reactive_power,
          type="l"))

dev.off()