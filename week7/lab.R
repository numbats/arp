library(rlang)
library(profvis)
library(bench)

# Profiling

f <- function() {
  mean(rnorm(1e7))
  g()
  h()
}
g <- function() {
  mean(rnorm(1e7))
  h()
}
h <- function() {
  mean(rnorm(1e7))
}

tmp <- tempfile()
Rprof(tmp, interval = 0.1)
f()
Rprof(NULL)

summaryRprof(tmp)

profvis(f())

bad_seq <- function(n = 1e5) {
  x <- NULL
  for (i in seq(n)) {
    x <- c(x, i)
  }
  return(x)
}

bad_seq(5)

profvis::profvis(bad_seq(1e5))

# Benchmarking

x <- rnorm(1e6)
system.time(min(x))
system.time(sort(x)[1])
system.time(x[order(x)[1]])

bench::mark(
  min(x),
  sort(x)[1],
  x[order(x)[1]]
)

x <- exp(rnorm(1e6))
system.time(sqrt(x))
system.time(x^0.5)
system.time(exp(log(x) / 2))

bench::mark(
  sqrt(x),
  x^0.5,
  exp(log(x) / 2)
)


# Vectorisation

hits <- 0
N <- 1e6
for (i in seq(N)) {
  u1 <- runif(1)
  u2 <- runif(1)
  if (u2 < u1^2) {
    hits <- hits + 1
  }
}
hits / N

mean(runif(1e6)^2 > runif(1e6))


x <- matrix(rnorm(1e6), ncol = 10)
system.time(apply(x, 1, sum))
system.time(rowSums(x))

bench::mark(
  apply(x, 1, sum),
  rowSums(x)
)


# Other efficiency improvements

n <- 1e4
x <- rnorm(n)
bench::mark(
  bad = c(mean = mean(x), var = var(x), sd = sqrt(var(x))),
  good = {
    v <- var(x)
    c(mean = mean(x), var = v, sd = sqrt(v))
  }
)

bench::mark(
  growing = {
    result <- c()
    for (i in seq_len(n)) {
      result <- c(result, i^2)
    }
  },
  preallocated = {
    result <- numeric(n)
    for (i in seq_len(n)) {
      result[i] <- i^2
    }
  }
)

x <- rnorm(1e6)
bench::mark(
  slow = which(x == min(x))[1],
  fast = which.min(x)
)

n <- 1e4
x <- rnorm(n)
bench::mark(
  inside = {
    result <- numeric(n)
    for (i in seq_len(n)) {
      result[i] <- x[i] * mean(x)
    }
  },
  outside = {
    mx <- mean(x)
    result <- numeric(n)
    for (i in seq_len(n)) {
      result[i] <- x[i] * mx
    }
  }
)

library(data.table)
library(dplyr)
n <- 1e6
df <- data.frame(g = sample(letters, n, replace = TRUE), x = rnorm(n))
dt <- as.data.table(df)
bench::mark(
  data.frame = summarise(df, mean(x), .by = g),
  data.table = dt[, .(mean = mean(x)), by = g],
  check = FALSE
)

n <- 500
df <- as.data.frame(matrix(rnorm(n^2), nrow = n))
mat <- as.matrix(df)
bench::mark(
  data.frame = t(df) %*% as.matrix(df),
  matrix = t(mat) %*% mat
)

# Caching

compute_it <- function() {
  mean(seq(1e8))
}
system.time(compute_it())

system.time(xfun::cache_rds(compute_it(), file = "cache.rds"))
system.time(xfun::cache_rds(compute_it(), file = "cache.rds", rerun = TRUE))

download_data <- function(url) {
  dest_folder <- tempdir()
  sanitized_url <- stringr::str_replace_all(url, "/", "_")
  dest_file <- file.path(dest_folder, paste0(sanitized_url, ".rds"))
  if (file.exists(dest_file)) {
    data <- readRDS(dest_file)
  } else {
    data <- readr::read_tsv(url, show_col_types = FALSE)
    saveRDS(data, dest_file)
  }
  data
}
bulldozers <- download_data(
  "https://robjhyndman.com/data/Bulldozers.csv"
)

library(memoise)
sq <- function(x) {
  #cat("Computing square of 'x'")
  x^2
}
memo_sq <- memoise(sq)

memo_sq(2)
memo_sq(2)

bench::mark(
  sq(1:1e7),
  memo_sq(1:1e7)
)


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
