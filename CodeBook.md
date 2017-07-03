CodeBook
==============

run_analysis.R takes data from:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
{README.txt associate with data useful to peruse. In short: data collected from accelerometers
and gyros in a smartphone as 30 subjects perfrom 6 different physical activities, e.g. walking, standing,
walking up stairs.}

From the folders "test" and "train" it reads
* "y_train.txt" "X_train.txt" "subject_train.txt"
* "y_test.txt" "X_test.txt" "subject_test.txt"

First combine data from "test" and "train phases. e.g. subject_train joined with subject_test resulting in
three objects: 
* activity (y_train & y_test)
* movement (X_train & X_test)
* subjects (subject_train & subject_test)

Change names, the one variable in "subjects" to "subject", the variable in "activity" to "activity"
read variable names from "features.txt" and assign to variable names in "movement"

subjects contain subject codes (1-30), set as.factor
activity contains activity codes (1-6) set as.factor assign to varible names found in "activity_labels.txt"

Find desired columns in "movement" that contain "mean()" or "std()" and trim "movement" to just those columns
Clean up variable names in "movement" to :
* Either "time" or "frequency" referring to type of data collected.
* "Body" or "Gravity" referring to source of movement
* "Accelerometer" or "Gyroscope" reffing to source of measurement
* then MAYBE "Jerk" and/or "Magnitude" referring to type of measure
* then "mean" or "standardDeviation" referring to type of aggregation
* then MAYBE "X", "Y", or "Z" referring to direction of movement measured
66 movement variables named according to this system

Finally create "tableSummary" which aggregates the mean of each measured movement variable according to
subject and activity type.
Arrange "tableSummary" by subject then activity.
write "tableSummary" to text file "MovementActivitySummary.txt")



Column bind subjects, activity, and movement data
