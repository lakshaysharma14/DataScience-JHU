# Exploratory Data Analysis -> Project 2 

#============================= Question-1 ===========================================#

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

aggregateData <- aggregate(Emissions~year,NEI,sum)
png("Plot1.png")
clrs <- c("red", "orange", "pink", "yellow")
barplot(height=aggregateData$Emissions/1000, names.arg=aggregateData$yea, xlab="Different Years", ylab=expression('total PM'[2.5]*' Emission in Kilotons'),ylim=c(0,8000),main=expression('Total PM'[2.5]*' Emissions For Different Years'),col=clrs)
dev.off()





