rm(list=ls())
library(ggplot2)
set.seed(1234)
m = matrix(0, nrow=100, ncol=2)
beta_simulation = function(p, q) {
  for (i in 1:100) {
    x = rbeta(10, p, q)
    p_hat = (mean(x) * (1 - mean(x)) / var(x) - 1) * mean(x)
    q_hat = p_hat * ((1 / mean(x)) - 1)
    m[i, 1] = p_hat;m[i, 2] = q_hat
  }
  hist(m[, 1], probability = TRUE, main = paste("Histogram of p_hat (p =", p, ", q =", q, ")"))
  lines(density(m[, 1]), col = "blue")
  
  hist(m[, 2], probability = TRUE, main = paste("Histogram of q_hat (p =", p, ", q =", q, ")"))
  lines(density(m[, 2]), col = "red")
}
par(mfrow = c(4, 2))
beta_simulation(0.5, 0.5)
beta_simulation(0.5, 2)
beta_simulation(2, 0.5)
beta_simulation(2, 2)