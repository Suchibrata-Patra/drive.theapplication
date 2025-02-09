#Question Number - 02
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

#Question - 03
# Load necessary library
library(ggplot2)

# Function to compute log-likelihood for a given sample and mu
log_likelihood <- function(mu, sample) {
  n <- length(sample)
  -n * log(pi) - sum(log(1 + (sample - mu)^2))
}

# (a) Generate a random sample of size n = 5 from Cauchy(μ=0, σ=1)
set.seed(123)  # For reproducibility
mu_true <- 0
sigma_true <- 1
n <- 5

# Generate random sample
sample <- rcauchy(n, location = mu_true, scale = sigma_true)
cat("Random Sample:\n")
print(sample)

# Plot histogram of the random sample
ggplot(data.frame(sample), aes(x = sample)) +
  geom_histogram(aes(y = ..density..), bins = 10, fill = "green", alpha = 0.6, color = "black") +
  ggtitle("Random Sample from Cauchy(μ=0, σ=1) - n=5") +
  xlab("x") +
  ylab("Density") +
  theme_minimal()

# (b) Plot the log-likelihood function of μ
mu_values <- seq(-10, 10, length.out = 400)
log_likelihood_values <- sapply(mu_values, log_likelihood, sample = sample)

# Plot log-likelihood function
ggplot(data.frame(mu_values, log_likelihood_values), aes(x = mu_values, y = log_likelihood_values)) +
  geom_line(color = "blue") +
  ggtitle("Log Likelihood Function of μ") +
  xlab("μ") +
  ylab("Log Likelihood") +
  theme_minimal()

# (c) Find the value of μ where the log-likelihood reaches its maximum
max_ll_mu <- mu_values[which.max(log_likelihood_values)]
cat("Maximum Likelihood Estimate of μ (from plot):", max_ll_mu, "\n")

# Plot the log-likelihood with the maximum likelihood estimate
ggplot(data.frame(mu_values, log_likelihood_values), aes(x = mu_values, y = log_likelihood_values)) +
  geom_line(color = "blue") +
  geom_vline(xintercept = max_ll_mu, color = "red", linetype = "dashed") +
  ggtitle("Log Likelihood Function of μ with Maximum Likelihood Estimate") +
  xlab("μ") +
  ylab("Log Likelihood") +
  theme_minimal()

# (d) Maximum Likelihood Estimate of μ
# As before, we know the MLE is where log-likelihood is maximized
cat("Maximum Likelihood Estimate of μ:", max_ll_mu, "\n")

# (e) Plot the MLE estimate on the graph
ggplot(data.frame(mu_values, log_likelihood_values), aes(x = mu_values, y = log_likelihood_values)) +
  geom_line(color = "blue") +
  geom_vline(xintercept = max_ll_mu, color = "red", linetype = "dashed") +
  ggtitle("Log Likelihood with Maximum Likelihood Estimate of μ") +
  xlab("μ") +
  ylab("Log Likelihood") +
  theme_minimal()

# (f) Repeat for R = 500 times and obtain the average of these estimates
R <- 500
mle_estimates <- numeric(R)

for (i in 1:R) {
  sample <- rcauchy(n, location = mu_true, scale = sigma_true)
  log_likelihood_values <- sapply(mu_values, log_likelihood, sample = sample)
  mle_estimates[i] <- mu_values[which.max(log_likelihood_values)]
}

average_mle <- mean(mle_estimates)
cat("Average of MLE estimates over", R, "samples:", average_mle, "\n")

# (g) Repeat for different sample sizes n = 10, 20, 50, 100, 500
sample_sizes <- c(10, 20, 50, 100, 500)
results <- data.frame(n = sample_sizes, average_mle = numeric(length(sample_sizes)))

for (size_idx in 1:length(sample_sizes)) {
  n <- sample_sizes[size_idx]
  mle_estimates <- numeric(R)
  
  for (i in 1:R) {
    sample <- rcauchy(n, location = mu_true, scale = sigma_true)
    log_likelihood_values <- sapply(mu_values, log_likelihood, sample = sample)
    mle_estimates[i] <- mu_values[which.max(log_likelihood_values)]
  }
  
  results$average_mle[size_idx] <- mean(mle_estimates)
  cat("Average MLE estimate for n =", n, ":", results$average_mle[size_idx], "\n")
}

# Print results for all sample sizes
print(results)

# (h) Plot the MLE estimates for different sample sizes
ggplot(results, aes(x = n, y = average_mle)) +
  geom_point() +
  geom_line(group = 1, color = "blue") +
  ggtitle("Average MLE Estimates for Different Sample Sizes") +
  xlab("Sample Size (n)") +
  ylab("Average MLE Estimate") +
  theme_minimal()
