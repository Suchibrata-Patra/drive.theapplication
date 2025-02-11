#Question No - 01
rm(list=ls())
pie = 0.1 ; lambda = 2
sample = numeric(10)
for(i in 1:10){
  index = runif(1,0,1)
  if(index<pie){
    sample[i] = 0
  }else{
    sample[i] = rpois(1,lambda)
  }
}
sample
#(b) Obtaining Estimate
lambda_hat = (var(sample)/mean(sample)-1)+mean(sample)
lambda_hat
xbar_hat = lambda_hat - pie*lambda_hat
xbar_hat


#Storing for 1000 times



