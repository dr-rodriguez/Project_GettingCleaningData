# Script to run the analysis on the data and return a tidy data set

# Load up packages
library(dplyr)


# ==============================================================================
# 0. Load up all relevant data sets

# Naviage to proper directory
setwd('~/Desktop/Coursera/3_Data_cleaning/Project_GettingCleaningData/')

print('Reading data...')
# Load training data sets (values, subject ID, activity ID)
trainset <- read.table("UCI HAR Dataset/train/X_train.txt", header=F)
trainwho <- read.table("UCI HAR Dataset/train/subject_train.txt", header=F)
trainlab <- read.table("UCI HAR Dataset/train/y_train.txt", header=F)

# Load test data sets (values, subject ID, activity ID)
testset <- read.table("UCI HAR Dataset/test/X_test.txt", header=F)
testwho <- read.table("UCI HAR Dataset/test/subject_test.txt", header=F)
testlab <- read.table("UCI HAR Dataset/test/y_test.txt", header=F)
print('Read complete.')

# The activity and subject ID tables will be used later (Steps 3 & 5)


# ==============================================================================
# 1. Merge the training and test data sets
alldata <- rbind(trainset, testset)
rm(testset, trainset) # clean up and delete the original data sets


# ==============================================================================
# 2. Extract the mean and standard deviation for each measurement

# Load features data set
# This will be used to identify which are the mean and std columns
features <- read.table("UCI HAR Dataset/features.txt", 
                       header=F, stringsAsFactors = F)

# Indices for features containing text mean and std 
# As indicated by features_info.txt, only those feaures 
# ending with mean() and std() are relevant here
features2 <- 
    features %>%
    filter(grepl("mean()", V2, fixed = T) | 
           grepl("std()", V2, fixed = T)) #grepl is like grep but returns logical
index <- features2$V1

alldata2 <- alldata[,index]

# index will be used later to specify the descriptive column names (Step 4)


# ==============================================================================
# 3. Add descriptive activity names to the activities in the data set

# Merge all the train and text activities and subjects together
allactivities <- rbind(trainlab, testlab)
allsubjects <- rbind(trainwho, testwho) # Subjects for use later (Step 5)
allsubjects <- as.factor(allsubjects$V1) # Convert subjects to factors

# Load activity data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt", header=F)

# Subset one onto the other to get a list with descriptive activity names
allactivities <- activities$V2[allactivities$V1]

# Merge this onto the main data table, include subjects as well (for Step 5)
alldata2 <- cbind(alldata2, allactivities, allsubjects)


# ==============================================================================
# 4. Label data set with descriptive variable names

# Grab column names from original features data set and index defined in Step 2
cnames1 <- features$V2[index]
cnames1 <- c(cnames1, 'activity', 'subject')

# Replace original column names (V1, V2, etc) with the descriptive names
names(alldata2) <- cnames1


# ==============================================================================
# 5. Create independent tidy data set with the average of each variable 
#    for each activity and each subject

# summarise_each in dplyr makes it easy (note spelling: there is no summarize_each)
alldata3 <-
    alldata2 %>%
    group_by(activity, subject) %>%
    summarise_each(funs(mean)) # apply function mean to each column after grouping

# Output table to a file



# Clean up environment
rm(trainwho, testwho, trainlab, testlab, alldata, index, allsubjects, cnames1, 
   allactivities, activities, features, features2)
