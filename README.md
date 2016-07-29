# Getting_and_cleaning_data

Submitted for Coursera Certification

-----------------------------------------------------------

Script name: run_analysis.R

---------------------------------------------------------------------------------------

Developed by:

Harish K. Rongala

harishrongala@gmail.com

---------------------------------------------------------------------------------------

run_analysis.R script consists of 9 steps

1) Download data set from internet and extract to working directory

2) Read training and testing data

3) Combining data and renaming variable names

4) Giving descriptive activity names to name the activities in data set

5) Extracting only measurements on mean() and std()

6) Giving fully descriptive names to the variables in the data set

7) Merging training and test data in to one data set

8) Calculate average of each variable for combination of 'subjectid' and 'activity'

9) Export tidy data set

---------------------------------------------------------------------------------------

-&gt; Place 'run_analysis.R' in your R working directory

-&gt; Run the script

-&gt; Output file 'tidyDataset.txt' is created in "UCI HAR Dataset" folder

-&gt; To read the data - use the following command

          > data<-read.table("./tidyDataset.txt",header=TRUE)
