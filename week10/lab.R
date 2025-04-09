library(rlang)
parse_expr("seq(1,10,       by = 0.5)")
parse_expr("data |> mutate()")
parse_expr("data %>% mutate()")

myseq <- parse_expr("seq(1,10,       by = 0.5)")
class(myseq)
new_function(list(), myseq)
eval(myseq)

mycalc <- parse_expr("5 + 3 * 7")

as.list(mycalc)

5 + (3 * 7)

as.list(mycalc[[3]])

as.list(mycalc)
mycalc[[2]] <- 10
mycalc

parse_expr("`+`(5, 3*7)")
parse_expr("`+`(5, `*`(3,7))")

mycalc
lobstr::ast(mycalc)
lobstr::ast(5 + 3 * 7)
as.list(mycalc)

lobstr::ast(
  mtcars |>
    group_by(cyl) |>
    filter(mpg > 0.2) |>
    mutate(mpg/wt) |>
    ggplot()
)

parse_expr(
"mtcars |>
  group_by(cyl) |>
  filter(mpg > 0.2) |>
  mutate(mpg/wt) |>
  ggplot()"
)

lobstr::ast((-2)^2)
(-2)^2

lobstr::ast(!countries %in% c("Australia", "China"))

as.list(myseq)
call2("seq", 1L, 10, by = 0.5)
parse_expr(sprintf("seq(%i,%i, by = %f)", 1L, 10, 0.5))

x / y
x <- expr(3 + 6)
y <- expr(1 + 2)

call2("/", x, y)
parse_expr(sprintf("%s / %s", "3 + 6", "1 + 2"))

with(
  list(
    `+` = base::`-`,
    `-` = base::`+`
  ),
  3 + 8
)

library(rlang)
pkgs <- "rlang"
library(pkgs)

purrr::map(
  c("ggplot2", "dplyr", "tidyr"),
  library,
  character.only = TRUE
)

purrr::map(
  c("ggplot2", "dplyr", "tidyr"),
  call2, .fn = "library"
) |>
  purrr::map(eval)

library("ggplot2")

mtcars |> select(cyl)
cyl

readr::read_csv("data/study.csv")

ggplot(mtcars, aes(mpg, wt)) +
  geom_point()

ggplot2:::`+.gg`
mpg
wt

mtcars |>
  mutate(wt/hp)

mtcars |>
  left_join(mpg, by = c("model" = "car"))

join_by

1 + 1

base::`+`

eval(sym("pi"))
sym("pi")
sym("mpg")
expr(1/pi)
lobstr::ast(1/pi)
quo(1/pi)
eval_tidy(quo(1/pi))

function(expr) {
  expr <- enexpr(expr)
}

call2(sym("mutate"), sym("mtcars"),  expr(wt/sym("hp")))

"mutate"()

sym("2 * pi")

mtcars |>
  mutate(2 * mpg) |>
  select("2 * mpg")

expr(2 * pi)
lobstr::ast(2*pi)

quo(2 * pi)

capture_expr <- function(x) {
  x <- enquo(x)
  pi <- 2.29
  eval_tidy(x)
}

capture_expr(2*pi)
# expr(2*pi)

myseq
lobstr::ast(myseq)
lobstr::ast(!!myseq)

expr(!!pi)
expr(1/pi)
expr(1/!!pi)

wt <- rnorm(32)
mtcars |>
  summarise(weighted.mean(mpg, !!wt))

cyl <- 4
mtcars |>
  filter(cyl == !!cyl)

var_summary(mtcars, cyl)

syms(c("a", "b"))
exprs(a+b, a-b)
quos(a+b, a-b)

var_summaries <- function(data, ...) {
  vars <- enquos(...)
  .min <- purrr::map(vars, ~ expr(min(!!.)))
  names(.min) <- c("a", "b")
  .max <- purrr::map(vars, ~ expr(max(!!.)))
  data |>
    summarise(n = n(), !!!.min, !!!.max)
    # summarise(n = n(), a = min(mpg), b = min(wt), !!!.max)
}
mtcars |>
  group_by(cyl) |>
  var_summaries(mpg, wt)


cyl <- 4
mtcars |>
  filter(cyl == !!cyl)
mtcars |>
  filter(.data$pi == .env$cyl)

mtcars |>
  filter(.data$pi == .env$cyl)

pi
