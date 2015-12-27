This file explains the steps on how to run run_analysis.R.

1) Download and unzip data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to folder "data" in the same location where the script run_analysis.R is.
2) Run source("run_analysis.R") command in RStudio.
3) This generates an output file "tidyData.txt" inside "data" directory.
4) "tidyData.txt" contains tidy data created as per assignment requirements. It contains data frame with 180 rows and 68 columns. The first two columns are Subjects and Labels, and the next 66 columns are the means of each activity for a subject.
