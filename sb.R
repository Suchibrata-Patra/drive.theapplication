rm(list=ls())
set.seed(1234)
n = 20 ; sample =sort(rnorm(n,0,1))

r1 = round((n+1)*0.25);r1
first_quartile = (sample[r1]+sample[r1+1])/2 ; first_quartile

r2 = round((n+1)*0.5);r2
median = (sample[r2]+sample[r2+1])/2;median

r3 = round((n+1)*0.75);r3
third_quartile = (sample[r3]+sample[r3+1])/2 ; third_quartile


n = 35
sample =rnorm(n,0,1)
sample = sort(sample)
r = round((n+1)*0.5);r
(sample[r])
plot(sample,type='l')
summary(sample)
(sample[(35+1)*0.25] - sample[(35+1)*0.25+1])

sample[36*0.25]







#Binomial
rm(list=ls())
my_plot = function(n){
  set.seed(1234)
  Xi_bar = numeric(1000)
  for(i in 1:1000){
    Xi_bar[i] = mean(rbinom(20,5,0.5))
  }
  values = (Xi_bar - 2.5)/sqrt(1.25/n)
  hist(values,probability = TRUE,main = paste("Histogram of (n =", n, ")"))
  lines(density(values))
}

par(mfrow=c(2,2))
my_plot(20)
my_plot(50)
my_plot(70)
my_plot(100)





rm(list=ls())
set.seed(1234)
n = 20 ; sample =sort(rnorm(n,0,1))

r1 = round((n+1)*0.25);r1
first_quartile = (sample[r1]+sample[r1+1])/2 ; first_quartile

r2 = round((n+1)*0.5);r2
median = (sample[r2]+sample[r2+1])/2;median

r3 = round((n+1)*0.75);r3
third_quartile = (sample[r3]+sample[r3+1])/2 ; third_quartile


n = 35
sample =rnorm(n,0,1)
sample = sort(sample)
r = round((n+1)*0.5);r
(sample[r])
plot(sample,type='l')
summary(sample)
(sample[(35+1)*0.25] - sample[(35+1)*0.25+1])

sample[36*0.25]







#Poisson
rm(list=ls())
my_plot = function(n){
  set.seed(1234)
  Xi_bar = numeric(1000)
  for(i in 1:1000){
    Xi_bar[i] = mean(rpois(n,1))
  }
  values = (Xi_bar - 1)/sqrt(1/n)
  hist(values,probability = TRUE,main = paste("Histogram of (n =", n, ")"),ylim=c(0,0.6))
  lines(density(values))
}

par(mfrow=c(2,2))
my_plot(20)
my_plot(50)
my_plot(70)
my_plot(100)


#Normal
rm(list=ls())
my_plot = function(n){
  set.seed(1234)
  Xi_bar = numeric(1000)
  for(i in 1:1000){
    Xi_bar[i] = mean(rnorm(n,1,1))
  }
  values = (Xi_bar - 1)/sqrt(1/n)
  hist(values,probability = TRUE,main = paste("Histogram of (n =", n, ")"),ylim=c(0,0.6))
  lines(density(values))
}

par(mfrow=c(2,2))
my_plot(20)
my_plot(50)
my_plot(70)
my_plot(100)



#Cauchy
rm(list=ls())
my_plot = function(n){
  set.seed(1234)
  Xi_bar = numeric(1000)
  for(i in 1:1000){
    Xi_bar[i] = median(rcauchy(n,1,1))
  }
  values = (Xi_bar - 0)/sqrt(1/n)
  hist(values,probability = TRUE,main = paste("Histogram of (n =", n, ")"),ylim=c(0,0.6))
  lines(density(values))
}

par(mfrow=c(2,2))
my_plot(20)
my_plot(50)
my_plot(70)
my_plot(100)









