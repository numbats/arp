library(rlang)
library(dplyr)

# Parsing code ------------------------------------------------------------------

# parse(text = "seq(1, 10, by = 0.5)")  # base R equivalent
parse_expr("seq(1, 10, by = 0.5)")

# Code is data -----------------------------------------------------------------

my_seq <- parse_expr("seq(1, 10, by = 0.5)")
my_seq
class(my_seq)
eval(my_seq)

# Building blocks: sym, expr, quo ----------------------------------------------

sym("pi") # a symbol (name)
expr(1 / pi) # an expression (unevaluated)
quo(1 / pi) # a quosure (expression + environment)

# Exercise: spot the difference
sym("2 * pi") # treats "2 * pi" as a single name, not an expression — error-prone
expr(2 * pi) # builds a call: `*`(2, pi); pi is resolved at eval time
quo(2 * pi) # same AST, but also records the current environment

# Capturing code ---------------------------------------------------------------

capture_expr <- function(x) {
  enexpr(x)
}
capture_expr(1 / pi)

# Exercise: f vs g
f <- function(x) x
g <- function(x) enexpr(x)

f(1 + 2) # evaluates 1 + 2, returns 3
g(1 + 2) # captures the expression `1 + 2` unevaluated

# Exercise: assert_positive
assert_positive <- function(x) {
  expr <- enexpr(x)
  result <- eval(expr)
  if (!is.numeric(result) || result <= 0 || is.na(result)) {
    stop(deparse(expr), " must be positive")
  }
  result
}
assert_positive(sqrt(4)) # returns 2
assert_positive(5-10) # error: "5 - 10 must be positive"
assert_positive(log(-1)) # error: "log(-1) must be positive"

# Unquoting (bang-bang !!) -----------------------------------------------------

# Without !!: x is treated as a symbol, not replaced by its captured expression
log_expr_broken <- function(x) {
  x <- enexpr(x)
  expr(log(x))
}
log_expr_broken(1 / pi)

# With !!: x is unquoted, so 1/pi is substituted in
log_expr <- function(x) {
  x <- enexpr(x)
  expr(log(!!x))
}
log_expr(1 / pi)

# Exercise: the cyl == cyl problem
cyl <- 4
mtcars |> filter(cyl == cyl) # compares mtcars$cyl to itself — keeps all rows

# Fix with !! to refer to the local variable
mtcars |> filter(cyl == !!cyl)

filter_col <- function(data, col, val) {
  data |> filter(col == val)
}

filter_col(mtcars, cyl, 4)

# filter_col using enquo + !!
filter_col <- function(data, col, val) {
  col <- enquo(col)
  data |> filter(!!col == val)
}
filter_col(mtcars, cyl, 4)

# Embracing inputs ({{ curly-curly }}) -----------------------------------------

# Shorthand for !!enquo(x)
filter_col <- function(data, col, val) {
  data |> filter({{ col }} == val)
}
filter_col(mtcars, cyl, 4)

var_summary <- function(data, var) {
  data |>
    summarise(n = n(), min = min({{var}}), max = max({{ var }}))
}
mtcars |>
  group_by(cyl) |>
  var_summary(mpg)

# Capturing multiple expressions -----------------------------------------------

print_conds <- function(...) {
  conds <- enquos(...)
  purrr::walk(conds, \(cond) cat(as_label(cond), "\n"))
}
print_conds(cyl == 4, wt < 2.5, am == 1)







# Tidy evaluation --------------------------------------------------------------

mtcars |> mutate(mpg / wt)

my_mutate <- function(.data, mutation) {
  mutation <- enquo(mutation)
  result <- eval_tidy(mutation, data = .data, env = caller_env())
  .data[[as_label(mutation)]] <- result
  .data
}
mtcars |> my_mutate(mpg / wt)

# Data masks -------------------------------------------------------------------

name <- c("Alice", "Bob", "Carol")
score <- c(82, 95, 71)
mask <- list(name = name, score = score)
eval_tidy(quo(score > 80), data = mask)

# Quosures capture the caller's environment, so threshold is found even though
# it's not in the mask
threshold <- 80
f <- function(cond) eval_tidy(enquo(cond), data = mask)
f(score > threshold)

# Exercise: airquality mask
mask <- as.list(head(airquality))
eval_tidy(quo(Temp > 70), data = mask)
# eval_tidy(quo(Temperature > 70), data = mask)  # error: object 'Temperature' not found

# Filtering with multiple conditions -------------------------------------------

my_filter <- function(.data, ...) {
  conds <- enquos(...)
  mask <- as.list(.data)
  keep <- purrr::map(conds, \(cond) eval_tidy(cond, data = mask))
  keep <- Reduce("&", keep)
  .data[keep, ]
}
my_filter(mtcars, cyl == 4, wt < 2.5)

# Exercise: add .op argument to combine conditions with & or |
my_filter <- function(.data, ..., .op = "all") {
  conds <- enquos(...)
  mask <- as.list(.data)
  keep <- purrr::map(conds, \(cond) eval_tidy(cond, data = mask))
  reducer <- switch(.op, "all" = "&", "any" = "|", stop("Invalid .op: ", .op))
  keep <- Reduce(reducer, keep)
  .data[keep, ]
}
my_filter(mtcars, cyl == 4, wt < 2.5)
my_filter(airquality, Temp > 90, Month == 8, .op = "any")
