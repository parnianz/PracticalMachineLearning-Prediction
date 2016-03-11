
library(caret)
library(kernlab)
library(randomForest)

urltrain<-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
urltest<-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
trainData1<-read.csv(urltrain,na.strings=c("NA","#DIV/0!", ""))
testData1<-read.csv(urltest,na.strings=c("NA","#DIV/0!", ""))

# Delete columns with all missing values
trainData2<-trainData1[,colSums(is.na(trainData1)) == 0]
testData2 <-testData1[,colSums(is.na(testData1)) == 0]

# remove irrelavant comulum
trainData  <-trainData2[,-(1:7)]
testData <-testData2 [,-(1:7)]


set.seed(13343)
inTrain<- createDataPartition(trainData$classe,p=.75,list=FALSE)
training<-trainData[inTrain,]
testing<-trainData[-inTrain,]


dim(training)
dim(testing)

#Model
model <- randomForest(classe~.,data=training,method="class")

pred<-predict(model,training)

# if you get an error install.packages("e1071")

confusionMatrix(pred,training$classe)


# testing
predtest <- predict(model,testData , type="class")
predtest










