# Read and merge subject files
tmp1 <- read.table("subject_test.txt")
tmp2 <- read.table("subject_train.txt")
subject <- rbind(tmp1,tmp2)

# Read and merge x (all variables) files
tmp1 <- read.table("X_test.txt")
tmp2 <- read.table("X_train.txt")
x <- rbind(tmp1, tmp2)

# Read and merge y files
tmp1 <- read.table("y_test.txt")
tmp2 <- read.table("y_train.txt")
y <- rbind(tmp1, tmp2)

# Extract relevant columns in features file and match with x (all variables) file
# before tidying x (all variables) file
features <- read.table("features.txt")
interested_features <- grep("-mean()|-std()",features[,2])
x <- x[, interested_features]
colnames(x) <- features[interested_features,2]
colnames(x) <- gsub("\\(|\\)", "", colnames(x))
colnames(x) <- tolower(colnames(x))

#tidy activity_labels file and match with y file
activities <- read.table("activity_labels.txt")
activities[,2] <- tolower(activities[,2])
activities[,2] <- gsub("_"," ",activities[,2])
y[,1] = activities[y[,1], 2]
colnames(y) <- c("Activity")

#combine subject, activity and x (all variables) files together
colnames(subject) <- c("Subject")
all <- cbind(subject, y, x)
write.table(all, "merged_clean_data.txt")

#Part 5 -  Use "summarize_each" and "group_by" in dplyr package to
#find the average of each variable for each activity and each subject.
library(dplyr)
all <- tbl_df(all)
by_subject_activity <- group_by(all, Subject, Activity)
summary <- summarize_each(by_subject_activity, funs(mean))
write.table(summary, "averaged_data_set.txt",row.name = FALSE)
