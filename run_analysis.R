## This is script run_analysis.R which does the following:
## Step 1: Merges the training and the test sets to create one data set.
## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
## Step 3: Uses descriptive activity names to name the activities in the data set.
## Step 4: Appropriately labels the data set with descriptive variable names.
## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



## Step 1: Merges the training and the test sets to create one data set.
# This script assumes that the folder "UCI HAR Dataset" containing the data files is in the same directory

data_path <- file.path("UCI HAR Dataset")
files <- list.files(data_path, recursive=TRUE)

# read the test and train activity files

y_test  <- read.table(file.path(data_path, "test" , "y_test.txt" ),header = FALSE)
y_train <- read.table(file.path(data_path, "train", "y_train.txt"),header = FALSE)

# read the test and train subject files
subject_test <- read.table(file.path(data_path, "train", "subject_test.txt"),header = FALSE)
subject_train  <- read.table(file.path(data_path, "test" , "subject_train.txt"),header = FALSE)

# read the test and train data files
X_test  <- read.table(file.path(data_path, "test" , "X_test.txt" ),header = FALSE)
X_train <- read.table(file.path(data_path, "train", "X_train.txt"),header = FALSE)

# join train and test data
joined_Data <- rbind(X_train, X_test)

# join train and test label
joined_Label <- rbind(y_train, y_test)

# join train and test subject
joined_Subject <- rbind(subject_train, subject_test)



## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

# read features 
features <- read.table(file.path(data_path, "features.txt"),head=FALSE)

# get only columns with mean or std in their names
mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
joined_Data <- joined_Data[, mean_and_std]

# correct the column names
names(joined_Data) <- features[mean_and_std, 2]
names(joined_Data) <- gsub("\\(\\)", "", names(joined_Data)) 



## Step 3: Uses descriptive activity names to name the activities in the data set.

activity <- read.table(file.path(data_path, "activity_labels.txt"),header = FALSE)
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

# update values with correct activity names
activityLabel <- activity[joined_Label[, 1], 2]
joined_Label[, 1] <- activityLabel

# update correct column name
names(joined_Label) <- "activity"



## Step 4: Appropriately labels the data set with descriptive variable names.

# update correct column name
names(joined_Subject) <- "subject"

# bind all the data in a single clean data set
cleaned_Data <- cbind(joined_Subject, joined_Label, joined_Data)

# relabel the data set appropraitely

names(cleaned_Data) <- gsub("^t", "time", names(cleaned_Data))
names(cleaned_Data) <- gsub("^f", "frequency", names(cleaned_Data))
names(cleaned_Data) <- gsub("Acc", "Accelerometer", names(cleaned_Data))
names(cleaned_Data) <- gsub("Gyro", "Gyroscope", names(cleaned_Data))
names(cleaned_Data) <- gsub("Mag", "Magnitude", names(cleaned_Data))
names(cleaned_Data) <- gsub("BodyBody", "Body", names(cleaned_Data))
names(cleaned_Data) <- gsub("mean", "Mean", names(cleaned_Data))
names(cleaned_Data) <- gsub("std", "Std", names(cleaned_Data))
names(cleaned_Data) <- gsub("-", "", names(cleaned_Data))



## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subject_Length <- length(table(joined_Subject))
activity_Length <- dim(activity)[1]
column_Length <- dim(cleaned_Data)[2]
result <- matrix(NA, nrow=subject_Length*activity_Length, ncol=column_Length) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleaned_Data)
row <- 1

for(i in 1:subject_Length) 
{
      for(j in 1:activity_Length) 
      {
            result[row, 1] <- sort(unique(joined_Subject)[, 1])[i]
            result[row, 2] <- activity[j, 2]
            bool1 <- i == cleaned_Data$subject
            bool2 <- activity[j, 2] == cleaned_Data$activity
            result[row, 3:column_Length] <- colMeans(cleaned_Data[bool1&bool2, 3:column_Length])
            row <- row + 1
      }
}

# write out the result to a new dataset
write.table(result, "tidy_data_set.txt", row.name=FALSE) 