#########################################################
# Plot 1
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
png(filename="plot1.png", width = 480, height = 480, units = "px", bg = "white") # not sure if the background was white or transparent
hist(as.numeric(dataset$Global_active_power), breaks=12, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()