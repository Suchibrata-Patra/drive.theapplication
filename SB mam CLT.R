#Binomial
rm(list=ls())
n = c(20, 50, 70, 100)
R = 1000

my_plot = function(sample_size,size=5,p=0.5) {
  x_bar = numeric(R)
  for(i in 1:R) {
    sample = rbinom(sample_size, size, p)
    x_bar[i] = mean(sample)
  }
  mu = size * p
  sigma = sqrt(size * p * (1 - p))
  observed = (x_bar - mu) / (sigma / sqrt(sample_size))
  hist(observed, probability = TRUE, main=paste("CLT Approximation of Binomial for n =", sample_size), 
       col="lightblue", breaks=20)
  curve(dnorm(x, mean=0, sd=1), col="red", lwd=2, add=TRUE)
}
par(mfrow=c(2,2))
for(counnter in n) {
  my_plot(counnter)
}

#Poisson
rm(list=ls())
n = c(20, 50, 70, 100)
R = 1000
my_plot = function(sample_size,lambda=1) {
  x_bar = numeric(R)
  for(i in 1:R) {
    sample = rpois(sample_size,lambda)
    x_bar[i] = mean(sample)
  }
  mu = lambda
  sigma = lambda
  observed = (x_bar - mu) / (sigma / sqrt(sample_size))
  hist(observed, probability = TRUE, main=paste("CLT Approximation of Poisson for n =", sample_size), 
       col="lightblue", breaks=20)
  curve(dnorm(x, mean=0, sd=1), col="red", lwd=2, add=TRUE)
}
par(mfrow=c(2,2))
for(counnter in n) {
  my_plot(counnter)
}


#Normal
rm(list=ls())
n = c(20, 50, 70, 100)
R = 1000
my_plot = function(sample_size,mean=1,sd=1) {
  x_bar = numeric(R)
  for(i in 1:R) {
    sample = rnorm(sample_size,mean,sd)
    x_bar[i] = mean(sample)
  }
  mu = mean
  sigma = sd
  observed = (x_bar - mu) / (sigma / sqrt(sample_size))
  hist(observed, probability = TRUE, main=paste("CLT Approximation of Normal for n =", sample_size), 
       col="lightblue", breaks=20)
  curve(dnorm(x, mean=0, sd=1), col="red", lwd=2, add=TRUE)
}
par(mfrow=c(2,2))
for(counnter in n) {
  my_plot(counnter)
}

#Cauchy
rm(list=ls())
n = c(20, 50, 70, 100) ; R = 1000
my_plot = function(sample_size,scale=0,shape=1) {
  x_bar = numeric(R)
  for(i in 1:R) {
    sample = rcauchy(sample_size,scale,shape)
    x_bar[i] = mean(sample)
  }
  mu = median(sample)
  sigma = IQR(sample)/1.3
  observed = (x_bar - mu) / (sigma / sqrt(sample_size))
  hist(observed, probability = TRUE, main=paste("CLT Approximation of Cauchy for n =", sample_size), 
       col="lightblue", breaks=20)
  curve(dnorm(x, mean=0, sd=1), col="red", lwd=2, add=TRUE)
}
par(mfrow=c(2,2))
for(counnter in n) {
  my_plot(counnter)
}


#Note : we observe that, Cauchy Distribution doesn't follow Central Limit Theorems.

