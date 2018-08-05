library(reshape2)

filename <- "CleanProjectData.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Read activity labels + features
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## Extract only the relevent data on mean and standard deviation
## And improving the relevent features names
relevent_features_ind <- grep(".*mean.*|.*std.*", features[,2])
relevent_features_names <- features[relevent_features_ind,2]
relevent_features_names <- gsub('-mean', 'Mean', relevent_features_names)
relevent_features_names <- gsub('-std', 'Std', relevent_features_names)
relevent_features_names <- gsub('[-()]', '', relevent_features_names)

## Read the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[relevent_features_ind]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects, train_activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[relevent_features_ind]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects, test_activities, test)

## Merge datasets (by rows) and add labels
data <- rbind(train, test)
colnames(data) <- c("subject", "activity", relevent_features_names)

## Turn activities & subjects into factors
data$activity <- factor(data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
data$subject <- as.factor(data$subject)

## Avrage by activity and subject
data_melted <- melt(data, id = c("subject", "activity"))
data_mean <- dcast(data_melted, subject + activity ~ variable, mean)

write.table(data_mean, "tidy.txt", row.names = FALSE, quote = FALSE)


