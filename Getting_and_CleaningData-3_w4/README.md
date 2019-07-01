# **Getting and Cleaning Data - Course Project** 

### This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the activity and feature Information from the Dataset
3. Loads both the training and test Datasets, based on columns related to mean or standard deviation
4. Loads the activity and subject data for each Dataset, and merges those columns with the Dataset
5. Merges the Two datasets train and test.
6. Converts the activity and subject columns into factor variables.
7. Creates a tidy dataset that consists of the mean value of each variable for each subject and activity pair.
8. The end result is shown in the file tidy.txt.
