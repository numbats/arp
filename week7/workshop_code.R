

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

## Vectorisation

calc_area <- function(N = 1e4) {
  hits <- 0
  N <- 1e3
  for(i in seq(N)) {
    u1 <- runif(1, 0,1)
    u2 <- runif(1, 0,1)
    if(u2 < u1^2)
      hits <- hits + 1
  }
  hits/N
}

calc_area2 <- function(N = 1e4) {
  u1 <- runif(N, 0, 1)
  u2 <- runif(N, 0, 1)
  mean(u2 < u1^2)
}

bench::mark(
  calc_area(),
  calc_area2(),
  check = FALSE
)
