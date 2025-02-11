rm(list=ls())
library(ISLR)
attach(Credit)
plot(Limit,Age) # No linear relationship
plot(Limit,Rating) # Linear relationship is present there

lmfit1 = lm(Balance~Age+Limit+Rating)
summary(lmfit1)

lmfit2 = lm(Balance~Age+Limit)
summary(lmfit2)

#Finding out the Correlation between the Limit and Rating
cor(Limit,Rating)
