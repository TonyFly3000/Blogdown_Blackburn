library(tidyverse)
library(keras)
library(rpart)
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

d_tree <- rpart(y_train ~ .,method="class", data=all_data_train)

prediction<- predict(d_tree, newdata = as.data.frame(x_test), type = "class")
prediction=as.data.frame(prediction)

all_prediction=as.data.frame(cbind(prediction,y_test))%>%mutate(correct=if_else(prediction==y_test,1,0))

decision_tree_score=sum(all_prediction$correct)/nrow(all_prediction)
decision_tree_score