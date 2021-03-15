# download and extract file

if (!file.exists('data.zip')) {
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile = './data.zip')
  unzip('data.zip')
}

# read data

HPC <- read.csv('household_power_consumption.txt', sep = ';', na.strings = '?', header = TRUE)

# coerce date and time to new field DateTime

HPC$DateTime <- strptime(paste(HPC$Date, HPC$Time), format = '%d/%m/%Y %H:%M:%S')

# convert to date format

HPC$Date <- as.Date(HPC$Date, format = '%d/%m/%Y')

# subset data for dates 2007-02-01 and 2007-02-02

HPC2 <- HPC[which(HPC$Date %in% c(as.Date('2007-02-01'), as.Date('2007-02-02'))),]

# plot data

png('plot1.png', width = 480, height = 480)
hist(as.numeric(HPC2$Global_active_power),
     main = 'Global Active Power',
     col = 'red',
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency')

# output

dev.off()