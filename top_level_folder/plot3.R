library(dplyr)
library(sqldf)

download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 
              destfile = 'downloaded_file.zip')
unzip('downloaded_file.zip')

df <- read.csv.sql("household_power_consumption.txt",
                   sql = "select * from file where `Date` == '1/2/2007' or (`Date` == '2/2/2007')",
                   sep = ';', eol = "\n")

df$date_and_time <- paste(df$Date,df$Time)
df <- mutate(df, exact_date_and_time = strptime(df$date_and_time, "%d/%m/%Y %H:%M:%S"))

png(file="./plot3.png",
    width=480, height=480)
plot(df$exact_date_and_time, df$Sub_metering_1,  
     xlab = '', ylab = 'Energy sub metering', type = 'l')
lines(df$exact_date_and_time, df$Sub_metering_2,  
     xlab = '', ylab = 'Energy sub metering', type = 'l', col = 'red')
lines(df$exact_date_and_time, df$Sub_metering_3,  
     xlab = '', ylab = 'Energy sub metering', type = 'l',  col = 'blue')
legend('topright', legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c('black',"red", "blue"), lty=1)
dev.off()