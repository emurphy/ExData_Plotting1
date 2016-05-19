# Dowload and unzip dataset, unless the unzipped file already exists
if (!file.exists("household_power_consumption.txt")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, "exdata-data-household_power_consumption.zip")
    unzip("exdata-data-household_power_consumption.zip")
}


