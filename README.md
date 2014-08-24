Getting_Cleaning_Project
========================

ReadMe file for Coursera's "Getting and Cleaning Data" Course Project

This is a guideline for my R script:

## Step 0
I started by: 
* Setting the working directory;
* Downloading the zip file and;
* Reading all necessary files in R.

## Step 1
To merge the training and test sets, I:
* Worked with the "cbind" and "rbind" functions and;
* Included all columns names that I read from "features.txt".

## Step 2
To extract only the measurements on the mean and std dev, I filtered the names that includes the strings "mean" and "std". Then I excluded the final columns, because they were related to angle.

## Step 3
To substitute the original numbers that described the activities for the actual names, I simply used the gsub function in a for-loop


## Step 4
To appropriately label the data set with descriptive variable names, I used gsub several times until I got to the final vector. Then, I used a for-loop command to apply the new names to the main dataset.

## Step 5
Finally, I aggregated the data as requested and wrote the files to be hand in.