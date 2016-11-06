
R version 3.3.1 (2016-06-21) -- "Bug in Your Hair"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

Warning: namespace ‘swirl’ is not available and has been replaced
by .GlobalEnv when processing object ‘stopwatch’
[Previously saved workspace restored]

> ## downloaded and unzipped necessary file
> 
>  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
>  download.file(fileUrl,destfile="./data/Dataset.zip",method="auto")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
downloaded 59.7 MB

>  unzip(zipfile="./data/Dataset.zip",exdir="./data")
> 
> ## constructed path for files
>  wearpath <- file.path("./data", "UCI HAR Dataset")
> 
> ## variable to list the files
>  files <-list.files(wearpath,recursive=TRUE)
> 
> ## Set working Directory
>  setwd("~/data/UCI HAR Dataset")
> 
> ## reading files
>  feature <- read.table("~/data/UCI HAR Dataset/features.txt")
>  activity <- read.table("~/data/UCI HAR Dataset/activity_labels.txt")
>  xtrain <- read.table("~/data/UCI HAR Dataset/train/X_train.txt")
>  ytrain <- read.table("~/data/UCI HAR Dataset/train/Y_train.txt")
>  subjecttrain <- read.table("~/data/UCI HAR Dataset/train/subject_train.txt")
>  xtest <- read.table("~/data/UCI HAR Dataset/test/X_test.txt")
>  ytest <- read.table("~/data/UCI HAR Dataset/test/Y_test.txt")
>  subjecttest <- read.table("~/data/UCI HAR Dataset/test/subject_test.txt")
> 
> ## assigning column names
>  colnames(xtrain) <- feature[,2]
>  colnames(ytrain) <- "activityId"
>  colnames(subjecttrain) <- "subject"
>  colnames(xtest) <- feature[,2]
>  colnames(ytest) <- "activityId"
>  colnames(subjecttest) <- "subject"
>  colnames(activity) <- c("activityId", "activityType")
> 
> ## merging data into one set
>  mergetrain <- cbind(ytrain, subjecttrain, xtrain)
>  mergetest <- cbind(ytest, subjecttest, xtest)
>  combineset <- rbind(mergetrain, mergetest)
> 
> ## extract the mean and std for each measurement
>  combinelabels <- colnames(combineset)
>  meanstd <- (grepl("activity", combinelabels) | grepl("subject", combinelabels) | grepl("mean\\()", combinelabels) | grepl("std...", combinelabels))
>  setmeanstd <- combineset[ , meanstd==TRUE]
> 
> ## descriptive activity names
>  descriptivename <- merge(setmeanstd, activity, by="activityId", all.x=TRUE)
> 
> ## Create second independent tidy data set with the average
>  tidysetavg <- aggregate(. ~subject + activityId, descriptivename, mean)
>  tidysetavg <- tidysetavg[order(tidysetavg$subject, tidysetavg$activityId),]
>  write.table(tidysetavg, "tidy.txt", row.name=FALSE)
> save.image("C:\\Users\\Denise Laptop\\Documents\\data\\UCI HAR Dataset\\data\\UCI HAR Dataset\\run_analysis.R")
> 
