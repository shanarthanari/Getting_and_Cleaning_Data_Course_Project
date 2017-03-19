#
# This R scripts downloads and transforms data as per course project then creates 
# tidy_data_set.csv file for further analysis.
#

FILE_URL="http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
WORKING_DIR="~/personal/coursera/Getting_and_Cleaning_Data_Course_Project/"

# Set working directory
setwd(WORKING_DIR)

#
# Load required packages. 
#
if (!require("data.table")) {
    install.packages("data.table", repos="http://cran.rstudio.com/")
}
library(data.table)
if (!require("plyr")) {
    install.packages("plyr", repos="http://cran.rstudio.com/")
}
library(plyr)
if (!require("dplyr")) {
    install.packages("dplyr", repos="http://cran.rstudio.com/")
}
library(dplyr)

if (!require("reshape2")) {
    install.packages("reshape2", repos="http://cran.rstudio.com/")
}
library(reshape2)


#
# Load and clean the data
#

download.file(url=FILE_URL, destfile = "Dataset.zip")
unzip("./Dataset.zip")


activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              stringsAsFactors = FALSE)

## Assignment 3. Use descriptive activity names to name the activities in the data set
activity_labels[activity_labels == "WALKING"] <- "Walking"
activity_labels[activity_labels == "WALKING_UPSTAIRS"] <- "Walking Upstairs"
activity_labels[activity_labels == "WALKING_DOWNSTAIRS"] <- "Walking Downstairs"
activity_labels[activity_labels == "SITTING"] <- "Sitting"
activity_labels[activity_labels == "STANDING"] <- "Standing"
activity_labels[activity_labels == "LAYING"] <- "Laying"
activity_labels <- activity_labels[,2]
activity_labels <- as.factor(activity_labels)

features <- read.table("./UCI HAR Dataset/features.txt")
features <- features[,2]

## Assignment 2. Extracts only the measurements on the mean and standard deviation for 
## each measurement.
features_required <- grepl("mean()|std()", features)

# training data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(x_train) = features

# filter out unnessary measurements.
x_train <- x_train[,features_required]

y_train[,2] = activity_labels[y_train[,1]]

train_final_data <- data.frame(subject_train, y_train, x_train)

train_final_data <- data.frame(subject_train, y_train, x_train)

setnames(train_final_data, old = c("V1", "V1.1", "V2"), 
         new = c("Subject_ID", "Activity_ID", "Activity_Label"))

    
# test data
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(x_test) = features

# filter out unwanted features.
x_test <- x_test[,features_required]

# Activity labels
y_test[,2] = activity_labels[y_test[,1]]

# test data
test_final_data <- data.frame(subject_test, y_test, x_test)

## Assignment 4. Appropriately labels the data set with descriptive variable names.
setnames(test_final_data, old = c("V1", "V1.1", "V2"), 
        new = c("Subject_ID", "Activity_ID", "Activity_Label"))

## Assignment 1. Merges the training and the test sets to create one data set.
final_data_set <- rbind(train_final_data, test_final_data)


## Assignment 5. creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

id_columns   = c("Subject_ID", "Activity_ID", "Activity_Label")
melted_labels = setdiff(colnames(final_data_set), id_columns)
melted = melt(final_data_set, id = id_columns, measure.vars = melted_labels)

tidy2 <- dcast(melted, Subject_ID + Activity_Label 
               ~ variable, mean)

write.table(tidy2, "./tidy_data_set.txt", row.names = FALSE )
print('Done.')

