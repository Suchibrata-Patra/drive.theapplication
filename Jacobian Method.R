#cmna #jacobi #gaussseidel
## First Check for the Diagonal 
# install.packages('cmna')
rm(list=ls())
library(cmna)
A = matrix(c(1,3,-2,3,7,1,-2,1,7),nrow=3,byrow=TRUE)
B = c(-4,4,7)
jacobi(A,B,maxiter=500)

??gaussseidel



jacobi_method = function(A, b, tolerate = 1e-6, maximum_no_of_iteration = 100) {
  n = nrow(A)
  x = rep(0, n)
  x_new_value = x
  for (iter in 1:maximum_no_of_iteration) {
    for (i in 1:n) {
      x_new_value[i] = (b[i] - sum(A[i, -i] * x[-i])) / A[i, i]
    }
    if (max(abs(x_new_value - x)) < tolerate) {
      return(list(solution = x_new_value, iterations = iter))
    }
    x = x_new_value
  }
  stop("Jacobi method did not converge")
}
jacobi_method(A,B)

