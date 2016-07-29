## Open the Readme.Md file for more details

        ## Download the data set from internet and extract ##

## Data set URL
dataset_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
## Check if folder exists, if not create a folder named "Samsung_dataset"
if(!file.exists("./Samsung_dataset")){dir.create("./Samsung_dataset")};
## Set working directory to the created folder
setwd("./Samsung_dataset/");
## Download the zipped data set and save it as data.zip
download.file(dataset_url,"./data.zip");
## Unzip the data set
unzip("./data.zip")
## data set is extracted in to a folder named "UCI HAR Dataset"
setwd("./UCI HAR Dataset/")

        ## Read training and testing data ##

## Load data.table
library(data.table)
## Variable to read subject data of training data
train_subject_data<-read.table("./train/subject_train.txt",header = FALSE)
## Variable to read activity data of training data
train_activity_data<-read.table("./train/y_train.txt",header = FALSE)
## Variable to read sensor data of training data
train_sensor_data<-read.table("./train/X_train.txt",header = FALSE)

## Variable to read subject data of testing data
test_subject_data<-read.table("./test/subject_test.txt",header = FALSE)
## Variable to read activity data of testing data
test_activity_data<-read.table("./test/y_test.txt",header = FALSE)
## Variable to read sensor data of testing data
test_sensor_data<-read.table("./test/X_test.txt",header = FALSE)

        ## Combining data and renaming variable names ##

## Combining training's subject data and testing's subject data
subject_data<-rbind(train_subject_data,test_subject_data);
## Combining training's activity data and testing's activity data
activity_data<-rbind(train_activity_data,test_activity_data);
## Combining training's sensor data and testing's sensor data
sensor_data<-rbind(train_sensor_data,test_sensor_data);

## Variable to read features data
features<-read.table("./features.txt",header=FALSE)
## Column V2 contains the feature names
## Replacing "sensor_data" column names with feature names
names(sensor_data)<-features$V2

## Combining "subject data" and "activity data"
subject_activity_data<-cbind(subject_data,activity_data)
## Renaming the columns of "subject_activity_data"
names(subject_activity_data)<-c("subjectid","activity")

        ## Giving descriptive activity names to name the activities in data set ##

## Variable to read activity labels
activity_labels<-read.table("./activity_labels.txt",header=FALSE);
## Factorise the activity column in "subject_activity_data"
## Use V2 column of "activity_labels" as labels in factorising 
subject_activity_data$activity<-factor(subject_activity_data$activity,labels = activity_labels$V2);

        ## Extracting only measurements on mean() and std() ##

## Look for 'mean()' or 'std()' in the column names of "sensor_data"
## Save the logical output in "has_mean_std" variable
has_mean_std<-grepl("mean\\(\\)|std\\(\\)",names(sensor_data))

## Subset the "sensor_data" so that it contains only
## columns with 'mean()' or 'std()' in their names
sensor_data<-sensor_data[,has_mean_std]

        ## Giving fully descriptive names to the variables in the data set ##

## Look for 'BodyBody' and replace with 'Body'
names(sensor_data)<-sub("BodyBody","Body",names(sensor_data))
## Look for column name begining with 'f' and replace it with 'frequency'
names(sensor_data)<-sub("^f","frequency",names(sensor_data))
## Look for column name begining with 't' and replace it with 'time'
names(sensor_data)<-sub("^t","time",names(sensor_data))
## Look for 'Gyro' and replace with 'Gyroscope'
names(sensor_data)<-sub("Gyro","Gyroscope",names(sensor_data))
## Look for 'Acc' and replace with 'Accelerometer'
names(sensor_data)<-sub("Acc","Accelerometer",names(sensor_data))
## Look for 'Mag' and replace with 'Magnitude'
names(sensor_data)<-sub("Mag","Magnitude",names(sensor_data))

        ## Merge training and test data in to one data set ##

## Combining "subject_activity_data" and "sensor_data"
subject_activity_sensor_data<-cbind(subject_activity_data,sensor_data)
## Making things look tidy - all column names to lower case
names(subject_activity_sensor_data)<-tolower(names(subject_activity_sensor_data))

        ## Calculate average of each variable for combination of 'subjectid' and 'activity' ##

## Load reshape2 
library(reshape2)
## Using aggregate function - get mean() of each variable for every combination of 
## subjectid and activity, store it in "dataset2"
dataset2<-aggregate(. ~ subjectid + activity, data=subject_activity_sensor_data, mean)

        ## Export tidy data set ##

## Write "dataset2" as "tidyDataset.txt"
write.table(dataset2,"./tidyDataset.txt",row.names = FALSE)