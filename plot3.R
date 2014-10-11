library(dplyr)

epc <-
  readLines(pipe("egrep '^(Date|[12]/2/2007)' household_power_consumption.txt")) %>%
  textConnection() %>%
  read.csv(header=T, sep=";", na.strings="?") %>%
  tbl_df %>%
  mutate(
    datetimechar = paste(as.character(Date), as.character(Time)),
    datetime = as.POSIXct(strptime(datetimechar, "%d/%m/%Y %H:%M:%S")))

png('plot3.png')
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
       lty=c(1,1))
dev.off()