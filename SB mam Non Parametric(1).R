#Test on Sales of Randomly Selected Shoes.
rm(list=ls())
data = c(43,46,57,45,55,26,234,200,212,253,260,251)
mu = mean(data)
test_statistic = (mu-140)/sqrt(var(data)/length(data))
test_statistic
# X = monthly sale of randomly selected shoe, collected from 
# H0 : mu=140 ; H1: mu>140

# Since Sigma is unknown , we are going to perform one sample T test 
# X follows Normal (mu,sigma^2), both are unknown
t.test(data,mu=140,alternative="greater")
# We don't reject H0 at 5% level of Significance.[Since, p_value is greater than 0.05]


#Sale of Shoes [Parametric Setup]
#We are going to perform Sign Test under Continuity Assumptions.
install.packages('BSDA')
library(BSDA)
SIGN.test(data,md=140,alternative = "greater")


hist(data,probability = TRUE)

# Basic Q-Q plot
qqnorm(data)
qqline(data, col = "blue") #Adds a reference line
# Q-Q plot 


# Perform Shapiro TEST
shapiro.test(data)

# Shapiro-Wilk test is a statistical test used to assess whether a given sample data set 
# is normally distributed, essentially checking if the data follows a "normal" bell curve 
# distribution; it is considered one of the most reliable methods for testing normality
# assumptions in statistical analysis.



