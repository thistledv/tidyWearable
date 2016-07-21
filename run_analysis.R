run_analysis<-function(datasetDirectory) {
     
     ## datasetDirectory is the directory containing UCI HAR dataset
     ## contains unzipped contents of dataset available at this URL:
     ##    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
     
 
     
     ## check that the dataset directory is valid and contains expected subdirectories: test, train
     if(!dir.exists(datasetDirectory)) {
          print("bad datasetDirectory")
          return(1)
     }
     else if(!dir.exists(paste0(datasetDirectory,"/train"))) {
          print("dataset missing train subdirectory")
          return(1)
     }
     else if(!dir.exists(paste0(datasetDirectory,"/test"))) {
          print("dataset missing test subdirectory")
          return(1)
     }
     
     ## read training data into dataframes
     xTrain <- read.table(paste0(datasetDirectory,"/train/X_train.txt"))
     trainSubject <- read.table(paste0(datasetDirectory,"/train/subject_train.txt"))
     trainActivity <- read.table(paste0(datasetDirectory,"/train/y_train.txt"))
  
     ## read test data into dataframes
     xTest <- read.table(paste0(datasetDirectory,"/test/X_test.txt"))
     testSubject <- read.table(paste0(datasetDirectory,"/test/subject_test.txt"))
     testActivity <- read.table(paste0(datasetDirectory,"/test/y_test.txt"))
     
     
     ## read in features and figure out which ones are mean or std of measurements
     ## note that we do not want the "meanFreq" columns since they do not meat the
     ##  criteria given in the problems assignment.  Per features_info they are 
     ##  "weighted average of frequency components used", NOT means of measurements
     features <- read.table(paste0(datasetDirectory,"/features.txt"))[,2]
     columnsToSelect <- grep("mean[(]|std[(]",features)
     columnNames <- features[columnsToSelect]
     
     ## get rid of Parenstheses in col names
     columnNames <- gsub("\\(\\)","",columnNames)
     
     ## merge the training and test data by respective datasets
     xTrainTest <- rbind(xTrain[columnsToSelect],xTest[columnsToSelect])
     subjects <- rbind(trainSubject,testSubject)
     activity <- rbind(trainActivity,testActivity)
   
     ## assemble all of the columns in a single data set
     fullDataset <- cbind(subjects,activity,xTrainTest)
     columnNames <- c("subject","activity",columnNames)
     names(fullDataset) <- columnNames
     
     ## merge activity names 
     ## can only do this after all pieces are merged because it can cause
     ## a reordering of the rows (based on CTA guidance in forum week 4 post)
     activityColumns = c("activityCode","activityName") 
     activityLabels <- read.table(paste0(datasetDirectory,"/activity_labels.txt"),sep="",col.names=activityColumns)
     
     ## replace activity code in dataset with readable name that is a factor variable
     fullDataset <- merge(fullDataset,activityLabels,by.x="activity",by.y="activityCode",all=TRUE)
     fullDataset$activity <- factor(fullDataset$activityName)
     fullDataset$activityName <- NULL
     
     
     ## use ddply to average by each subject and each activity
     ## see CodeBook.MD for interpretation of problem
     library(plyr)
     avgDataset <- ddply(fullDataset, .(subject,activity), colwise(mean) )
     
     ## fixup the column names to reflect that they are averages
     newColNames = names(avgDataset)
     newColNames[3:ncol(avgDataset)] = paste0("average",newColNames[3:ncol(avgDataset)])
     newColNames <- gsub("-","",newColNames)
    
     names(avgDataset) <- newColNames
     
     ## write the dataset to current working directory
     write.csv(avgDataset,"tidy_UCI_HAR_dataset.csv", row.names = FALSE)
    
}

     