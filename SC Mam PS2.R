

rm(list=ls())
set.seed(123) ; n = 50
number_of_simulations = 5
population_regression = function(x) { return(2 + 3 * x) }
x_population = seq(5, 10, length.out = 100)
y_population = population_regression(x_population)
plot(x_population, y_population, type = "l", col = "blue", lwd = 2,
     main = "Population Regression Line (Fixed)",
     xlab = "x", ylab = "y")
par(mfrow = c(3, 3))  # 3x3 Layout
models = list()

for (i in 1:number_of_simulations) {
  x = runif(n, min = 5, max = 10)
  epsilon = rnorm(n, mean = 0, sd = 4)
  y = 2 + 3 * x + epsilon
  model = lm(y ~ x)
  models[[i]] = model
  plot(x, y, pch = 19, col = "black", xlab = "x", ylab = "y",
       main = paste("Least Squares Regression - Simulation", i))
  abline(model, col = "red", lwd = 2)
  lines(x_population, y_population, col = "blue", lwd = 2)
}
par(mfrow = c(1, 1))  # Reset to default


