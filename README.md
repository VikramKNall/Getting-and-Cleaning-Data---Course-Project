# Getting-and-Cleaning-Data---Course-Project
This a course project which collects, cleans the data from accelerometers devices while performing different activities

The R script, run_analysis.R, does the following:

1.	Loads the activity and feature info
2.	Loads both the training and test datasets, keeping only those columns which is a mean or standard deviation
3.	Loads the activity and subject data for each dataset, and merges those columns with the dataset
4.	Merges the two datasets
5.	Converts the activity and subject columns into factors
6.	Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.


The end result is shown in the file tidy.txt.
