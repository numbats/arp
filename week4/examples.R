# Example 1

f <- function(a) g(a)
g <- function(b) h(b)
h <- function(c) i(c)
i <- function(d) {
  if (!is.numeric(d)) {
    stop("`d` must be numeric", call. = FALSE)
  }
  d + 10
}
f("a")
traceback()

options(error = recover)
f("a")


# Example 2

transform_number <- function(x) {
  square <- x^2
  if (x >= 0) {
    logx <- log(x)
    sqrtx <- sqrt(x)
  } else {
    stop("x must be positive")
  }
  return(c(squared = square, log = logx, sqrt = sqrtx))
}
transform_number(2)
transform_number(-1)
transform_number(NA)
transform_number("3")

# Example 4

# Multivariate scaling function
mvscale <- function(object) {
  # Remove centers
  mat <- sweep(object, 2L, colMeans(object))
  # Scale and rotate
  S <- var(mat)
  U <- chol(solve(S))
  z <- mat %*% t(U)
  # Return orthogonalized data
  return(z)
}
mvscale(mtcars)
