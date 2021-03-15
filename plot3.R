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

png('plot3.png', width = 480, height = 480)
plot(HPC2$DateTime,
     as.numeric(HPC2$Sub_metering_1),
     type = 'l',
     col = 'black',
     ylab = 'Energy sub metering',
     xlab = '')
lines(HPC2$DateTime,
      as.numeric(HPC2$Sub_metering_2),
      type = 'l',
      col = 'red')
lines(HPC2$DateTime,
      as.numeric(HPC2$Sub_metering_3),
      type = 'l',
      col = 'blue')

# add legend

legend('topright',
       col = c('black', 'red', 'blue'),
       lwd = 1,
       legend = (c('Sub_metering_1',
                  'Sub_metering_2',
                  'Sub_metering_3')))

# output

dev.off()