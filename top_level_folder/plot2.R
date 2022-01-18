library(dplyr)
library(sqldf)

download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 
              destfile = 'downloaded_file.zip')
unzip('downloaded_file.zip')

df <- read.csv.sql("household_power_consumption.txt",
                   sql = "select * from file where `Date` == '1/2/2007' or (`Date` == '2/2/2007')",
                   sep = ';', eol = "\n")

df$date_and_time <- paste(df$Date,df$Time)

df <- mutate(df, week_days = weekdays(strptime(date_and_time, "%d/%m/%Y %H:%M:%S")))
df <- mutate(df, exact_date_and_time = strptime(df$date_and_time, "%d/%m/%Y %H:%M:%S"))


png(file="./plot2.png",
    width=480, height=480)
plot(df$exact_date_and_time, df$Global_active_power,  
     xlab = '', ylab = 'Global Active Power (kilowatts)', type = 'l')
dev.off()