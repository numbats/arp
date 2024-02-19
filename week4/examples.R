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

f <- function(n = 1e5) {
  x <- rep(1, n)
  rm(x)
}
