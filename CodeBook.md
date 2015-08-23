Getting and Cleaning Data Course Project CodeBook
=================================================
This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

* The site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

* The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The run_analysis.R script performs the following steps to clean the data:   
 1. Set the data_path using file.path() from where the various data files are to be read.
 
 2. Read using read.table() the various test and train files for data, subject and activity.
 
 3. Merge using rbind() the train and test set of data files into combined files for data, subject and           activity.
 
 4. Read using read.table() the features from the "features.txt".
 
 5. Now extract the measurements on the mean and standard deviation using grep() to filter the columns which     has either mean or std in the name. By this we get a subset of the data with only 66 matching columns.
 
 6. Clean the column names of the subset using gsub() to remove the "()" and "-" symbols in the names.
 
 7. Read using read.table() the activity names from the "activity_labels.txt".
 
 8. Change the activity names in the second column of activity to lower cases using tolower(). Then further      clean the activity names by removing the underscore between letters using gsub(). Finally capitalize the     letter immediately after the underscore in the activity names using toupper().  
 
 9. Now transform the activity labels suitably. 
 
 10. Now appropriately labels the data set with descriptive variable names.
 
 11. Now combine the joined_Subject, joined_Label and joined_Data by column using cbind() to get a new
     cleaned 10299x68 data frame named as cleaned_ Data.
 
 12. Now relabel the various data labels suitably using gsub(). Name the first two columns as "subject" and       "activity" respectively. So now there are 66 + 2 = 68 columsn of data.
 
 13. Now generate a tidy data set with the average of each measurement for each                                   activity and each subject. There are 30 unique subjects and 6 unique activities, therefore we get 180        rows of data and 180 X 68 data frame using for() loop first for each subject and then each activity.
 
 14. Finally create a "tidy_data_set.txt" file with write.table() using row.name=FALSE to save the tidy data      set to the current working directory. 