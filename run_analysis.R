## search for or create ".\data" directory for download
if(!file.exists(".\\data")){dir.create(".\\data")}

## link to download, downloadfile, unzip, and create file.path to main directory
fUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fUrl,destfile=".\\data\\Dataset.zip")
unzip(zipfile=".\\data\\Dataset.zip",exdir=".\\data")
fpath <- file.path(".\\data" , "UCI HAR Dataset")

## read in relevant data from test and train
testActivity <- read.table(file.path(fpath, "test", "y_test.txt"))
testMovement <- read.table(file.path(fpath, "test", "X_test.txt"))
testSubjects <- read.table(file.path(fpath, "test", "subject_test.txt"))

trainActivity <- read.table(file.path(fpath, "train", "y_train.txt"))
trainMovement <- read.table(file.path(fpath, "train", "X_train.txt"))
trainSubjects <- read.table(file.path(fpath, "train", "subject_train.txt"))

## merge data, training on top of testing
activity <- rbind(trainActivity, testActivity)
movement <- rbind(trainMovement, testMovement)
subjects <- rbind(trainSubjects, testSubjects)

## read in movment labels and activity Labels
mLab <- read.table(file.path(fpath, "features.txt"))
aLab <- read.table(file.path(fpath, "activity_labels.txt"))

## Insert Column Names
names(subjects) <- "subject"
names(activity) <- "activity"
names(movement) <- mLab$V2

## Find Desired Columns in movement, then clean column names
movement <- movement[,grep("std\\(|mean\\(", names(movement))]
names(movement) <- gsub("^t","time", names(movement))
names(movement) <- gsub("^f","frequency", names(movement))
names(movement) <- gsub("Acc","Accelerometer", names(movement))
names(movement) <- gsub("Gyro","Gyroscope", names(movement))
names(movement) <- gsub("Mag", "Magnitude", names(movement))
names(movement) <- gsub("BodyBody", "Body", names(movement))
names(movement) <- gsub("\\(\\)","",names(movement))
names(movement) <- gsub("std","standardDeviation", names(movement))

## Convert subjects and activity to factors, name levels of activity
subjects$subject <- as.factor(subjects$subject)
activity$activity <- as.factor(activity$activity)
levels(activity$activity) <- aLab$V2

## Column bind subjects, activity, and movement data
activityRecognition <- cbind(subjects,activity,movement)

## Install and Load dplyr package
install.packages("dplyr")
library(dplyr)

## Create Table Summary with Aggregate, then arrange by subject, then activity
tableSummary <- aggregate(.~subject+activity,activityRecognition,mean)
tableSummary <- arrange(tableSummary,subject,activity)

write.table(tableSummary, file="MovementActivitySummary.txt", row.name=FALSE)

