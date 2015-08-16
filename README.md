# Project_GettingCleaningData
Course project for the Data Science course on Getting and Cleaning Data

# Description
This set of scripts loads up data from the Human Activity Recognition Using Smartphones Data Set ([link here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)) and processes it to a tidy version that lists the mean and standard deviations of the measurements as averaged over the various subjects and activities.

# Procedure
These are the steps performed by run_analysis.R
* Loads up the various data tables pertaining to the training and testing sets.
* Merges the train and test datasets together by row. This is the measurement table.
* Filters out unneeded columns by referencing the features.txt file. Only rows denoting the mean (ending in mean()) or standard deviation (ending in std()) are retained.
* Processes the subject and activity tables by merging the train and test sets (by row) and subsetting activity_labels.txt with the the activity table to get meaningful activity names (eg, WALKING).
* Merges the filtered measurement table with the subject and activity tables by column.
* Uses information from features.txt (with some simplyfing substitutions) to create meaningful column names.
* Groups by activity and subject and then takes averages of all variables for these groups. This is the final tidy table.
* Saves the tidy table to a file called tidy_data.txt 

# Files
* README.md - this file
* CodeBook.md - file describing the variables in the final data set, tidy_data.txt
* tidy_data.txt - the tidy data after being processed through run_analysis.R. See CodeBook.md for information on the variables and units in tidy_data.txt
* run_analysis.R - R script to load up all the raw data, process it, and generate the tidy data
* gen_codebook.R - R script to dynamically generate the codebook based on instructions in the features_info.txt file

# Requirements
* The file "getdata-projectfiles-UCI HAR Dataset.zip" must be extracted in a sub-directory called "UCI HAR Dataset/"