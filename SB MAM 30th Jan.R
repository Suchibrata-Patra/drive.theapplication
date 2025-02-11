library(MASS)
library(tidyverse)
glimpse(Boston)
??Boston
data = Boston
class(Boston)
#'chas' and 'rad' is not a ratio scale.

new_data = Boston[,c('medv',"crim","nox",'black','lstat')]
new_data
attach(Boston)
par(mfrow=c(2,2))

for(i in 2:5){
  plot(new_data[,i],medv,type='p')
}

Boston[which.min(Boston$medv),]
#which(Boston[,1]==min(data[,1]))

data[which(data[,1]==min(data[,1]))]
data[max(data[,1]==min(data[,1])),-1]


#Question No - 03
summary(data)
summary(data[,data])
boxplot(Boston$nox)
boxplot(Boston$crim)
boxplot(Boston$black)
boxplot(Boston$lstat)


which(data[,2])

plot(tax)
which(tax>700)

sum(chas) # Counting How many 1 is there in 'chas'
length(which(rm>7)) #Suburbs average more than seven rooms per dwelling?


# Summary statistics for crime rate, tax rate, and pupil-teacher ratio
summary(Boston[, c("crim", "tax", "ptratio")])

# Histograms to visualize distributions
par(mfrow = c(1, 3))  # Arrange plots in a 1x3 grid

# Histogram for crime rate
hist(Boston$crim, breaks = 50, main = "Crime Rate Distribution",
     xlab = "Per Capita Crime Rate", col = "lightblue")

# Histogram for tax rate
hist(Boston$tax, breaks = 50, main = "Tax Rate Distribution",
     xlab = "Property Tax Rate per $10,000", col = "lightgreen")

# Histogram for pupil-teacher ratio
hist(Boston$ptratio, breaks = 50, main = "Pupil-Teacher Ratio Distribution",
     xlab = "Pupil-Teacher Ratio", col = "lightcoral")


lm()