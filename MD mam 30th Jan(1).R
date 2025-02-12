rm(list=ls())
mu = c(2,4,3)
a = c(1,2,1)
dispersion= matrix(c(3,1,2,1,4,6,2,6,10),nrow=3,byrow=TRUE) ; dispersion
#Expectation
t(a)%*%mu
t(a)%*%dispersion%*%a