run_analysis <- function() {
        ##load data
        data <- load_data()
        data <- name_activities(data)
        summary <- create_summary(data)
        write.table(data, "data.txt", row.names=FALSE)
        write.table(summary, "averages.txt", row.names=FALSE)  
}

load_data <- function()  {
        features <- read.table("UCI HAR Dataset//features.txt", stringsAsFactors=FALSE)
        colNames <- c("Subject", "Activity_Code", "Activity", features$V2)
        selectedCols <- c(1:3, sort(c(grep("mean\\(\\)", colNames),grep("std\\(\\)", colNames))))
        
        testData <- load_type_data("test")  
        colnames(testData) <- colNames
        testData <- testData[,selectedCols]
        
        trainData <- load_type_data("train")  
        colnames(trainData) <- colNames
        trainData <- trainData[,selectedCols]
        
        rbind(testData, trainData)
}

load_type_data <- function(type) {
        if (type == "test") {
                subjects <- read.table("UCI HAR Dataset//test//subject_test.txt")
                activity <- read.table("UCI HAR Dataset//test//y_test.txt")
                data <- read.table("UCI HAR Dataset//test//X_test.txt")  
        } else if (type == "train") {
                subjects <- read.table("UCI HAR Dataset//train//subject_train.txt")
                activity <- read.table("UCI HAR Dataset//train//y_train.txt")
                data <- read.table("UCI HAR Dataset//train//X_train.txt")
        } else {
                message("wrong type!")
                return
        }
        
        allData <- cbind(factor(subjects$V1), factor(activity$V1), factor(activity$V1), data)
        
}

name_activities <- function(data) {
        labels <- read.table("UCI HAR Dataset//activity_labels.txt")
        levels(data$Activity) <-  labels$V2
        data
}

create_summary <- function(data) {
        summary = lapply(split(data, data$Activity), function(z) lapply(split(z, z$Subject), function(y) colMeans(y[c(4:ncol(y))])))
        summary <- simplify_summary(summary)
        summary[with(summary, order(Activity, Subject)),]
        row.names(summary) <- 1:nrow(summary)
        summary
}

simplify_summary <- function(summary) {
        temp1 <- lapply(summary, simplify_subject_list_element)
        returnValue <- data.frame()
        frameNames = factor(names(temp1), levels = read.table("UCI HAR Dataset//activity_labels.txt")$V2)
        for (i in seq_along(temp1)) {
                activityName = frameNames[i]
                frame <- temp1[[i]]
                frame<-cbind(rep(activityName, nrow(frame)), frame)
                colnames(frame)[1] <- "Activity"
                returnValue <- rbind(returnValue, frame)
        }
        returnValue
}

simplify_subject_list_element <- function(element) {
        elementNames <- factor(names(element), levels = 1:30)
        dataFrame <- as.data.frame(element)
        el <- as.data.frame(t(dataFrame))
        el <- cbind(elementNames, el)
        colnames(el)[1] <- "Subject" 
        row.names(el) <- 1:nrow(el)
        el
}
