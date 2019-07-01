## GETTING AND CLEANING COURSE PROJECT
## LAKSHAY SHARMA

##Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
##The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
##A full description is available at the site where the data was obtained:

##http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##x----------------------------------------------SCRIPT--------------------------------------------------------------------x
## ====================================================================================================================

##  R package that makes it easy to transform data between wide and long formats.

library(reshape2)

##Name of the Zip Folder Dataset, downloaded and  provided by the course .

file<- "getdata_dataset.zip"

## Downloading  and unzipping  the dataset:

if (!file.exists(file))
{
  URL <- " https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(URL, file, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) 
{ 
  unzip(file) 
}

## Loading Activity Labels and Features From Dataset

actvLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actvLabels[,2] <- as.character(actvLabels[,2])

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract Data based on Mean and Standard Deviation

ftrWanted <- grep(".*mean.*|.*std.*", features[,2])
ftrWanted.names <- features[ftrWanted,2]
ftrWanted.names = gsub('-mean', 'Mean', ftrWanted.names)
ftrWanted.names = gsub('-std', 'Std', ftrWanted.names)
ftrWanted.names <- gsub('[-()]', '', ftrWanted.names)

## Loading Data from Dataset

train <- read.table("UCI HAR Dataset/train/X_train.txt")[ftrWanted]
trainActv <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")

train <- cbind(trainSub, trainActv, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[ftrWanted]
testActv <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")

test <- cbind(testSub, testActv, test)

# Merging Datasets

ReqData <- rbind(train, test)
colnames(ReqData) <- c("subject", "activity", ftrWanted.names)

## Factor variables are categorical variables that can be either numeric or string variables. 
##There are a number of advantages to converting categorical variables to factor variables. 
##Perhaps the most important advantage is that they can be used in statistical modeling 
##where they will be implemented correctly.

## Converting Activities & Subjects into Factor Variables

ReqData$activity <- factor(ReqData$activity, levels = actvLabels[,1], labels = actvLabels[,2])
ReqData$subject <- as.factor(ReqData$subject)

## There are many situations where data is presented in a format that is not ready to dive straight
##to exploratory data analysis or to use a desired statistical method. 
##The reshape2 package for R provides useful functionality to avoid having to hack data around 
##in a spreadsheet prior to import into R.

ReqData.melted <- melt(ReqData, id = c("subject", "activity"))
ReqData.mean <- dcast(ReqData.melted, subject + activity ~ variable, mean)

## Creating independent tidy data set with the average of each variable for each activity and each subject.


write.table(ReqData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
