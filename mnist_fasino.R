library(keras)
install_keras()


library(keras)
library(reticulate) 
tensorflow::tf_config() 


keras:::keras_version() 

fashion_mnist <- dataset_fashion_mnist()

c(train_images, train_labels) %<-% fashion_mnist$train
c(test_images, test_labels) %<-% fashion_mnist$test
