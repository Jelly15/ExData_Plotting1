#########################################################
# Plot 4
#########################################################

Sys.setlocale("LC_TIME", "english") # to have the caption in english
dataset.row1 <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrow = 1) # read the first line of the dataset
columnnames <- names(dataset.row1) # names of the dataset columns
nc <- ncol(dataset.row1) # number of columns

# read the date column to find the number of the lines we want to study
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep=";", as.is= FALSE, colClasses=c(NA, rep("NULL",nc-1)))

dataset.col1 <- as.Date(dataset$Date, format="%e/%m/%Y")
ns <- which.max(dataset.col1 >= "2007-02-01") # 1st line of the subset we are interested in
ne <- which.max(dataset.col1 > "2007-02-02") # line right after the end of the subset we are interested in

# use the variables ns and ne to read only the lines we are interested in 
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrow = ne-ns, skip=ns-1, col.names=columnnames, stringsAsFactors=FALSE)

# construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename="plot4.png", width = 480, height = 480, units = "px", bg = "white")
# divide the space into 4 cells
par(mfrow=c(2,2))
# Combine the column of dates with the column of times
DateTime <- as.POSIXlt(paste(dataset$Date,as.character(dataset$Time)), format="%e/%m/%Y %H:%M:%S") 
# 1st graph
plot(DateTime, dataset$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(DateTime, dataset$Global_active_power) 
# 2nd graph
plot(DateTime, dataset$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(DateTime, dataset$Voltage) 
# 3rd graph
plot(DateTime, dataset$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
lines(DateTime, dataset$Sub_metering_1, col="black")
lines(DateTime, dataset$Sub_metering_2, col="red")
lines(DateTime, dataset$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")
# 4th graph
plot(DateTime, dataset$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(DateTime, dataset$Global_reactive_power) 
dev.off()