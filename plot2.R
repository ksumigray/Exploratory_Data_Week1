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

#Generate plot
with(filtered_dates, plot(merged_date, Global_active_power, type='l', xlab="", ylab="Global Active Power (kilowatts)"))

#Save as png
dev.copy(png, 'plot2.png')
dev.off()
