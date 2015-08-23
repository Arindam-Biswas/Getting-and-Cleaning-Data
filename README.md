Getting and Cleaning Data Course Project
========================================
This repository hosts the R script and documentation files for Course Project for Coursera - Getting and Cleaning Data Course.

The dataset used for this project is from Human Activity Recognition Using Smartphones available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files in the Repo:

1. README.md - Explains how all of the scripts in the repo work and how they are connected.

2. run_analysis.R - The R script file which gets the data from the data files and cleans the data and outputs the tidy data to "tidy_data_set.txt" file

3. CodeBook.md - A code book which describes the variables, the data, and any transformations or work that was performed to clean up the data.

4. tidy_data_set.txt -  Data file containing the tidy data set with the average of each variable for each activity and each subject

The below steps details out how the run_analysis.R script works:

*Step 1: First, unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract the folder "UCI HAR Dataset" which contains the data files.

*Step 2: Ensure that the folder "UCI HAR Dataset" and the run_analysis.R script are both in the current working directory.

*Step 3: Open the run_analysis.R script in either RStudio or R.

*Step 4: Run the run_analysis.R script, which will generate a data file "tidy_data_set.txt" in the working directory. The data file is 220 KB in size and 180X68 in dimension. This file is a tidy data set with the average of each variable for each activity and each subject.