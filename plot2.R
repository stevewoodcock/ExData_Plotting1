library(dplyr)

epc <-
  readLines(pipe("egrep '^(Date|[12]/2/2007)' household_power_consumption.txt")) %>%
  textConnection() %>%
  read.csv(header=T, sep=";", na.strings="?") %>%
  tbl_df %>%
  mutate(
    datetimechar = paste(as.character(Date), as.character(Time)),
    datetime = as.POSIXct(strptime(datetimechar, "%d/%m/%Y %H:%M:%S")))

png('plot2.png')
with(epc,
     plot(datetime, Global_active_power,
          type="l",
          ylab="Global Active Power (kilowatts)",
          xlab=""))
dev.off()