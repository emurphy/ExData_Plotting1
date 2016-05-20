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

png("plot4.png")

par(mfcol=c(2,2))

# similar to plot 2 -- global active power
with(df, plot(DateTime, Global_active_power, main="", xlab="", ylab="Global Active Power", type='l'))    

# similar to plot 3 -- sub metering
with(df, plot(DateTime, Sub_metering_1, main="", xlab="", ylab="Energy sub metering", type='l'))
with(df, lines(DateTime, y=Sub_metering_2, col="red"))
with(df, lines(DateTime, y=Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), box.lty=0)

# new plot 4 -- voltage
with(df, plot(DateTime, Voltage, main="", xlab="datetime", ylab="Voltage", type='l'))    

# new plot 5 -- global reactive powewr
with(df, plot(DateTime, Global_reactive_power, main="", xlab="datetime", type='l'))    

dev.off()
