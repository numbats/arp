# Fit a linear regression model
# with numeric or categorical covariates

regression <- function(y, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10) {
  is.missing <- function(x) {missing(x)}
  inverse <- function(x) {solve(x)}
  X <- 1
  if(!is.missing(x1)) {
    X <- cbind(X, as.numeric(x1))
  }
  if(!is.missing(x2)) {
    X <- cbind(X, as.numeric(x2))
  }
  if(!is.missing(x3)) {
    X <- cbind(X, as.numeric(x3))
  }
  if(!is.missing(x4)) {
    X <- cbind(X, as.numeric(x4))
  }
  if(!is.missing(x5)) {
    X <- cbind(X, as.numeric(x5))
  }
  if(!is.missing(x6)) {
    X <- cbind(X, as.numeric(x6))
  }
  if(!is.missing(x7)) {
    X <- cbind(X, as.numeric(x7))
  }
  if(!is.missing(x8)) {
    X <- cbind(X, as.numeric(x8))
  }
  XprimeX <- t(X) * X
  beta <- inverse(XprimeX) * t(X) * y
  e <- y - X %*% beta
  sigma2 <- var(e)
  var_beta <- sigma2 * inverse(t(X) * X)
  output <- cbind(beta = beta, se = sqrt(diag(var_beta)))
  colnames(output) <- c("Estimate", "Std. Error")
  rownames(output) <- colnames(X)
  return(output)
}

# Test on simple problem
y <- c(1, 2, 3, 4, 5)
x1 <- c(10,13,14,18,20)
x2 <- c("A","A","B","B","B")
regression(y, x1)
regression(y, x1, x2)

# Test on difficult problem
beta1 <- regression(longley[,7], longley[,1], longley[,2], longley[,3],
           longley[,4], longley[,5], longley[,6])
fit2 <- lm(Employed ~ ., data = longley)
beta1
summary(fit2)
beta1$Estimate - coefficients(fit2)
beta1$`Std. Error` - sqrt(diag(vcov(fit2)))

# Test on big problem
n <- 1e7
regression(rnorm(n), rnorm(n), rnorm(n), rnorm(n), rnorm(n), rnorm(n), rnorm(n), rnorm(n), rnorm(n), rnorm(n), rnorm(n))
