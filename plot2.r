#########################################################
# Plot 2
#########################################################

Sys.setlocale("LC_TIME", "english") # to have the caption in english
dataset.row1 <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrow = 1) # read the first line of the dataset
columnnames <- names(dataset.row1) # names of the dataset columns
nc <- ncol(dataset.row1) # number of columns

# read the first column to find out which rows are needed
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep=";", colClasses=c(NA, rep("NULL",nc-1)))
dataset.col1 <- as.Date(dataset$Date, format="%e/%m/%Y")
ns <- which.max(dataset.col1 >= "2007-02-01") # 1st line of the subset we are interested in
ne <- which.max(dataset.col1 > "2007-02-02") # line right after the end of the subset we are interested in

# use the variables ns and ne to read only the lines we are interested in 
dataset <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrow = ne-ns, skip=ns-1, col.names=columnnames, colClasses=c("character", "character", rep("numeric",nc-2)))

# construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename="plot2.png", width = 480, height = 480, units = "px", bg = "transparent") # not sure if the background was white or transparent 
# Combine the column of dates with the column of times
DateTime <- as.POSIXlt(paste(dataset$Date,as.character(dataset$Time)), format="%e/%m/%Y %H:%M:%S") 
plot(DateTime, dataset$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(DateTime, dataset$Global_active_power) 
dev.off()