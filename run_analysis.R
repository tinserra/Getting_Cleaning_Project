setwd("C:/Users/Thiago Inserra/Desktop/Coursera/Getting_Cleaning_Project")

## Whether to create a subdirectory:
if (!file.exists("UCI HAR Dataset")) {
        dir.create("UCI HAR Dataset")
}

## URL from which to download project data:
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## If already downloaded, abort. Otherwise, download the data:
if (file.exists("./UCI HAR Dataset/getdata-projectfiles-UCI HAR Dataset.zip")) {
        message("File already exists. Download aborted.")
} else {
        download.file(fileUrl, destfile = "./UCI HAR Dataset/getdata-projectfiles-UCI HAR Dataset.zip")
        unzip ("./UCI HAR Dataset/getdata-projectfiles-UCI HAR Dataset.zip")
}

# Read all files needed for the project
xTst <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTst <- read.table("./UCI HAR Dataset/test/y_test.txt")
sTst <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xTrn <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrn <- read.table("./UCI HAR Dataset/train/y_train.txt")
sTrn <- read.table("./UCI HAR Dataset/train/subject_train.txt")
lbls <- read.table("./UCI HAR Dataset/features.txt")
##dsNm <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Step 1. Merges the training and the test sets to create one data set:
tstData   <- cbind(sTst, yTst, xTst)
trnData   <- cbind(sTrn, yTrn, xTrn)
totDataS1 <- rbind(tstData, trnData)

# Include column names:
ftLbls01 <- as.character(lbls$V2) 
ftLbls02 <- c("Subject","Activity",ftLbls01)

j <- 1; 

for (i in ftLbls02) {
        names(totDataS1)[j] <- i
        j <- j+1
}

## Step 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement:

sel_col_Step0 <- grep("[Mm]ean|[Ss]td", names(totDataS1), value=TRUE)
sel_col_Step1 <- sel_col_Step0[-c(80:86)]
totDataS2 <- subset(totDataS1, select=c("Subject","Activity",sel_col_Step1))

## Step 3. Uses descriptive activity names to name the activities in the data set:
dscNames <- c("Walking","Walking Upstairs","Walking Downstairs","Sitting",
              "Standing","Laying")

k <- 1;

for (i in dscNames) {
        totDataS2$Activity <- gsub(k, i, totDataS2$Activity)
        k <- k+1
}

## Step 4. Appropriately labels the data set with descriptive variable names:

## Create vector with descriptive variable names:
ftLbls03_Step0 <- names(totDataS2)
ftLbls03_Step1 <- gsub("-mean\\()-",        "Mean",   ftLbls03_Step0)
ftLbls03_Step2 <- gsub("-std\\()-",         "SDev",   ftLbls03_Step1)
ftLbls03_Step3 <- gsub("Gravity",           "Grav",   ftLbls03_Step2)
ftLbls03_Step4 <- gsub("BodyBody",          "Body",   ftLbls03_Step3)
ftLbls03_Step5 <- gsub("-mean\\()",         "Mean",   ftLbls03_Step4)
ftLbls03_Step6 <- gsub("-std\\()",          "SDev",   ftLbls03_Step5)
ftLbls03_Step7 <- gsub("-meanFreq\\()-",    "MeanFq", ftLbls03_Step6)
ftLbls03_Step8 <- gsub("-meanFreq\\()",     "MeanFq", ftLbls03_Step7)

## Finally apply new variable names to totDataS2:
l <- 1; 

for (i in ftLbls03_Step8) {
        names(totDataS2)[l] <- i
        l <- l+1
}

## Step 5. Creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject:

suppressWarnings(totDataS3 <- aggregate(totDataS2, by=list(totDataS2$Subject, 
                                                           totDataS2$Activity), 
                                        FUN=mean, na.rm=TRUE))
totDataS3$Subject <- NULL; totDataS3$Activity <- NULL
names(totDataS3)[1] <- "Subject"
names(totDataS3)[2] <- "Activity"

write.table(totDataS2, file = "./UCI HAR Dataset/totDataS2.txt", row.names=FALSE)
write.table(totDataS3, file = "./UCI HAR Dataset/totDataS3.txt", row.names=FALSE)
