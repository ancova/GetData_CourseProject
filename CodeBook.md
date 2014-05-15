Code book for Course project
================================

###STUDY DESIGN

The data for the course project is from *Human Activity Recognition Using Smartphones Dataset* by Jorge L, RReyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto[1], which can be downloaded at [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking\_upstairs, walking\_downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. More information could be found on the website.

As for the course project, data cleaning are following steps:

1. Download and unzip the data file in the working directory.

2. Read in data, *activity_labels.txt* contains the class labels of all 6 acitivity names, and *features.txt* is the list of all 561 features vector with time and frequency domain variabls.

3. Extract the mean and standard deviation for 33 measurements (66 column in total) by

	1. Generate a boolean vector ``meanstd`` to indicate whether the measurement column is a mean or standard deviation. 

	2. Set ``fixed=TRUE`` in the ``grepl()`` function to match _mean()_ and _std()_ exactly. 

	3. Rename the selected columns with names in *feature.txt* by deleting the brackets and converting hyphen (-) into dot (.)

4. Read in the train and test data, including the subject data (*suject_test.txt* and *suject_train.txt*), activity data (*y_test.txt* or *y_train.txt*), and 561 measurements (*X_test.txt* or *X_train.txt*). 

5. Subset and rename the 66 selected variables from the imported data with the vector generated in step 3. There are 2947 rows in test data and 7352 rows in train data.

6. Append test and train data into one data frame, which has 10299 rows and 68 columns (1 column for subject, 1 column for activity and 66 columns for selected means and standard deviations). 

7. Convert the *subject* and *activity* columns into factors.

8. Creates the tidy data set with the average of each variable for each activity and each subject by using the ``sapply()`` and ``split()`` function. 

9. Rename the column names in ``subject.activity.mean`` format with lower case. There are 66 rows (means and stds for 33 measurements) and 181 columns (1 for measurements, and 6 activities for 30 subjects).

10. Save out the tidy data as TAB-delimited text file.

###CODE BOOK

#### The combined data
1. "subject": Factor. Identifies the subject who performed the activity. Its range is from 1 to 30. 

1. "activity": Factor. Identifies the activity the subject performed. Its range is from 1 to 6.
	- 1 walking
	- 2 walking_upstairs
	- 3 walking_downstairs
	- 4 sitting
	- 5 standing
	- 6 laying

1. The measurements were extracted from the raw data. They are all numeric, with the variable name in the ``measurements.mean(/std).XYZ" format, which is separated into 3 parts by dot (.). The first part is the measurements (see more at [features_info.txt](.\\features_info.txt)), the second is static (mean or standard deviation), and the third part is the suffix for XYZ axis. The complete list of variables is as follows.
	- tBodyAcc.mean.X"          
	- "tBodyAcc.mean.Y"           
	- "tBodyAcc.mean.Z"           
	- "tBodyAcc.std.X"           
	- "tBodyAcc.std.Y"            
	- "tBodyAcc.std.Z"            
	- "tGravityAcc.mean.X"       
	- "tGravityAcc.mean.Y"        
	- "tGravityAcc.mean.Z"        
	- "tGravityAcc.std.X"        
	- "tGravityAcc.std.Y"         
	- "tGravityAcc.std.Z"         
	- "tBodyAccJerk.mean.X"      
	- "tBodyAccJerk.mean.Y"       
	- "tBodyAccJerk.mean.Z"       
	- "tBodyAccJerk.std.X"       
	- "tBodyAccJerk.std.Y"        
	- "tBodyAccJerk.std.Z"        
	- "tBodyGyro.mean.X"         
	- "tBodyGyro.mean.Y"          
	- "tBodyGyro.mean.Z"          
	- "tBodyGyro.std.X"          
	- "tBodyGyro.std.Y"           
	- "tBodyGyro.std.Z"           
	- "tBodyGyroJerk.mean.X"     
	- "tBodyGyroJerk.mean.Y"      
	- "tBodyGyroJerk.mean.Z"      
	- "tBodyGyroJerk.std.X"      
	- "tBodyGyroJerk.std.Y"       
	- "tBodyGyroJerk.std.Z"       
	- "tBodyAccMag.mean"         
	- "tBodyAccMag.std"           
	- "tGravityAccMag.mean"       
	- "tGravityAccMag.std"       
	- "tBodyAccJerkMag.mean"      
	- "tBodyAccJerkMag.std"       
	- "tBodyGyroMag.mean"        
	- "tBodyGyroMag.std"          
	- "tBodyGyroJerkMag.mean"     
	- "tBodyGyroJerkMag.std"     
	- "fBodyAcc.mean.X"           
	- "fBodyAcc.mean.Y"           
	- "fBodyAcc.mean.Z"          
	- "fBodyAcc.std.X"            
	- "fBodyAcc.std.Y"            
	- "fBodyAcc.std.Z"           
	- "fBodyAccJerk.mean.X"       
	- "fBodyAccJerk.mean.Y"       
	- "fBodyAccJerk.mean.Z"      
	- "fBodyAccJerk.std.X"        
	- "fBodyAccJerk.std.Y"        
	- "fBodyAccJerk.std.Z"       
	- "fBodyGyro.mean.X"          
	- "fBodyGyro.mean.Y"          
	- "fBodyGyro.mean.Z"         
	- "fBodyGyro.std.X"           
	- "fBodyGyro.std.Y"           
	- "fBodyGyro.std.Z"          
	- "fBodyAccMag.mean"          
	- "fBodyAccMag.std"           
	- "fBodyBodyAccJerkMag.mean" 
	- "fBodyBodyAccJerkMag.std"   
	- "fBodyBodyGyroMag.mean"     
	- "fBodyBodyGyroMag.std"     
	- "fBodyBodyGyroJerkMag.mean" 
	- "fBodyBodyGyroJerkMag.std" 

#### The tidy data

The tidy data contains the average of each variable for each activity and each subject. There are 66 rows (which identify the means and stds for 33 measurements, listed above), and 181 columns (1 for measurements, and 6 activities for 30 subjects). The columns are renamed ``subject.activity.mean`` format with lower case.
	
- ``subject`` denotes the subject who performed the activity. Its range is from 1 to 30.

- ``activity`` denotes activity the subject performed. They are walking, walking_upstairs, walking_downstairs, sitting, standing, and laying.

- ``mean`` denotes the average of each variable for each activity and each subject.


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.