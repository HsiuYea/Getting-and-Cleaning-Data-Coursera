# Getting-and-Cleaning-Data-Coursera
Getting-and-Cleaning-Data Course from Coursera

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In the repository, it will contain one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Detail explaination:

Transformation:
1. Read trainings files (X_train.txt, Y_train.txt, subject_train.txt) from "UCI HAR Dataset/train folder" and store them into 1 variable name training
2. Read testing files (X_test.txt, Y_test.txt, subject_test.txt)  from "UCI HAR Dataset/test folder" and store them into 1 variable name testing
3. Read activity labels file (activity_labels.txt) from main "UCI HAR Dataset" folder and store into 1 variable name activityLabels
4. Read features file (features.txt) from main "UCI HAR Dataset" folder and store into 1 variable name features
5. Merges training and test sets into 1 variable name allData
6.  Get the subset of data contain Mean and Std and store into 1 variable name MeanStdData
7. Add 2 new columns - Activity and Subject
8. Assign descriptive name from activity labels to name the activities
9. Labels data set with descriptive variable names
10. Creates a second independent tidy data and write into tidy_data.txt in current working directory

