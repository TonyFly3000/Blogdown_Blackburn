library(tidyverse)
library(keras)
library(randomForest)
mnist <- dataset_mnist()
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

x_train <- array_reshape(x_train, c(nrow(x_train), 784))
x_test <- array_reshape(x_test, c(nrow(x_test), 784))

x_train <- x_train / 255
x_test <- x_test / 255



all_data_train=as.data.frame(cbind(x_train, y_train))
all_data_train$y_train=factor(all_data_train$y_train)
all_data_test=as.data.frame(cbind(x_test, y_test))

numTrees = 5

rf <- randomForest(y_train ~ .,data=all_data_train,ntree=numTrees,importance = TRUE) 

rf
#########################

pred <- predict(rf, x_test)

mean(pred == all_data_test$y_test)  





prediction <-predict(rf, x_test)

table(predTrain, all_data_test$y_test)

mean(prediction == all_data_test$y_test)  



prediction=as.data.frame(prediction)

all=as.data.frame(cbind(prediction,y_test))%>%mutate(correct=if_else(prediction==y_test,1,0))
head(all,20)

randon_forest_score=sum(all$correct)/nrow(all)
randon_forest_score

#############################


prediction<- predict(rf, newdata = as.data.frame(x_test), type = "class")
prediction=as.data.frame(prediction)

all_prediction=as.data.frame(cbind(prediction,y_test))%>%mutate(correct=if_else(prediction==y_test,1,0))

randon_forest_score=sum(all_prediction$correct)/nrow(all_prediction)
randon_forest_score
