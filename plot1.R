library(data.table)

# Dowload and unzip dataset, unless the unzipped file already exists
if (!file.exists("household_power_consumption.txt")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, "exdata-data-household_power_consumption.zip")
    unzip("exdata-data-household_power_consumption.zip")
}

df <- fread("household_power_consumption.txt", na.strings="?")
df$Date = as.Date(df$Date, "%d/%m/%Y")

df <- df[df$Date == "2007-02-01" | df$Date == "2007-02-02",]

with(df, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
