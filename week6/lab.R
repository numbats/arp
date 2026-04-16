library(tibble)
class(tibble)
class(tibble())

# Functions are objects --------------------------------------------------------

square <- function(x) {
  if (!is.numeric(x)) {
    stop("`x` needs to be numeric")
  }
  return(x^2)
}
square(10)

# Functions can be printed
print(square)

# But they can't be subsetted
square$x

# Functions can be inspected
formals(square)
body(square)
environment(square)

# Modifying function components
square()
formals(square) <- list(x = numeric())
square()
environment(square) <- emptyenv()
square
square(10)

# Functions can be put in a list
my_functions <- list(square, sum, min, max)
my_functions
my_functions[[1]](8)


# Function inputs --------------------------------------------------------------

# The "bad" accuracy: limited to specific measures
accuracy_bad <- function(e, measure, ...) {
  if (measure == "mae") {
    mean(abs(e), ...)
  } else if (measure == "rmse") {
    sqrt(mean(e^2, ...))
  } else {
    stop("Unknown accuracy measure")
  }
}

# Better: accept any function as measure
MAE <- function(e, ...) mean(abs(e), ...)
RMSE <- function(e, ...) sqrt(mean(e^2, ...))
accuracy <- function(e, measure, ...) {
  measure(e, ...)
}
x <- rnorm(100)
accuracy(x, MAE)
accuracy_bad(x, "mae")
accuracy(x, mean)

residuals <- rnorm(100)
residuals[runif(100) > 0.5] <- NA
residuals
accuracy(residuals[!is.na(residuals)], measure = RMSE)
accuracy(residuals, measure = RMSE, na.rm = TRUE)

colorRamp()

redgreen_ramp <- colorRamp(c("red", "green"))
redgreen_ramp(0)
redgreen_ramp(1)
redgreen_ramp(0.3421348)
redgreen_ramp(runif(10))

colorRamp(c("red", "green"))(0.312381247)

# Function factories -----------------------------------------------------------

# Before factory: explicit exp argument
power <- function(x, exp) {
  x^exp
}
power(8, exp = 2)
power(8, exp = 3)

# Factory version
power_factory <- function(exp) {
  function(x) {
    x^exp
  }
}
power_factory(2)(8)
square <- power_factory(2)
square(8)
cube <- power_factory(3)
cube(8)

ls(envir = environment(cube))
environment(cube)$exp
environment(square)$exp

breakpoints <- function(x, n.breaks) {
  seq(min(x), max(x), length.out = n.breaks)
}
breakpoints(mtcars$mpg, 10)

make_breakpoints <- function(n.breaks) {
  # return a function!
  function(x) {
    seq(min(x), max(x), length.out = n.breaks)
  }
}
make_breakpoints(5)(mtcars$mpg)

make_breakpoints_x <- function(x) {
  minx <- min(x)
  maxx <- max(x)
  rm(x)

  function(n.breaks) {
    seq(minx, maxx, length.out = n.breaks)
  }
}

mpg_breakpoints <- make_breakpoints_x(mtcars$mpg)
ls(envir = environment(mpg_breakpoints))
environment(mpg_breakpoints)$x
mpg_breakpoints(10)
mpg_breakpoints(5)

# map --------------------------------------------------------------------------

library(purrr)
map

# for loop approach
x <- c(1, 3, 8)
x2 <- numeric(length(x))
for (i in seq_along(x)) {
  x2[i] <- square(x[i])
}
x2

# map approach
map(x, square) # lapply(x, square)
map_vec(x, square) # vapply(x, square, numeric(1L))

# Split-apply-combine with dplyr
library(dplyr)
mtcars |>
  group_by(cyl) |>
  summarise(mean(mpg))

# Using split() and map_vec() to achieve the same
split(mtcars$mpg, mtcars$cyl) |>
  map_vec(mean)

mpg_by_cyl <- split(mtcars$mpg, mtcars$cyl)
map(mpg_by_cyl, mean)
map_vec(mpg_by_cyl, mean)

# Anonymous mapper functions ---------------------------------------------------

mtcars_by_cyl <- split(mtcars, mtcars$cyl)
mtcars_by_cyl

lm(mpg ~ disp + hp + drat + wt, 
  mtcars_by_cyl[[1]])

# This won't work — mapped vector goes to first argument (formula position)
map(mtcars_by_cyl, lm, mpg ~ disp + hp + drat + wt)

# Named function approach
mtcars_lm <- function(.) lm(mpg ~ disp + hp + drat + wt, data = .)
map(mtcars_by_cyl, mtcars_lm)

# Anonymous function approach
map(mtcars_by_cyl, ~ lm(mpg ~ disp + hp + drat + wt, data = .))


# Chain maps to get coefficients from all 3 models
mtcars_by_cyl |>
  map(~ lm(mpg ~ disp + hp + drat + wt, data = .)) |>
  map(coef)

mtcars_by_cyl |>
  map(~ coef(lm(mpg ~ disp + hp + drat + wt, data = .))) 


# Mapping with extra arguments -------------------------------------------------

mpg_by_cyl <- split(mtcars$mpg, mtcars$cyl)
map(mpg_by_cyl, mean, na.rm = TRUE)

x <- list(1:5, c(1:10, NA))
map_dbl(x, ~ mean(.x, na.rm = TRUE))
map_dbl(x, mean, na.rm = TRUE)

# map2 and pmap ----------------------------------------------------------------

ws <- map(1:8, ~ ifelse(runif(10) > 0.8, NA, runif(10)))
map_vec(ws, mean, na.rm = TRUE)

xs <- map(1:8, ~ rpois(10, 5) + 1)
map2_vec(xs, ws, weighted.mean, na.rm = TRUE)

n <- 1:3
min <- c(0, 10, 100)
max <- c(1, 100, 1000)
pmap(list(n, min, max), runif) # .mapply(runif, list(n, min, max), list())

# Parallel mapping with furrr --------------------------------------------------

library(furrr)
plan(multisession, workers = 4)
future_map_dbl(xs, mean, na.rm = TRUE)
future_map2_dbl(xs, ws, weighted.mean, na.rm = TRUE)

# reduce -----------------------------------------------------------------------

x <- sample(1:100, 10)
x
sum(x)
reduce(x, `+`) # Reduce(`+`, x)

alphabet_soup <- map(c(10, 24, 13), sample, x = letters, replace = TRUE)
alphabet_soup

# Find letters that were in all bowls of soup
reduce(alphabet_soup, intersect)

# Are all letters found in the soups?
# Letters not found in any soup
reduce(alphabet_soup, union) |>
  unique() |>
  setdiff(letters)

# Examples of purrr adverbs ----------------------------------------------------

list("a", 10, 100) |> map_dbl(log)
list("a", 10, 100) |> map_dbl(possibly(log, NA_real_))

list("a", 10, 100) |> map(safely(log))

f <- function() {
  print("Hi!")
  message("Hello")
  warning("How are ya?")
  "Gidday"
}
f()

f_quiet <- quietly(f)
f_quiet()

is_not_numeric <- negate(is.numeric)
is_not_numeric(10)
is_not_numeric("a")

add1 <- function(x) x + 1
add2 <- compose(add1, add1)
add2(10)
