install.packages('caret', dependencies = TRUE)
library(nnet)
# particionamos la base en train y test
library(caret)
set.seed(8)
particion=createDataPartition(y=iris$Species, p=0.8, list=FALSE)
train=iris[particion, ]
test=iris[-particion, ]
# creamos la red neuronal
library(nnet)
set.seed(8)
red=nnet(Species~., train, size=4, maxit=5000)
pred=predict(red, test, type="class")
# para redes neuronales confusionMatrix lleva factor
confusionMatrix(factor(pred), test$Species)  # hay que instalar el paquete M71
fix(train)
5.1*0.7 + 3.5*0.3 + 1.4*0.2 + 0.2*0.8