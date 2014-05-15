Instruction list for course project
====================================

All these codes were written and run at Windows 7 64-bit using R v3.1.0 and RStudio v0.98.501. 

The repo includes the following files:

- 'README.md':  Explains how all of the scripts work and how they are connected.

- 'CodeBook.md':  Describes the variables, the data, and any transformations or work that you performed to clean up the data .

- 'run_analysis.R': A R script that does all the requirements for the project.

- 'TidyData.txt': A TAB-delimited text file with the average of each variable for each activity and each subject.

### Steps of the R Script

1. Set the working directory using ``setwd()`` function;

2. Download the data zip file from the given url [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip][1], and the current data and time will be assigned to _dataDownlaod_ object. If the "UCI HAR Dataset.zip" file exits in the working directory, a message _The data file has been downloaded already._ will be printed out, and the program will not download it again. 

    ```R
    if (!file.exists("UCI HAR Dataset.zip")) {
        download.file(fileUrl, destfile="UCI HAR Dataset.zip")
        dateDownloaded <- date()
        } else {
            message("The data file has been downloaded already.")
        } 
    ```

3. Unzip the download file. Again, the program will check whether the folder _UCI HAR Dataset_ exits by using the ``file.exits()`` function.

    ```R
    if (!file.exists("UCI HAR Dataset")) {
        unzip("UCI HAR Dataset.zip")
        } else {
            message("The file is already unzipped.")
            } 
    ```

4. Read in data. *activity_labels.txt* contains the class labels of all 6 acitivity names, and *features.txt* is the list of all 561 features vector with time and frequency domain variabls.

    ```R
    activitylabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")
    features <- read.table(".\\UCI HAR Dataset\\features.txt")
    dim(activitylabels)
    dim(features) 
    ```

5. Generate a boolean vector ``meanstd`` to indicate whether the measurement column is a mean or standard deviation. Set ``fixed=TRUE`` so the ``grepl()`` function will search for extact match of _mean()_ and _std()_. There are 495 **FALSE** and 66 **TRUE** in the vector.

    ```R
    meanstd <- grepl("mean()", features[,2], fixed=TRUE) | grepl("std()", features[,2], fixed=TRUE) 
    # Pattern is a string to be matched as is.
    table(meanstd) 
    ```

6. Extract all 66 measurements on the on the mean and standard deviation to another vector ``varSelected``. The variable names were renamed according to [Google R style guide][2]:
	
	1. Words were separated with dots (*variable.name*)
	
	2. Parentheses *()* were deleted

    ```R
    varSelected <- gsub("()", "", gsub("-", ".", features[meanstd,2]), fixed=T) # rename variables
    length(varSelected) 
    ```

7. Read in the test data and train data, which including the subject data, activity data, and 561 measurements. There are 2947 rows in test data and 7352 rows in train data.

    ```R
    ## read in test data
    # read in subject data
    subjecttest <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", col.names="subject") 
    # read in activity data 
    ytest <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", col.names="activity") 
    # read in the measurements
    xtest <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt") 
    # subset the mean and std variables
    xtestSelected <- xtest[,meanstd] 
    # rename the selected variables
    names(xtestSelected) <- varSelected

    # merge into test data
    test <- data.frame(subjecttest, ytest, xtestSelected) 
    dim(test)

    ## read in train data
    # read in subject data
    subjecttrain <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", col.names="subject") 
    # read in activity data
    ytrain <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", col.names="activity")  
    xtrain <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
    # subset the mean and std variables
    xtrainSelected <- xtrain[,meanstd] 
    # rename the selected variables
    names(xtrainSelected) <- varSelected 

    # merge into train data
    train <- data.frame(subjecttrain, ytrain, xtrainSelected) 
    dim(train)

    ```

8. Append test and train data into one data frame, which has 10299 rows and 68 columns. The ``subject`` and ``activity`` columns were converted into factors, and levels of factor ``activity`` were assigned with ``actitivitylabels``.

    ```R
    combine <- rbind(train, test)
    dim(combine)
    combine$subject <- factor(combine$subject)
    combine$activity <- factor(combine$activity)
    levels(combine$activity) <- activitylabels[,2] 
    ```

9. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. and rename the column names in ``subject.activity.mean`` format with lower case. There are 66 rows (means and stds for 33 measurements) and 181 columns (1 for measurements, and 6 activities for 30 subjects).

    ```R
    # prepare the tidy data
    s <- split(combine, list(combine$subject, combine$activity), drop=TRUE)
    tidy <- as.data.frame(sapply(s, function(x) colMeans(x[, varSelected])))
    colnames(tidy) <- paste(tolower(colnames(tidy)), "mean", sep=".")
    tidy <- cbind(measurements=rownames(tidy),tidy)
    dim(tidy)
    ```

10. Save out the tidy data as TAB-delimited text file.

    ```R
    # save as a text file
    write.table(tidy, file="TidyData.txt", sep="\t", row.names=FALSE)
    ```

[1]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
[2]: https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml