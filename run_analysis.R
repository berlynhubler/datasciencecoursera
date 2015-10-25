setwd("/Users/berlyn/Google Drive/Coursera R/GCD_Project")

# read the feature names
features <- read.csv("./UCI HAR Dataset/features.txt", sep=" ", header=FALSE)

# convert to character vector for use as column names
labels <- as.character(features[,2])

# read in test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "", col.names=labels)
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt" , header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "")
id_test <- read.table("./UCI HAR Dataset/test/subject_test.txt" , header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "")

# rename activity column
# need dplyr package
library(dplyr)
Y_test <- rename(Y_test, ACTIVITY=V1)
id_test <- rename(id_test, SUBJECT=V1)

# combine test data sets
test_dat <- cbind(id_test, Y_test, X_test)

# read in training data
X_train <- read.table("./GCD_Project/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "", col.names=labels)
Y_train <- read.table("./GCD_Project/UCI HAR Dataset/train/y_train.txt" , header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "")
id_train <- read.table("./GCD_Project/UCI HAR Dataset/train/subject_train.txt" , header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "")


# rename activity column
# dplyr package already loaded
Y_train <- rename(Y_train, ACTIVITY=V1)
id_train <- rename(id_train, SUBJECT=V1)

# combine test data sets
train_dat <- cbind(id_train, Y_train, X_train)

# merge test and training so all subjects are listed
full_data <- rbind(test_dat, train_dat)

# remove columns not associated with mean and stdev
data <- full_data[,1:8]

# give "meaningful" names to columns"
data <- rename(data, tBodyAcc.mean.X = tBodyAcc.mean...X, tBodyAcc.mean.Y = tBodyAcc.mean...Y, tBodyAcc.mean.Z = tBodyAcc.mean...Z, tBodyAcc.std.X = tBodyAcc.std...X, tBodyAcc.std.Y = tBodyAcc.std...Y, tBodyAcc.std.Z = tBodyAcc.std...Z)

# add activity descriptions
new_data <- data
new_data$Activity.Type <- ifelse(new_data$ACTIVITY == 1,"WALKING", ifelse(new_data$ACTIVITY == 2,"WALKING_UPSTAIRS", ifelse(new_data$ACTIVITY == 3,"WALKING_DOWNSTAIRS", ifelse(new_data$ACTIVITY == 4,"SITTING", ifelse(new_data$ACTIVITY == 5,"STANDING", ifelse(new_data$ACTIVITY == 6,"LAYING", "NA")))))

                                 
### Summary of tidy data:
# Average of each variable for each subject and activity
# 30 subjects
# 6 activities
# 7 variables
# table headers: SUBJECT; ACTIVITY; X,Y,Z MEAN; X,Y,Z STDEV; Activity.Label
# nrows = 180, ncols = 9

tidy <- data.frame()
for (subject in 1:30) {
     for (activity in 1:6) {
          sub_act <- new_data[(new_data$SUBJECT == subject & new_data$ACTIVITY == activity),]
          sub_act_mean <- data.frame(lapply(sub_act[,3:8], mean))
          tidy <- rbind(tidy, cbind(sub_act[1,1:2],sub_act_mean))

     }
}

# add activity labels
tidy$Activity.Label <- ifelse(tidy$ACTIVITY == 1,"WALKING", ifelse(tidy$ACTIVITY == 2,"WALKING_UPSTAIRS", ifelse(tidy$ACTIVITY == 3,"WALKING_DOWNSTAIRS", ifelse(tidy$ACTIVITY == 4,"SITTING", ifelse(tidy$ACTIVITY == 5,"STANDING", ifelse(tidy$ACTIVITY == 6,"LAYING", "NA"))))))

# Save final tidy data set as a .txt file
write.table(tidy, "tidy.txt", row.name=FALSE)


                                 