
The run_analysis.R contains all the steps to create a table with the mean by subject and activity of the Human Activity Recognition Using Smartphones Dataset experiments conducted by Samsung. 

First, the script loads into R a set of tables, assigns the names of the columns, then merges the set of tables first into two tables (test and train) binding columns from different tables, and finally into one big data frame binding the rows of test and train.

Second, this data frame is subsetted into a new one taking only the columns containing means and standard deviation, and the columns with the information of the subject and the activity.

Third, the column activity is recoded to include descriptive labels instead of numeric values.

Fourth, the names of the columns are also changed to be more descriptive and easier to read.

Fifth and last, the final table is created with the mean of each subject in each activity using the plyr function 'aggregate'. The table is also loaded into a txt file.