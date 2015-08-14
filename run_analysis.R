# Script to run the analysis on the data and return a tidy data set

# ==============================================================================
# 0. Load up all relevant data sets

# Naviage to proper directory
setwd('~/Desktop/Coursera/3_Data_cleaning/Project_GettingCleaningData/')

# Load training data sets (values, subject ID, activity ID)
trainset <- read.table("UCI HAR Dataset/train/X_train.txt", header=F)
trainwho <- read.table("UCI HAR Dataset/train/subject_train.txt", header=F)
trainlab <- read.table("UCI HAR Dataset/train/y_train.txt", header=F)

# Load test data sets (values, subject ID, activity ID)
testset <- read.table("UCI HAR Dataset/test/X_test.txt", header=F)
testwho <- read.table("UCI HAR Dataset/test/subject_train.txt", header=F)
testlab <- read.table("UCI HAR Dataset/test/y_test.txt", header=F)

# Merge to single train & test tables
trainall <- cbind(trainwho, trainlab, trainset)
testall <- cbind(testwho, testlab, testset)

# Remove individual tables to free up memory
rm(trainwho, trainlab, trainset)
rm(testwho, testlab, testset)

# ==============================================================================
# 1. Merge the training and test data sets

# ==============================================================================
# 2. Extra the mean and standard deviation for each measurement

# ==============================================================================
# 3. Add descriptive activity names to the activities in the data set

# Load activity data set

# ==============================================================================
# 4. Label data set with descriptive variable names

# Load features data set

# ==============================================================================
# 5. Create independent tidy data set with the average of each variably 
#    for each activity and each subject

