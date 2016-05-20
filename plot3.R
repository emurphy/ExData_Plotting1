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

png("plot3.png")

with(df, plot(DateTime, Sub_metering_1, main="", xlab="", ylab="Energy sub metering", type='l'))
with(df, lines(DateTime, y=Sub_metering_2, col="red"))
with(df, lines(DateTime, y=Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.off()
