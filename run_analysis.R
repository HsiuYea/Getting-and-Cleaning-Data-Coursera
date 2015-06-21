## *****************************************************************************
## Created By : Sylvia Ong
## Created Date : 20 June 2015
## Created For : Coursera Getting and Cleaning Data Course Project
## *****************************************************************************

library(dplyr)

## Project files downloaded and unzip into R Project Working Directory
## Load in Raw Data from main UCI HAR Dataset Folders
training = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

testing = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)


features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

## **********************************************************************
## Step 1 : Merges the training and the test sets to create one data set
## **********************************************************************

allData = rbind(training, testing)

## *************************************************************************************************
## Step 2 : Extracts only the measurements on the mean and standard deviation for each measurement.
## *************************************************************************************************

MeanStdData <- grep(".*Mean.*|.*Std.*", features[,2])


## ************************************************************************************ 
## Step 3 : Uses descriptive activity names to name the activities in the data set
## ************************************************************************************
# First reduce the features table to what we want
features <- features[MeanStdData,]
# Now add the last two columns (subject and activity)
MeanStdData <- c(MeanStdData, 562, 563)
# And remove the unwanted columns from allData
allData <- allData[,MeanStdData]
# Add the column names (features) to allData
colnames(allData) <- c(features$V2, "Activity", "Subject")
colnames(allData) <- tolower(colnames(allData))

currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity)
  currentActivity <- currentActivity + 1
}

allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)

## ************************************************************************************ 
## Step 4 : Appropriately labels the data set with descriptive variable names. 
## ************************************************************************************
names(allData) <- gsub('\\(|\\)',"",names(allData), perl = TRUE)
names(allData) <- make.names(names(allData))
names(allData) <- gsub('Acc',"Acceleration",names(allData))
names(allData) <- gsub('GyroJerk',"AngularAcceleration",names(allData))
names(allData) <- gsub('Gyro',"AngularSpeed",names(allData))
names(allData) <- gsub('Mag',"Magnitude",names(allData))
names(allData) <- gsub('^t',"TimeDomain.",names(allData))
names(allData) <- gsub('^f',"FrequencyDomain.",names(allData))
names(allData) <- gsub('\\.mean',".Mean",names(allData))
names(allData) <- gsub('\\.std',".StandardDeviation",names(allData))
names(allData) <- gsub('Freq\\.',"Frequency.",names(allData))
names(allData) <- gsub('Freq$',"Frequency",names(allData))


## **************************************************************************************************
## Step 5 : From the data set in step 4, creates a second, independent tidy data set with the average ##of each variable for each activity and each subject.
## **************************************************************************************************

tidy_data = aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean)
# Remove the subject and activity column, since a mean of those has no use
tidy_data[,90] = NULL
tidy_data[,89] = NULL
write.table(tidy_data, "tidy_data.txt", sep="\t")