# Getting-and-Cleaning-Data-Course-Project
This is a repository for my submission of the project for the course on Getting and Cleaning Data.
The script run_analysis.R first merges the testing and training data from the subject, X and y files. 
It then proceeds to extract only relevant columns and tidy up the merged files
before binding all of them together. 

The second part of the script then finds the average of each variable for each activity and each subject,
using the dplyr package.
