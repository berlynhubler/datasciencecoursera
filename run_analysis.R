setwd("/Users/berlyn/Google Drive/Coursera R/GCD_Project")

# read in test data

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "")
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

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt" , header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "")
id_train <- read.table("./UCI HAR Dataset/train/subject_train.txt" , header = FALSE, sep = "", na.strings= "NA", check.names = TRUE, stringsAsFactors = FALSE, blank.lines.skip = FALSE, as.is = TRUE, quote = '\"', comment.char = "")


# rename activity column
# dplyr package already loaded
Y_train <- rename(Y_train, ACTIVITY=V1)
id_train <- rename(id_train, SUBJECT=V1)

# combine test data sets
train_dat <- cbind(id_train, Y_train, X_train)

# merge test and training so all subjects are listed
