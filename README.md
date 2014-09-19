Getting-and-Cleaning-Data-Course-Project
========================================

Code run_analysis.R does the following tasks:
- merges the training and the test sets to create one data set
- extracts only the measurements on the mean and standard deviation for each measurement
- uses descriptive activity names to name the activities in the data set
- appropriately labels the data set with descriptive activity names
- creates a second, independent tidy data set with the average of each variable for each activity and each subject

The code runs under the assumption that the data is downloaded and unzipped to a local folder.
- source data address: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- download.file() and unzip() used

Code "walk-through" and functions used:
- data is read to R for analysis with read.table() function
- descriptive activity names are found in file activity_labels.txt
- merging is done with cbind() and rbind() to get to a combined data set
- grepl() used to identify and create a "pointer" vector with columns with mean and std deviations data
- tidy data set (tidyData) is created with aggregate() function
- data set written in a .tx file with the same name "tidyData.txt"
