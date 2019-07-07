# Exploratory Data Analysis -> Project 2 

#============================= Question-2 ===========================================#

# First Set the Working Directory

setwd("C:/Users/LAKSHAY/Desktop/ExpDataAnaly_C4_P2")
projectUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Checking File if it Exist and then Downloading the Zip Data .

if(!file.exists("./EDA_C4_P2"))
{
  dir.create("./EDA_C4_P2")
  download.file(projectUrl,destfile = "./EDA_C4_P2/exdata_data_NEI_data.zip",method="auto")
  
  zipData <- "exdata-data-NEI_data.zip"
  
  zipF<- "C:/Users/LAKSHAY/Desktop/ExpDataAnaly_C4_P2/EDA_C4_P2/exdata_data_NEI_data.zip"
  outDir<-"C:/Users/LAKSHAY/Desktop/ExpDataAnaly_C4_P2/EDA_C4_P2"
  
  unzip(zipF,exdir=outDir)
}

NEI <- readRDS("./EDA_C4_P2/summarySCC_PM25.rds")
SCC <- readRDS("./EDA_C4_P2/Source_Classification_Code.rds")

#xx------------------------------------------------------------------------------------xx
subsetNEI  <- NEI[NEI$fips=="24510", ]
aggregateData <- aggregate(Emissions~year,subsetNEI,sum)

png("Plot2.png")
clrs <- c("red", "orange", "pink", "yellow")
barplot(height = aggregateData$Emissions, names.arg=aggregateData$year, xlab="Different Years", ylab=expression('total PM'[2.5]*' Emission in Kilotons'),ylim=c(0,4000),main=expression('Total PM'[2.5]*' Emissions in the Baltimore City, MD For Different Years'),col=clrs)
dev.off()

