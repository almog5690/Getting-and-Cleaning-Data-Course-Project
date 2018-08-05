# Getting-and-Cleaning-Data-Course-Project
This is a ripo for Getting and Cleaning Data course project.
The R script run_analysis.R does the following:

1) Download the dataset if it does not already exist in the working directory.
2) Read the activity and features.
3) Read the train and test datasets, keeping only the relevent columns (mean or standard deviation).
4) Cleaning the features names.
5) Read the activity and subject data for each dataset, and merges those columns with the dataset.
6) Merges the two datasets.
7) Converts the activity and subject columns into factors.
8) Creates a tidy dataset that consists of the average value of each variable for each subject and activity pair.

After all of that we get the tidy data file: tidy.txt
