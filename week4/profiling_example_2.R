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
