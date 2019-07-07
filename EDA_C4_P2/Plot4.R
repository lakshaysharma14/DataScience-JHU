# Exploratory Data Analysis -> Project 2 

#============================= Question-4 ===========================================#

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
#xx------------------------------------------------------------------------------------xx
library(ggplot2)
library(dplyr)

NEI <- readRDS("./EDA_C4_P2/summarySCC_PM25.rds")
SCC <- readRDS("./EDA_C4_P2/Source_Classification_Code.rds")
subsetNEI  <- NEI[NEI$fips=="24510", ]

if(!exists("NEISCC"))
{
  NEISCC <- inner_join(NEI, SCC, by="SCC")
}

reqData <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[reqData, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

png("plot4.png", width=640, height=480)

g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions/1000 , fill=year,label = round(Emissions/1000,2) ))

g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions Kilotons")) +
  ggtitle('Total Emissions from Coal Combustion Related Sources from 1999 to 2008 in Kilotons') +
  geom_label(aes(fill = year),colour = "white", fontface = "bold")
print(g)
dev.off()

