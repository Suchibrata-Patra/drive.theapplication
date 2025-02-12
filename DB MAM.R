rm(list=ls())
data=read.csv("data.csv")
View(data)
#Question Number (1)
cov(data[-1]) # variability i nthe expenditure is varying wrt foodd items
cor(data[-1])
#Comments : 

#Question Number (c)
#Factorial Techniques TO the Data And Plot in two Dimensions
x_matrix = as.matrix(data[,-1])
eigen_values = eigen(t(x_matrix) %*% x_matrix)$values ; eigen_values
eigen_vectors = eigen(t(x_matrix)%*%x_matrix)$vectors ; eigen_vectors
sorted_eigen_values = sort(eigen_values)
selected_two_components = sorted_eigen_values[c(1,2)]
eigen_vectors = eigen_values[selected_two_components]
