

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

