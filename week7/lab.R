library(rlang)

xfun::cache_rds("cache.rds", y())

compute <- function(...) {
  xfun::cache_rds(
    {
      cat("Computing...\n")
      rnorm(13)
    },
    file = "results.rds",
    ...
  )
}
compute()

library(memoise)
sq <- function(x) {
  cat("Computing square of 'x'")
  x^2
}
memo_sq <- memoise(sq)

memo_sq(2)


mean_memoise <- memoise(mean)
mean_memoise(1:10)


react_cache <- function(e) {
  e <- enexpr(e)
  e_depends <- all.vars(e)

  env <- new.env(parent = emptyenv())

  new_function(
    alist(),
    expr({
      browser()
      # Check the invalidation cache
      dependency_values <- mget(e_depends, envir = parent.frame())
      mget(e_depends, env, ifnotfound = NULL)

      # Evaluate the code if needed
      env$result <- eval(!!e)
      env$result
    })
  )
}
a <- 3
b <- a + 2

x <- react_cache(a + b)
x()


sessioninfo::session_info()
reprex::reprex(session_info = TRUE)
