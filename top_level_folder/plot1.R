library(sqldf)

download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 
              destfile = 'downloaded_file.zip')
unzip('downloaded_file.zip')

df <- read.csv.sql("household_power_consumption.txt",
                      sql = "select * from file where `Date` == '1/2/2007' or (`Date` == '2/2/2007')",
                      sep = ';', eol = "\n")

png(file="./plot1.png",
    width=480, height=480)
hist(df$Global_active_power, breaks = 11, col = '#ff2500', 
     xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')
dev.off()