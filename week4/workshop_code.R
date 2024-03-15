## Using traceback and debug (Slide 8)

f <- function(a) g(a)
g <- function(b) h(b)
h <- function(c) i(c)
i <- function(d) {
  if (!is.numeric(d)) stop("`d` must be numeric", call. = FALSE)
  d + 10
}
f("a")

traceback()

options(error = recover)
f("a")



# Exercise 1 (slide 11): Multivariate scaling function
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


## Slide 20

library(profvis)
library(bench)
f <- function() {
  pause(0.1)
  g()
  h()
}
g <- function() {
  pause(0.1)
  h()
}
h <- function() {
  pause(0.1)
}


# Slide 21

tmp <- tempfile()
Rprof(tmp, interval = 0.1)
f()
Rprof(NULL)
writeLines(readLines(tmp))

profvis(f())

## Additional profiling example

Rprof()
x <- NULL
for(i in seq(1e5)) {
  x <- c(x, i)
}
Rprof(NULL)
summaryRprof()

Rprof()
x <- numeric(1e5)
for(i in seq(1e5)) {
  x[i] <- i
}
Rprof(NULL)
summaryRprof()

f <- function(n = 1e5) {
  x <- NULL
  for(i in seq(n)) {
    x <- c(x, i)
  }
  return(x)
}

profvis::profvis(f(1e4))

## Slide 23

x <- rnorm(1e6)
system.time(min(x))
system.time(sort(x)[1])
system.time(x[order(x)[1]])

## Slide 24

bench::mark(
  min(x),
  sort(x)[1],
  x[order(x)[1]]
)

## Exercise 2: Slide 26

x <- exp(rnorm(1e7))
system.time(sqrt(x))
system.time(x^0.5)
system.time(exp(log(x) / 2))

bench::mark(sqrt(x), x^0.5, exp(log(x) / 2))

## Exercise 3: Slide 27

sort(x, partial = 2)


# Caching

compute <- function(...) {
    xfun::cache_rds(rnorm(6), file = "results.rds", ...)
}
compute()
compute()
compute(rerun = TRUE)
compute()


library(memoise)
sq <- function(x) {
  print("Computing square of 'x'")
  x**2
}
memo_sq <- memoise(sq)
memo_sq(2)
memo_sq(2)
