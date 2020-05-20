
 
 
# Merges the training and the test sets to create one data set.

path <- getwd()
path2 <- list.files(paste(path,"/UCI HAR Dataset", sep =""))

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
var_names <- read.table("UCI HAR Dataset/features.txt")

colnames(X_test) <- var_names$V2
colnames(subject_test) <- "subject"
colnames(y_test) <- "labels"



X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

colnames(X_train) <- var_names$V2
colnames(subject_train) <- "subject"
colnames(y_train) <- "labels"

condition <- rep("train", length(train$subject))

train <- cbind(subject_train, y_train, condition, X_train)

condition <- rep("test", length(test$subject))

test <- cbind(subject_test, y_test, condition, X_test)

?rbind
set <- rbind(test, train)

colnames(train) == colnames(test)



# Extracts only the measurements on the mean and standard deviation for each measurement.


set2 <- set[, grep("mean", colnames(set))]
set3 <- set[, grep("std", colnames(set))]

set_final <- data.frame(set2, set3)
set_final <- cbind("subject"= set$subject, "activity" = set$labels, 
                   "condition"=set$condition, set_final)



# Uses descriptive activity names to name the activities in the data set

set_final$activity <- as.character(set_final$activity)

set_final$activity <- recode(set_final$activity, "1" = "walking", "2" = "w_upstair", 
                             "3" = "w_downstairs", "4" = "sitting", "5" = "standing", 
                             "6" = "laying")

# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING



# Appropriately labels the data set with descriptive variable names.


descriptive_names <- colnames(set_final)
descriptive_names <- gsub("\\(\\)", "", descriptive_names)
descriptive_names <- gsub("Acc", "-acceleration", descriptive_names)
descriptive_names <- gsub("Mag", "-Magnitude", descriptive_names)
descriptive_names <- gsub("^t(.*)$", "\\1-time", descriptive_names)
descriptive_names <- gsub("^f(.*)$", "\\1-frequency", descriptive_names)
descriptive_names <- gsub("(Jerk|Gyro)", "-\\1", descriptive_names)
descriptive_names <- gsub("BodyBody", "Body", descriptive_names)
descriptive_names <- tolower(descriptive_names)

names(set_final) <- descriptive_names
set_final <- set_final[-3]


# From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

table(set_final$subject)

library(plyr);
tidy_data <- aggregate(. ~subject + activity, set_final, mean)
table(tidy_data$subject)

write.table(tidy_data, file = "tidy_data.txt", sep=",", row.names = F)

