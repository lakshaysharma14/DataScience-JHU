# Exploratory Data Analysis -> Project 2 

#============================= Question-3 ===========================================#

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

NEI <- readRDS("./EDA_C4_P2/summarySCC_PM25.rds")
SCC <- readRDS("./EDA_C4_P2/Source_Classification_Code.rds")
subsetNEI  <- NEI[NEI$fips=="24510", ]

aggregateData_Year_Type <- aggregate(Emissions ~ year + type, subsetNEI, sum)

png("Plot3.png", width=640, height=480)
g <- ggplot(aggregateData_Year_Type,aes(x=factor(year), Emissions, color = type,fill=type,label = round(Emissions,2)))

g <- g + geom_bar(stat="identity") + facet_grid(. ~ type) + xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008 for Different Source Types')

print(g)
dev.off()