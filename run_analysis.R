library(reshape2)

# Loading the activity labels and features
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracting the data for mean and standard deviation
featureswanted <- grep(".*mean.*|.*std.*", features[,2])
featureswanted.names <- features[featureswanted,2]
featureswanted.names = gsub('-mean', 'Mean', featureswanted.names)
featureswanted.names = gsub('-std', 'Std', featureswanted.names)
featureswanted.names <- gsub('[-()]', '', featureswanted.names)


# Loading the actual datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featureswanted]
trainactivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainsubjects, trainactivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featureswanted]
testactivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testsubjects, testactivities, test)

# merging the datasets and adding labels
alldata <- rbind(train, test)
colnames(alldata) <- c("subject", "activity", featureswanted.names)

# turn activities & subjects into factors
alldata$activity <- factor(alldata$activity, levels = activitylabels[,1], labels = activitylabels[,2])
alldata$subject <- as.factor(alldata$subject)

alldata.melted <- melt(alldata, id = c("subject", "activity"))
alldata.mean <- dcast(alldata.melted, subject + activity ~ variable, mean)

write.table(alldata.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
