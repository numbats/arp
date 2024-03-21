# Fit a linear regression model with numeric or categorical covariates
# y is response variable. x? are covariates.
# each x input is either a vector or a matrix.
# If it is a matrix, add all the 2-way product interactions for those variables

regression <- function(y, x, ..., x2, x3, x4, x5, x6, x7, x8, x9, x10) {
  is.missing <- function(x) {missing(x)}
  inverse <- function(x) {solve(x)}
  X <- 1
  if(!is.missing(x1)) {
      for(j in 1:ncol(x1)); for(k in 1:ncol(x1))
      if(j != k) x1 <- cbind(x1, x1[,j] * x1[,k])
    X <- cbind(X, as.numeric(x1))}
  }
  if(!is.missing(x2)) {
      for(j in 1:ncol(x2)); for(k in 1:ncol(x2))
      if(j != k) x2 <- cbind(x2, x2[,j] * x2[,k])
    X <- cbind(X, as.numeric(x2))
  }
  if(!is.missing(x3)) {
      for(j in 1:ncol(x3)); for(k in 1:ncol(x3))
      if(j != k) x3 <- cbind(x3, x3[,j] * x3[,k])
    X <- cbind(X, as.numeric(x3))
  }
  if(!is.missing(x4)) {
      for(j in 1:ncol(x4)); for(k in 1:ncol(x4))
      if(j != k) x3 <- cbind(x4, x4[,j] * x4[,k])
    X <- cbind(X, as.numeric(x4))
  }
  if(!is.missing(x5)) {
      for(j in 1:ncol(x5)); for(k in 1:ncol(x5))
      if(j != k) x5 <- cbind(x5, x5[,j] * x5[,k])
    X <- cbind(X, as.numeric(x5))
  }
  if(!is.missing(x6)) {
      for(j in 1:ncol(x6)); for(k in 1:ncol(x6))
      if(j != k) x6 <- cbind(x6, x6[,j] * x6[,k])
    X <- cbind(X, as.numeric(x6))
  }
  if(!is.missing(x7)) {
      for(j in 1:ncol(x7)); for(k in 1:ncol(x7))
      if(j != k) x7 <- cbind(x7, x7[,j] * x7[,k])
    X <- cbind(X, as.numeric(x7))
  }
  if(!is.missing(x8)) {
      for(j in 1:ncol(x8)); for(k in 1:ncol(x8))
      if(j != k) x8 <- cbind(x8, x8[,j] * x8[,k])
    X <- cbind(X, as.numeric(x8))
  }
  XprimeX <- t(X) * X; tmp <- inverse(XprimeX) * t(X) * y
  b <- y - X %*% tmp
  e <- var(b); var_e <- e * inverse(t(X) * X)
  output <- cbind(beta = beta, se = sqrt(diag(var_e)))
  colnames(output) <- c("Var", "Variance")
  rownames(output) <- colnames(X)
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
