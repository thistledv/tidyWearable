## CodeBook for Tidying UCI HAR Dataset

by David Thistlethwaite

## Project Description

The purpose of this project is to tidy and summarize the UCI HAR data according to the course instructions provided at: https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

## Source Data

The source dataset  for this project is the UCI HAR data available at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data from the Human Activity Recognition (HAR) study derives from smartphone experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

3-axial linear acceleration and 3-axial angular velocity  were captured using the smartphone's embedded accelerometer and gyroscope. The  sensor signals were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

More information on the study that collected this data can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Study Design and Data Transformations

A zipfile containing the source data was manually downloaded and its contents were unzipped into a directory.

The source dataset was processed by an R script, run_analysis.R.  This script was developed solely by this author.
The script requires a single argument, the name of the folder with the zip file contents.  It produces a single output file in the local directory named:  tidy\_UCI\_HAR\_dataset.csv

For detailed information on the processing performed by this script, examine the comments in the scriptfile run_analysis.R.  The general processing steps are as follows:

1. Combine corresponding test and training dataset elements by loading the elements into separate dataframes and them binding the rows of the corresponding elements.  The **activity** column of the dataset comes from row binding y\_training.txt and y\_test.txt derived dataframes.  The **subject** column of the dataset comes from row binding subject\_training.txt and subject\_test.txt derived dataframes.  The **sensor data variables** columns come from row binding x\_training.txt and x\_test.txt derived dataframes.  Next the columns are assembled into a single dataframe by column binding the merged activity, subject, and variables dataframes.

2. Prior to the binding of the x\_training.txt and x\_test.txt derived dataframes, those frames are subsetted down to the columns which meet the criteria for inclusion in the final dataset.  They must be mean or standard deviation measurement columns.  *Note: "meanfreq" should not be included because they are mean values of the frequencies used in making a measurement, not means of the measurements themselves.*

3. The column labels are read in from the features.txt file and subsetted using the same criteria as in Step #2.  In addition the names are cleansed of undesirable characters (left, right parenthesis and hyphens).  Anticipating the averaging step at the end, the column names are prepended with "average" to reflect the future column contents.  After augmenting the column names with the names of the first two columns (subject and activity), they are used to replace the column names in the master merged dataset. 

4. Next the activity column must be converted from a numeric code to a descriptive name.  This is accomplished by merging a data frame created from the activity_labels.txt file with the master merged dataset.   It is important to do this after all the columns have been merged because it can cause row re-ordering.  The newly introduced column with the descriptive names is used to replace the original activity column.

5. The data variables must now be averaged for each activity and each subject.  I interpret this as wanting to compute average values across all records for a given subject and activity.  For example, there should be a single row for Subject #1/SITTING observations and a single row for Subject #1/STANDING observations, etc.  This is accomplished using ddply in the plyr package.  The splitting is by the subject and activity columns.  The averaging on the other columns is by using colwise(mean).

6. After these processing steps, the tidy data is written to the single file: tidy\_UCI\_HAR\_dataset.txt.  For convenience, the R script also returns the dataframe explicitly.

## Tidy Data

Dimension is 180 x 68

This tidy dataset can be loaded into a dataframe by the following command:

      tidyDataFrame <- read.table("tidy\_UCI\_HAR_dataset.txt", header=TRUE) 



Column 1 is subject ID, a numeric value from 1 to 30.

Column 2 is activity, a category variable with descriptive value: LAYING, SITTING, STANDING, WALKING WALKING_DOWNSTAIRS, WALKING_UPSTAIRS 

Columns 3 to 68 are computed observation averages (as described in step 5) of sensor data mean or standard deviation (std) base variables from the raw data.  All values are numeric.  The base variables are described below:

These column variables come from the accelerometer and gyroscope,  3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean: Mean value
std: Standard deviation







