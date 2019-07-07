# Exploratory Data Analysis -> Project 2 

#============================= Question-5 ===========================================#

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
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

if(!exists("NEISCC"))
{
  NEISCC <- inner_join(NEI, SCC, by="SCC")
}

aggregate_Year <- aggregate(Emissions ~ year, subsetNEI, sum)

png("Plot5.png", width=840, height=480)
g <- ggplot(aggregate_Year, aes(factor(year), Emissions ,fill=year ,label = round(Emissions,2) ))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from Motor Vehicle in Baltimore City, Maryland from 1999 to 2008')+
  geom_label(aes(fill = year),colour = "black", fontface = "bold")

print(g)
dev.off()




