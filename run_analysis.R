# set the working directory
setwd(K:\\MOOCs - Data Science Specialization\\3. Getting and Cleaning Data\\CourseProject)

# downlaod the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset.zip") {
    download.file(fileUrl, destfile="UCI HAR Dataset.zip")
    dateDownloaded <- date()
}

# read in data
