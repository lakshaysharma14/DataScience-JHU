# Exploratory Data Analysis -> Project 2 

#============================= Question-6 ===========================================#

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

subsetNEI_Baltimore <-summarise(group_by(filter(NEI, fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
subsetNEI_LosAngeles <- summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

subsetNEI_Baltimore$County <- "Baltimore City, MD"
subsetNEI_LosAngeles$County <- "Los Angeles County, CA"

Final_Emissions <- rbind(subsetNEI_Baltimore,subsetNEI_LosAngeles$County)

png("Plot6.png", width=1040, height=480)
ggplot(Final_Emissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
  geom_bar(stat="identity") + 
  facet_wrap(County~., scales="free")+
  ylab(expression("total PM"[2.5]*" Emissions in tons")) + 
  xlab("year") +
  ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles for Different Years from 1999 to 2008"))+
  geom_label(aes(fill = County),colour = "white", fontface = "bold")

dev.off()
