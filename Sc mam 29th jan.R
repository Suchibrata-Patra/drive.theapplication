rm(list=ls())
library(MASS)
library(tidyverse)
data = Boston[,-4]
#NOTE : 'medv' - representative house price of a particular suburb
#Take : 'rad' as discrete value instead of Categorical Variables.
#view(data)
glimpse(Boston)

#Training Sample
train = data[1:406,]
test = data[407:506,]


lfit = lm(medv ~ .,train)
library(stargazer)
stargazer(lfit,type="text",title="House price of Different Predictors",dep.var.labels = "Median House Price",out="regression.txt")
#Note - 

sum((train$medv-fitted(lfit))^2)/length(train)

mean((train$medv - predict(lfit,train))^2)
mean(resid(lfit)^2)

plot(predict(lfit,train),resid(lfit))
abline(h=0)


rm(list=ls())
x = c(1,1,3,3,4,4,5,6,6,7)
y = c(4,7,9,12,11,12,17,13,18,17)
data = data.frame(x,y)
plot(x,y,type="p",xlim=c(0,30),ylim=c(0,20))


summary(x)
summary(y)




