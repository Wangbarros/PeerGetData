#Read the files
x_train = read.table("train/X_train.txt", stringsAsFactors=FALSE)
y_train = read.table("train/y_train.txt", stringsAsFactors=FALSE)
subject_train = read.table("train/subject_train.txt")
features = read.table("features.txt") 
names(x_train) = features[,2] #Name df columns
x_train$subject = subject_train$V1
x_train$y = y_train$V1 #Add subject and acitivity columns

x_test = read.table("test/X_test.txt") #Read files
y_test = read.table("test/y_test.txt")
subject_test = read.table("test/subject_test.txt")
names(x_test) = features[,2] #Name df columns
x_test$subject = subject_test$V1
x_test$y = y_test$V1 #Add subject and activity columns

data = rbind(x_train, x_test) #Bind train and test df

match = c(".*mean\\(\\).*-X$", ".*std\\(\\).*-X$")
colunas = unique (grep(paste(toMatch,collapse="|"),features$V2, value=TRUE))

cleandata = subset(data, select = c(colunas)) #Select only meand and deviation columns
cleandata$y = data$y
cleandata$subject = data$subject #add subject and activity columns

cleandata$y = as.character(cleandata$y) #Transform to string
cleandata$y = gsub("1", "WALKING", cleandata$y)
cleandata$y = gsub("2", "WALKING_UP", cleandata$y)
cleandata$y = gsub("3", "WALKING_DOWN", cleandata$y)
cleandata$y = gsub("4", "SITTING", cleandata$y)
cleandata$y = gsub("5", "STANDING", cleandata$y)
cleandata$y = gsub("6", "LAYING", cleandata$y) #Change number to name
#Create final data frame
cleandataMeans = aggregate(cleandata[,1:16],by=list(cleandata$y,cleandata$subject),FUN=mean)
