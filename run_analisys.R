x_train = read.table("train/X_train.txt", stringsAsFactors=FALSE)
y_train = read.table("train/y_train.txt", stringsAsFactors=FALSE)
subject_train = read.table("train/subject_train.txt")
features = read.table("features.txt")
names(x_train) = features[,2]
x_train$subject = subject_train$V1
x_train$y = y_train$V1

x_test = read.table("test/X_test.txt")
y_test = read.table("test/y_test.txt")
subject_test = read.table("test/subject_test.txt")
names(x_test) = features[,2]
x_test$subject = subject_test$V1
x_test$y = y_test$V1

data = rbind(x_train, x_test)

match = c(".*mean\\(\\).*-X$", ".*std\\(\\).*-X$")
colunas = unique (grep(paste(toMatch,collapse="|"),features$V2, value=TRUE))

cleandata = subset(data, select = c(colunas))
cleandata$y = data$y
cleandata$subject = data$subject

cleandata$y = as.character(cleandata$y)
cleandata$y = gsub("1", "WALKING", cleandata$y)
cleandata$y = gsub("2", "WALKING_UP", cleandata$y)
cleandata$y = gsub("3", "WALKING_DOWN", cleandata$y)
cleandata$y = gsub("4", "SITTING", cleandata$y)
cleandata$y = gsub("5", "STANDING", cleandata$y)
cleandata$y = gsub("6", "LAYING", cleandata$y)

cleandataMeans = aggregate(cleandata[,1:16],by=list(cleandata$y,cleandata$subject),FUN=mean)
