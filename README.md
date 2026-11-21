# Getting and Cleaning Data - Course Project

## Files
- `run_analysis.R`: the script that produces the tidy data set.
- `CodeBook.md`: describes the variables, the data, and the transformations.
- `tidy_data.txt`: the resulting tidy data set (submitted on Coursera).

## How to run
1. Put `run_analysis.R` in your working directory.
2. Run `source("run_analysis.R")`.
   If the folder `UCI HAR Dataset` is missing, the script downloads and unzips it.
3. The script writes `tidy_data.txt` to the working directory.
   Read it back with `read.table("tidy_data.txt", header = TRUE)`.

## What the script does
1. Merges the training and test sets (subject, activity and the 561 features).
2. Keeps only the measurements on the mean and standard deviation
   (names containing `mean()` or `std()`; `meanFreq()` and `angle()` are excluded).
3. Replaces activity numbers with descriptive names.
4. Renames the variables with descriptive names.
5. Creates a second tidy data set with the average of each variable
   for each activity and each subject (30 subjects x 6 activities = 180 rows).

## Source
Human Activity Recognition Using Smartphones Dataset (UCI).
