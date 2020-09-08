#-------------------------------------------------------------------------------
library(mlbench)
data(Vehicle)
base=Vehicle
summary(base$Class)
str(base)
#-------------------------------------------------------------------------------
head(base)
base$Class=NULL
head(base)
#-------------------------------------------------------------------------------
set.seed(8)
km=kmeans(base,3)  # separo en 3 grupos
km$centers
km$size
km$cluster[4]
#-------------------------------------------------------------------------------
plot(Vehicle$Comp, Vehicle$Circ, col=km$cluster)
points(km$centers[,c("Comp", "Circ")], col=c("black", "red", "green"), pch=8, cex=3)
#-------------------------------------------------------------------------------
boxplot(Vehicle$Comp~km$cluster)
#-------------------------------------------------------------------------------


barplot(km$center[ , 2], main="Centroides Circ")

km$withinss
km$betweenss








km$centers
barplot(km$center[ , 1], main="Centroides 1")
barplot(km$center[ , 2], main="Centroides 2")

names(km)
km$size
km$cluster # nos muestra los elementos que quedaron en cada grupo
km$cluster[km$cluster==1] # muestra los elementos del grupo 1
km$cluster[km$cluster==2] # muestra los elementos del grupo 2
km$cluster[km$cluster==3] # muestra los elementos del grupo 3
attach(Vehicle)
plot(Comp, Circ)

boxplot(Vehicle$Comp~km$cluster)
km$centers
barplot(km$center[ , 1], main="Centroides 1")
barplot(km$center[ , 2], main="Centroides 2")
barplot(km$center[ , 3], main="Centroides 3")


names(km) # nos muestra las propiedades que podemos utilizar
km$size   # nos dice la cantidad de animales en los 3 grupos
km$cluster # nos muestra los elementos que quedaron en cada grupo
km$cluster[km$cluster==1] # muestra los elementos del grupo 1
km$cluster[km$cluster==2] # muestra los elementos del grupo 2
attach(Vehicle)
plot(body, brain)
# identify(body, brain, labels=row.names(mammals))
plot(body, brain, col=km$cluster)
points(km$centers[ , c("body", "brain")], col=1:3, pch=8, cex=2) # muestra los centroides
km$centers
barplot(km$center[ , 1], main="Centroides body")
barplot(km$center[ , 2], main="Centroides brain")
boxplot(body~km$cluster)  # permite ver si la mediana de cada grupo esta bien diferenciada
library(pysch)
describeBy()
#
km=kmeans(mammals, 3, nstart=20 )  # separo en 3 grupos haciendo 20 kmeans siempre random y toma la mejor clasificacion
plot(body, brain, col=km$cluster)
points(km$centers[ , c("body", "brain")], col=1:3, pch=8, cex=2)
km$size
names(km)
km$withinss
km$tot.withinss
km$betweenss
#-------------------------
# dendograma
#-------------------------
dendo=hclust(dist(mammals))
plot(dendo)
plot(dendo, hang=-1) # los muestra en la misma linea
rect.hclust(dendo, k=5, border="red")
grupos=cutree(dendo, k=5)
grupos
#
nueva=cbind(mammals, grupos)
fix(nueva)