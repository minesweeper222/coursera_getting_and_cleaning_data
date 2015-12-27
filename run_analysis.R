#You should create one R script called run_analysis.R that does the following. 
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# load package reshape2 to use melt function 
library(reshape2)

#Merges the training and the test sets to create one data set.

# read train and test data from file
trainDataX <- read.table("data\\train\\X_train.txt")
testDataX <- read.table("data\\test\\X_test.txt")

trainDataY <- read.table("data\\train\\Y_train.txt")
testDataY <- read.table("data\\test\\Y_test.txt")

trainDataSubject  <- read.table("data\\train\\subject_train.txt")
testDataSubject <- read.table("data\\test\\subject_test.txt")

# merge train and test data
mergedDataX <- rbind(trainDataX, testDataX)
mergedDataY <- rbind(trainDataY, testDataY)
mergedDataSubject <- rbind(trainDataSubject, testDataSubject)

#Extracts only the measurements on the mean and standard deviation for each measurement. 

# read features table
features <- read.table("data\\features.txt")

# get only columns with mean() and std() texts in the features
meanStdColumns <- grep("mean\\(\\)|std\\(\\)",features$V2)

# subset with only columns containing mean and std
meanStdDataX <- mergedDataX[,meanStdColumns]

#Uses descriptive activity names to name the activities in the data set

# read activity table
activityLabel <- read.table("data\\activity_labels.txt")

# get descriptive names for Y data
activityLabels <- activityLabel[mergedDataY[, 1],2]

# change Label name for Y data
mergedDataY[, 1] <- activityLabels

#Appropriately labels the data set with descriptive variable names. 

# assign column names to X data 
names(meanStdDataX) <- features[meanStdColumns,2]

# rename columns of X data so that mean() becomes Mean and std() becomes StandardDeviation
columnNames <- colnames(meanStdDataX)
columnNames <- gsub("mean\\(\\)", "Mean", columnNames)
columnNames <- gsub("std\\(\\)", "StandardDeviation", columnNames)
colnames(meanStdDataX) <- columnNames

#From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.

# assign column names to Y and Subject data
names(mergedDataSubject) <- "Subject"
names(mergedDataY) <- "Activity"

# merge X, Y and Subject data
mergedDataFinal <- cbind(mergedDataSubject, mergedDataY, meanStdDataX)

# melt data for subject and activity
meltedData <- melt(mergedDataFinal, id=c("Subject","Activity"), measure.vars=colnames(meanStdDataX))

# group merged data by Subject and Activity and calculate mean of variables
tidyData <- dcast(meltedData, Subject+Activity ~ variable, mean)

# write into file tidyData.txt
write.table(tidyData, file = "data\\tidyData.txt", row.names = FALSE)

