library(tibble)
class(tibble())

square <- function(x) {
  if(!is.numeric(x)) {
    stop("`x` needs to be numeric")
  }
  return(x^2)
}

square()
formals(square) <- pairlist(x = numeric())
square()
environment(square) <- emptyenv()
square
square()

MAE <- function(e, ...) mean(abs(e), ...)
RMSE <- function(e, ...) sqrt(mean(e^2, ...))

MAE(rnorm(100))
RMSE(rnorm(100))
accuracy(rnorm(100), MAE)

accuracy <- function(e, measure, ...) {
  measure(e, ...)
}
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

colorRamp(c("red", "green"))(0.312381247)

power_factory <- function(exp) {
  # R is lazy and won't look at exp unless we ask it to
  z <- 10
  force(exp)
  # Return a function, which finds exp from this environment
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

breakpoints <- function(x, n.breaks) {
  seq(min(x), max(x), length.out = n.breaks)
}

breakpoints(mtcars$mpg, 10)

make_breakpoints <- function(n.breaks) {
  force(n.breaks)
  
  # return a function!
  function (x) {
    seq(min(x), max(x), length.out = n.breaks)
  }
}

make_breakpoints(5)(mtcars$mpg)

make_breakpoints_x <- function(x) {
  force(x)
  
  minx <- min(x)
  maxx <- max(x)
  rm(x)
  
  function (n.breaks) {
    seq(minx, maxx, length.out = n.breaks)
  }
}

mpg_breakpoints <- make_breakpoints_x(mtcars$mpg)
ls(envir = environment(mpg_breakpoints))
environment(mpg_breakpoints)$x
mpg_breakpoints(10)
mpg_breakpoints(5)

library(purrr)
map

split(mtcars$mpg, mtcars$cyl) |> 
  map(mean)

mpg_by_cyl <- split(mtcars$mpg, mtcars$cyl)
map(mpg_by_cyl, mean)
map_vec(mpg_by_cyl, mean)

mtcars_by_cyl <- split(mtcars, mtcars$cyl)
mtcars_by_cyl

lm(mpg ~ disp + hp + drat + wt, mtcars[mtcars$cyl == 4,])

map(mtcars_by_cyl, lm, mpg ~ disp + hp + drat + wt)
lm(mtcars[mtcars$cyl == 4,], mpg ~ disp + hp + drat + wt)

map(mtcars_by_cyl, ~ lm(mpg ~ disp + hp + drat + wt, data = .))

purrr::as_mapper(~ lm(mpg ~ disp + hp + drat + wt, data = .))

\(.) lm(mpg ~ disp + hp + drat + wt, data = .)

function(.) {
  lm(mpg ~ disp + hp + drat + wt, data = .)
}

mpg_by_cyl <- split(mtcars$mpg, mtcars$cyl)
map(mpg_by_cyl, mean, na.rm = TRUE)
