# Read all data sets
features <- read.table("./features.txt")
activityLabels <- read.table("./activity_labels.txt")
trainingSet <- read.table("train/X_train.txt")
trainingLabels <- read.table("train/y_train.txt")
testSet <- read.table("test/X_test.txt")
testLabels <- read.table("test/y_test.txt")
testSubject <- read.table("test/subject_test.txt")
trainSubject <- read.table("train/subject_train.txt")

# Assign names to columns
colnames(activityLabels) <- c("activityId", "activityName")
# ...for training data sets
colnames(trainSubject) <- "subjectId"
colnames(trainingSet) <- features[, 2]
colnames(trainingLabels) <- "activityId"
# ...for test data sets
colnames(testSubject) <- "subjectId"
colnames(testSet) <- features[, 2]
colnames(testLabels) <- "activityId"

# Merge the training and the test sets to create one data set
oneTrainingDataSet <- cbind(trainingLabels, trainSubject, trainingSet)
oneTestDataSet <- cbind(testLabels, testSubject, testSet)
oneDataSet <- rbind(oneTrainingDataSet, oneTestDataSet)

# Extract only the measurements on the mean and standard deviation for each measurement
colIDs <- colnames(oneDataSet) # assign column names to a vector
logicalVector <- (grepl("activity..",colIDs) |
                  grepl("subject..",colIDs) |
                  grepl("-mean..",colIDs) &
                  !grepl("-meanFreq..",colIDs) &
                  !grepl("mean..-",colIDs) |
                  grepl("-std..",colIDs) &
                  !grepl("-std()..-",colIDs))
oneDataSetMeanStd <- oneDataSet[logicalVector == TRUE] # mean & std data

oneDataSetMeanStd <- merge(oneDataSetMeanStd, activityLabels, by = "activityId") # activity names

colIDs <- colnames(oneDataSetMeanStd) # update vector with column names

# Create tidy data set with the average of
# each variable for
## each activity
### and each subject
tidyData <- aggregate(oneDataSetMeanStd,
            by = list(activityName=oneDataSetMeanStd$activityName,
            subjectId = oneDataSetMeanStd$subjectId),
            mean)

tidyData <- tidyData[, colIDs] # clean data set w/o reduntant columns

# Write data set to a txt file
write.table(tidyData, "./tidyData.txt", row.names = FALSE)Enter file contents here
