## READ ME

This file describes the script (run_analysis.R) and code book (CodeBook.Rmd).

In the script, the data sets are read for test and training.  Description of these data sets are included in the code book.

Data is combined in the script and appropriate column headings are assigned, data is made tidy by excluding columns that are not of interest.

A column with the activity type is also added based on the activity codes.

Finally, a new tidy data set is created with the average for each variable for each subject and activity.

This tidy data set is saved as .txt file and contains the columns as listed in the code book.  It has 180 rows (one row for each subject and activity) and 9 columns (subject, activity, activity.label, and 6 variables as described in code book).