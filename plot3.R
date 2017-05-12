#load necessary libraries
library(tidyr)
library(lubridate)
#Read data
energy <- read.table("./household_power_consumption.txt", na.strings="?", sep=";", header=TRUE)

#Merge date and time to make one column
date_time <- unite(energy, merged_date, Date:Time, sep=",")

#Convert to date/time object
date_time$merged_date <- dmy_hms(date_time$merged_date)

#Filter dates
filtered_dates <- date_time[grepl("2007-02-0[1-2]", date_time$merged_date),]

#Generate plots
with(filtered_dates, plot(merged_date, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(filtered_dates, lines(merged_date, Sub_metering_1, col="black"))
with(filtered_dates, lines(merged_date, Sub_metering_2, col="red"))
with(filtered_dates, lines(merged_date, Sub_metering_3, col="blue"))

#Add legend
legend("topright", lwd=1, col=c('black', 'red', 'blue'), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save as png
dev.copy(png, "plot3.png")
dev.off()
