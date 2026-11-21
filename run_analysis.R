# run_analysis.R
# Getting and Cleaning Data - Course Project

# 0. Download and unzip the data (if not already present)
if (!file.exists("UCI HAR Dataset")) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, "data.zip", mode = "wb")
  unzip("data.zip")
}

# Read the lookup tables
features   <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# Read the training and test sets
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_test  <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test  <- read.table("UCI HAR Dataset/test/y_test.txt")
s_test  <- read.table("UCI HAR Dataset/test/subject_test.txt")

# 1. Merge the training and test sets into one data set
train    <- cbind(s_train, y_train, x_train)
test     <- cbind(s_test,  y_test,  x_test)
all_data <- rbind(train, test)
colnames(all_data) <- c("subject", "activity", features$V2)

# 2. Keep only the mean and standard deviation measurements
keep    <- grepl("subject|activity|mean\\(\\)|std\\(\\)", names(all_data))
data_ms <- all_data[, keep]

# 3. Use descriptive activity names
data_ms$activity <- factor(data_ms$activity,
                           levels = activities$V1,
                           labels = activities$V2)

# 4. Label the variables with descriptive names
names(data_ms) <- gsub("\\(\\)", "", names(data_ms))
names(data_ms) <- gsub("-mean", "Mean", names(data_ms))
names(data_ms) <- gsub("-std", "Std", names(data_ms))
names(data_ms) <- gsub("-", "", names(data_ms))
names(data_ms) <- gsub("^t", "time", names(data_ms))
names(data_ms) <- gsub("^f", "frequency", names(data_ms))
names(data_ms) <- gsub("Acc", "Accelerometer", names(data_ms))
names(data_ms) <- gsub("Gyro", "Gyroscope", names(data_ms))
names(data_ms) <- gsub("Mag", "Magnitude", names(data_ms))
names(data_ms) <- gsub("BodyBody", "Body", names(data_ms))

# 5. Create the tidy data set: average of each variable
#    for each activity and each subject
tidy_data <- aggregate(. ~ subject + activity, data = data_ms, FUN = mean)
tidy_data <- tidy_data[order(tidy_data$subject, tidy_data$activity), ]

write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
