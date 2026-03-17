# Exercise 1

x <- sample(10)
x[3:5]
x[-(3:5)]
x[x > 5]
x[c("a", "b", "c")]
names(x) <- letters[1:10]
x[c("a", "b", "c")]

# Exercise 2

L <- list(a = 1, b = 2, c = 3)
L[1]
L[[1]]
L$a
L[["a"]]

# Exercise 3

x <- matrix(1:9, nrow = 3)
x[1, ]
x[, 2]
x[2, 3]
x[1, , drop = FALSE]
x[2]


# Exercise 4

mtcars[mtcars$cyl == 4, ]
mtcars |> filter(cyl == 4)

mtcars[-1:4, ]
mtcars[mtcars$cyl <= 5]
mtcars[mtcars$cyl %in% c(4, 6), ]

# Exercise 5

mod <- lm(mpg ~ wt, data = mtcars)
names(mod)
mod$df.residual

# Exercise 6

tmp <- summary(mod)
names(tmp)
tmp$r.squared

# Exercise 7

mtcars[, sample(NCOL(mtcars))]

# Exercise 8
m <- 10
mtcars[sample(NROW(mtcars), m), ]
mtcars[sample(NROW(mtcars) - m, 1) - 1 + seq(m), ]

# Exercise 9
mtcars[, order(colnames(mtcars))]

# Pre-class function

linear <- function(x, a = 0, b = 1) {
  stopifnot(is.numeric(x), is.numeric(a), is.numeric(b))
  a + b * x
}

linear(3)
linear(3:8)
linear(3:8, b = 2)
linear(3:8, b = 2, a = 1)
linear(matrix(1:10, nrow = 5), b = 2, a = 1)

# Exercise 10

sum(1, 2, 3)
mean(1, 2, 3)
sum(1, 2, 3, na.omit = TRUE)
mean(1, 2, 3, na.omit = TRUE)

# Exercise 11

x <- sample(replace = TRUE, 20, x = c(1:10, NA))
y <- runif(min = 0, max = 1, 20)
cor(m = "k", y = y, u = "p", x = x)

# Activity

fizz_buzz <- function(x) {
  if (!is.numeric(x)) {
    stop("x must be numeric")
  }
  if (abs(x - round(x)) >= .Machine$double.eps) {
    stop("x must be an integer")
  }
  if (x %% 5 == 0 && x %% 7 == 0) {
    output <- "fizzbuzz"
  } else if (x %% 5 == 0) {
    output <- "fizz"
  } else if (x %% 7 == 0) {
    output <- "buzz"
  } else {
    output <- as.character(x)
  }
  output
}

# Vectorised
fizz_buzz <- function(x) {
  if (!is.numeric(x)) {
    stop("x must be a numeric vector")
  }
  if (any(abs(x - round(x)) >= .Machine$double.eps)) {
    stop("x must be a vector of integers")
  }
  output <- as.character(x)
  output[x %% 5 == 0] <- "fizz"
  output[x %% 7 == 0] <- "buzz"
  output[x %% 5 == 0 & x %% 7 == 0] <- "fizzbuzz"
  output
}
