library(keras)

fashion<-dataset_fashion_mnist()

c(train_image,train_label)%<-%fashion$train
c(test_image,test_label)%<-%fashion$test

class_names<-c("t-shirt/top",
               "trousers",
               "pullover",
               "dress",
               "coat",
               "scandal",
               "shirt",
               "sneaker",
               "bag",
               "ankle boot")

#checking dimensions

dim(train_image)
dim(train_label)
test_label[1:20]


dim(test_image)
dim(test_label)
test_label[1:20]

#viewing the image
library(EBImage)
display(train_image[1,,])


#normalize
train_image<-train_image/255
test_image<-test_image/255


model<-keras_model_sequential()%>%
  layer_dense(units=128,activation = "relu",input_shape = c(28*28))%>%
  layer_dense(units = 10,activation = "softmax")

summary(model)

model%>%compile(
  optimizer="rmsprop",
  loss="sparse_categorical_crossentropy",
  metrics=c("accuracy")
)


history<-model%>%fit(train_image,train_label,epochs=10,batch_size=2,validation_split=0.2)


metrics<-model%>%fit(test_image,test_label)

predictions<-model%>%predict_classes(test_image)

check<-cbind(predictions,test_label)

