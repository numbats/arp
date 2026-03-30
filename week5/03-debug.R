# Use debug() to find what's wrong with this multivariate scaling function?

mvscale <- function(object) {
  # centre the data
  mat <- sweep(object, 2L, colMeans(object))
  # compute the covariance matrix
  S <- cov(mat)
  # rotate and scale the result
  U <- chol(solve(S))
  z <- mat * t(U)
  # return the scaled data
  return(z)
}

mvscale(as.matrix(mtcars[, 1:4]))
