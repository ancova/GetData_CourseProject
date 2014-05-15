# set the working directory
setwd("K:\\MOOCs - Data Science Specialization\\3. Getting and Cleaning Data\\CourseProject")

# download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset.zip")) {
    download.file(fileUrl, destfile="UCI HAR Dataset.zip")
    dateDownloaded <- date()
    } else {
        message("The data file has been downloaded already.")
    }

# unzip the data file
if (!file.exists("UCI HAR Dataset")) {
    unzip("UCI HAR Dataset.zip")
    } else {
        message("The file is already unzipped.")
        }

# read in data
activitylabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
features <- read.table(".\\UCI HAR Dataset\\features.txt")
dim(activitylabels)
dim(features)

# select the mean and std variables
meanstd <- grepl("mean()", features[,2], fixed=TRUE) | grepl("std()", features[,2], fixed=TRUE) 
#pattern is a string to be matched as is.
table(meanstd)
varSelected <- gsub("()", "", gsub("-", ".", features[meanstd,2]), fixed=T) #rename variables
length(varSelected)

# read in test data
subjecttest <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", col.names="subject") # read in subject data
ytest <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", col.names="activity") # read in activity data 
xtest <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt") # read in the measurements
xtestSelected <- xtest[,meanstd] # subset the mean and std variables
names(xtestSelected) <- varSelected # rename the selected variables

test <- data.frame(subjecttest, ytest, xtestSelected) # merge into test data
dim(test)

# read in train data
subjecttrain <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", col.names="subject") # read in subject data
ytrain <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", col.names="activity") # read in activity data 
xtrain <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
xtrainSelected <- xtrain[,meanstd] # subset the mean and std variables
names(xtrainSelected) <- varSelected # rename the selected variables

train <- data.frame(subjecttrain, ytrain, xtrainSelected) # merge into train data
dim(train)

# append two data sets (test and train data)
combine <- rbind(train, test)
dim(combine)
combine$subject <- factor(combine$subject)
combine$activity <- factor(combine$activity)
levels(combine$activity) <- activitylabels[,2]

# preparing the tidy data
s <- split(combine, list(combine$subject, combine$activity), drop=TRUE)
tidy <- sapply(s, function(x) colMeans(x[, varSelected]))
dim(tidy)
write.table(tidy, file="TidyData.txt", sep="\t")
