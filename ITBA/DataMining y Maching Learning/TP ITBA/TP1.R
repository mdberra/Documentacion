library(MASS)
base=shuttle
str(base)
fix(base)
head(base)
summary(base)
barplot(table(shuttle$use), col=c("green", "red"))
#-------------------------------------------------------------------------------
library(caret)
set.seed(8)
particion=createDataPartition(y=shuttle$use, p=0.7, list=FALSE)
train=shuttle[particion, ] 
test=shuttle[-particion, ]
head(train)
str(train)
summary(train)
head(test)
str(test)
summary(test)
#-------------------------------------------------------------------------------
library(rpart)
arbol=rpart(use~., train, method="class")
summary(arbol)
library(rpart.plot)
rpart.plot(arbol, extra=101, type=4, cex=0.8)
pred=predict(arbol, test, type="class")
table(pred, test$use)
confusionMatrix(pred, test$use)
#-------------------------------------------------------------------------------
library(nnet)
set.seed(8)
red=nnet(use~., train, size=6, maxit=5000)
library(NeuralNetTools)
plotnet(red)
pred=predict(red, test, type="class")
library(caret)
confusionMatrix(factor(pred), test$use)


