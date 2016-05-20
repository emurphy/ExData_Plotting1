library(data.table)

# Dowload and unzip dataset, unless the unzipped file already exists
if (!file.exists("household_power_consumption.txt")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, "exdata-data-household_power_consumption.zip")
    unzip("exdata-data-household_power_consumption.zip")
}

df <- fread("household_power_consumption.txt", na.strings="?")

df$DateType = as.Date(df$Date, "%d/%m/%Y")
df <- df[df$DateType == "2007-02-01" | df$DateType == "2007-02-02",]

df <- transform(df, DateTime=strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))

png("plot2.png")

with(df, plot(DateTime, Global_active_power, main="", xlab="", ylab="Global Active Power (kilowatts)", type='l'))

dev.off()
