# getwd()
library(dplyr)

# total of 561 column names
xfeatures <- read.table("./UCI HAR Dataset/features.txt", header=F, sep="")
# total of 6 type of label names
activityname <- read.table("./UCI HAR Dataset/activity_labels.txt", header=F, sep="")
# total of 2947 rows / 1 column
ytrain <- read.delim("./UCI HAR Dataset/train/y_train.txt", header = F, sep = "\n")
ytest <- read.delim("./UCI HAR Dataset/test/y_test.txt", header = F, sep = "\n")
# total of 7352 rows / 561 columns
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F, sep="")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F, sep = "")
# total of 7352 rows / 1 column | 2947 rows / 1 column
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F, sep="")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F, sep="")


# column bind the train and test data set
# then row bind train and test data set
# 1. Merges the training and the test sets to create one data set.
train_test <- rbind(bind_cols(xtrain, ytrain, subjecttrain), bind_cols(xtest, ytest, subjecttest))


# 4. Appropriately labels the data set with descriptive variable names
# Also for no reason we have duplicate column names........
colnames(train_test) <- make.unique(as.vector(c(xfeatures[["V2"]], "label", "subject")))


# 3. Uses descriptive activity names to name the activities in the data set
train_test$label <- lapply(train_test$label, function(v){ activityname[v, 2] })


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
select(train_test, matches("(mean[()]|std[()])"))
# See the dimension of the regex - 66 columns out of 561
# dim(xfeatures[grepl("(mean[()]|std[()])", xfeatures[, 2]), ])


# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
# A tibble: 180 x 563
# Groups:   label [6]
grouped_avg <- train_test %>% group_by(label, subject) %>% summarise_all(mean)
write.table(x=apply(grouped_avg,2,unlist), row.names=F, file="./grouped_avg.txt")
