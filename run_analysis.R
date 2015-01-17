## Download and unzip the files
if(!file.exists("./data")){dir.create("./data")}
fileURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="./files.zip")
unzip(zipfile="./files.zip",exdir="./data")

## Read both the data sets
variables<- read.table("./data/UCI HAR Dataset/features.txt",sep="\n")
variables<- unlist(variables)
variables<- as.character(variables)
variables<- c(variables,"activity","subject")

dat.test_x<- read.table("./data/UCI HAR Dataset/test/X_test.txt",sep="")
dat.test_y<- read.table("./data/UCI HAR Dataset/test/y_test.txt",sep="\n")
dat.test_sub<- read.table("./data/UCI HAR Dataset/test/subject_test.txt",sep="\n")
dat.test<- cbind(dat.test_x,dat.test_y,dat.test_sub)
colnames(dat.test)<- variables

dat.train_x<- read.table("./data/UCI HAR Dataset/train/X_train.txt",sep="")
dat.train_y<- read.table("./data/UCI HAR Dataset/train/y_train.txt",sep="\n")
dat.train_sub<- read.table("./data/UCI HAR Dataset/train/subject_train.txt",sep="\n")
dat.train<- cbind(dat.train_x,dat.train_y,dat.train_sub)
colnames(dat.train)<- variables

final.dat<- rbind(dat.test,dat.train)

## Extract required readings
req_variables<- c(grep("mean()",variables),grep("std()",variables))
req_variables<- c(req_variables,562,563)
req_variables<- sort(req_variables)
var.names<- variables[req_variables]
req_data<- final.dat[,req_variables]
require("plyr")
library(plyr)
req_data<- arrange(req_data,subject,activity)

## Give descriptive activity names
act.labels<- read.table("./data/UCI HAR Dataset/activity_labels.txt",sep="\n")
act.labels<- as.character(unlist(act.labels))
act.labels<- as.factor(act.labels)
req_data$activity<- as.factor(req_data$activity)
req_data$activity<- factor(req_data$activity,labels=act.labels)

## Description for variable names is done in the first step by taking values from txt file

## Independent tidy data set
act<- unique(req_data$activity)
sub<- unique(req_data$subject)
tidyframe<- read.table(text ="",col.names=var.names,row.names=NULL)
for(i in 1:length(sub)){
        for(j in 1:length(act)){
                temp<- subset(req_data,subject==sub[i] & activity==act[j],select=var.names[1:81])
                ans<- c(colMeans(temp[1:79]),act[j],sub[i])
                tidyframe<- rbind(tidyframe,ans)
                }
}
colnames(tidyframe)<- var.names
tidyframe$activity<- factor(tidyframe$activity,labels=act.labels)
tidyframe<- tidyframe[,c(81,80,1:79)]
write.table(tidyframe,file="./tidyframe.txt",row.names=FALSE,sep="\t")
