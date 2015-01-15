
#source("run_analysis.R"); run_analysis()

library(reshape2)

run_analysis <- function()
{
  print("running analysis ...")
  
  #download zip and extract to "./UCI HAR Dataset"
  if(!file.exists("./data")){dir.create("./data")}
  if(!file.exists("./data/d.zip")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile="./data/d.zip") # If the url starts with https on Mac you may need to set method="curl"
  }
  if(!file.exists("./UCI HAR Dataset")){unzip("./data/d.zip",exdir=".")}
  

  # load the 561 signal labels
  column_names <- read.table("./UCI HAR Dataset/features.txt")
  
  # load the 6 activity labels
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  
  print("Processing test set ...")
  ### for test set
  # load the signal set
  test_sig <- read.table("./UCI HAR Dataset/test/X_test.txt")
  
  # add the labels to the set
  colnames(test_sig) <- column_names[,2]
  
  # remove the signals that are not mean or std
  test_sig <- test_sig[,grep("-mean\\(\\)|-std\\(\\)",colnames(test_sig),value=TRUE)]
  
  # load and append the activity labels, convert # labels to activity names
  test_act <- read.table("./UCI HAR Dataset/test/y_test.txt")
  test_sig$Activity <-  merge(test_act,activity_labels)[,2]
  
  # load and append the subjects
  test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  test_sig$Subject <- test_sub[,1]
  #print(colnames(test_sig)); print(nrow(test_sig))
  
  
  print("Processing train set ...")
  ### for train set
  # load the signal set
  train_sig <- read.table("./UCI HAR Dataset/train/X_train.txt")
  
  # add the labels to the set
  colnames(train_sig) <- column_names[,2]
  
  # remove the signals that are not mean or std
  train_sig <- train_sig[,grep("-mean\\(\\)|-std\\(\\)",colnames(train_sig),value=TRUE)]
  
  # load and append the activity labels, convert # labels to activity names
  train_act <- read.table("./UCI HAR Dataset/train/y_train.txt")
  train_sig$Activity <-  merge(train_act,activity_labels)[,2]
  
  # load and append the subjects
  train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  train_sig$Subject <- train_sub[,1]
  #print(colnames(train_sig)); print(nrow(train_sig))
    
  
  # merge the 2 data sets
  total_sig <- rbind(test_sig,train_sig)
  total_sig$Subject <- as.factor(total_sig$Subject)
  #print(colnames(total_sig)); print(nrow(total_sig))
  print("Saving total_sig.txt file ...")
  write.table(total_sig,"./total_sig.txt", row.name=FALSE)
  
  # creates a second, independent tidy data set with the average of each variable 
  # for each activity and each subject.
  #summary_sig <- aggregate(. ~ Subject + Activity,data=total_sig,FUN=mean)
  summary_sig <- melt(  aggregate(. ~ Subject + Activity,data=total_sig,FUN=mean)  ,id.vars=c("Subject","Activity"))
  colnames(summary_sig)[[4]] <- "mean"
  
  #  write.table() using row.name=FALSE
  print("Saving summary_sig.txt file ...")
  write.table(summary_sig,"./summary_sig.txt", row.name=FALSE)
  
}