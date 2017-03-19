# Coursera Course Project - Getting and Cleaning Data

## Introduction
This Coursera course project contains R script and code book documents for

## Requirments
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

`
Dataset website
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
`

`
Dataset dwnload URL
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`


## Project steps outline

* Clone this git project to your local machine.
* ```cd``` to project folder.
* Set the ```WORKING_DIR``` path in the ```run_analysis.R``` script.
* From commandline run ```Rscript ./run_analysis.R```

This will download dataset from above website, extract the file, parse, clean 
and create tidy_data_set.csv file under  ```WORKING_DIR```.

## Dependencies

```run_analysis.R``` file will install the dependencies automatically.



