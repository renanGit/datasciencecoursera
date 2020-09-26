## This file is for describing the variables, data, and transformation

# Variables
1. 'xfeatures' - this is used to populate the column names
2. 'activityname' - mapping of 1-6 ytrain/ytest labels to activity name
3. 'ytrain' - 7352 rows with 1 column. Training labels
4. 'ytest' - 2947 rows with 1 column. Test labels
5. 'xtrain' - 7352 rows with 561 columns. Training set
6. 'xtest' - 2947 rows with 561 columns. Test set
7. 'subjecttrain' - 7352 rows with 1 column
8. 'subjecttest' - 2947 rows with 1 column
9. 'train_test' - a combination of train/test data sets
10. 'grouped_avg' - grouping of activity / subject and then summarised all with a mean func


# Data Transformation
- Both 'xtrain' / 'xtest' / 'subjecttrain' contain the same amount of columns which are thus joined via a row bind
- Both 'ytrain' / 'ytest' / 'subjecttest' contain the same amount of columns which are thus joinedvia a row bind
- Once the row bind is done, the x data set is joined to the y data set via a column join
