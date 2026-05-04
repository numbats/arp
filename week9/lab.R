library(vctrs)

# S3 Recap ------------------------------------------------------------------

e <- structure(list(numerator = 2721, denominator = 1001), class = "fraction")

fraction <- function(numerator, denominator) {
  stopifnot(is.numeric(numerator), is.numeric(denominator))
  if (any(denominator == 0)) {
    stop("I won't let you divide by 0.")
  }
  structure(
    list(numerator = numerator, denominator = denominator),
    class = "fraction"
  )
}
print.fraction <- function(x, ...) {
  print(paste0(x$numerator, "/", x$denominator))
}

# vctrs concepts ------------------------------------------------------------

# vec_size() treats data frames as records, not lists
length(mtcars)
vctrs::vec_size(mtcars)

# list_of: elements must all be the same type
vctrs::as_list_of(list(80, 70, 75, 50), .ptype = numeric())

# Prototypes: size-0 vectors that carry type information
vctrs::vec_ptype(1:10)
vctrs::vec_ptype(rnorm(10))
vctrs::vec_ptype(factor(letters))

# base c() can't always use double-dispatch; use vec_c() instead
vctrs::vec_c(1, Sys.Date()) # error: no common type defined

# percent class -------------------------------------------------------------

percent <- function(x = numeric()) {
  vctrs::vec_assert(x, numeric())
  vctrs::new_vctr(x, class = "percent")
}
format.percent <- function(x, ...) {
  paste0(vctrs::vec_data(x), "%")
}

marks <- percent(c(80, 70, 75, 50))
marks
percent() # length-0 prototype
percent("80%") # error: input validation
vctrs::vec_ptype(marks)

# Common type: percent + double -> percent (both dispatch directions required)
vec_ptype2.percent.double <- function(x, y, ...) percent()
vec_ptype2.double.percent <- function(x, y, ...) percent()

# Cast: converting between percent and double
vec_cast.double.percent <- function(x, to, ...) vec_data(x) / 100
vec_cast.percent.double <- function(x, to, ...) percent(x * 100)

# c() ignores ptype2 when the class isn't first; vec_c() always uses double-dispatch
c(marks, 0.8)
c(0.8, marks) # class lost
vctrs::vec_c(0.8, marks) # correct
marks > 0.7

# Math: default restores the percent class after applying base math
vec_math.percent <- function(.fn, .x, ...) {
  vec_restore(vec_math_base(.fn, .x, ...), .x)
}
mean(marks)

# Arith: implement secondary dispatch manually
vec_arith.percent <- function(op, x, y, ...) {
  UseMethod("vec_arith.percent", y)
}
vec_arith.percent.default <- function(op, x, y, ...) {
  stop_incompatible_op(op, x, y)
}
vec_arith.percent.percent <- function(op, x, y, ...) {
  vec_restore(vec_arith_base(op, x, y), to = percent())
}
vec_arith.percent.numeric <- function(op, x, y, ...) {
  vec_restore(vec_arith_base(op, x, vec_cast(y, percent())), to = percent())
}
vec_arith.numeric.percent <- function(op, x, y, ...) {
  vec_restore(vec_arith_base(op, vec_cast(x, percent()), y), to = percent())
}

percent(40) + percent(20)
percent(40) + 0.3
0.3 + percent(40)

# currency class (rcrd example) ---------------------------------------------

wallet <- vctrs::new_rcrd(
  list(amt = c(10, 38), unit = c("AU$", "¥")),
  class = "currency"
)
format.currency <- function(x, ...) {
  paste0(vctrs::field(x, "unit"), vctrs::field(x, "amt"))
}
wallet

# fraction class ------------------------------------------------------------
# Exercise: rewrite fraction from week8/fraction.R using new_rcrd()

fraction <- function(numerator = integer(), denominator = integer()) {
  lst <- vctrs::vec_recycle_common(
    numerator = vctrs::vec_cast(numerator, integer()),
    denominator = vctrs::vec_cast(denominator, integer())
  )
  if (any(lst$denominator == 0L)) {
    stop("I won't let you divide by 0.")
  }
  vctrs::new_rcrd(lst, class = "fraction")
}
rm(print.fraction)
format.fraction <- function(x, ...) {
  paste0(vctrs::field(x, "numerator"), "/", vctrs::field(x, "denominator"))
}

fraction(1:3, 4:6)
fraction(1L, 1:5) # recycling
vctrs::vec_ptype(fraction())

# Exercise: write ptype2 methods so the common type of fraction and double is double
vec_ptype2.fraction.double <- function(x, y, ...) double()
vec_ptype2.double.fraction <- function(x, y, ...) double()
# Common type: fraction + integer -> fraction
vec_ptype2.fraction.integer <- function(x, y, ...) fraction()
vec_ptype2.integer.fraction <- function(x, y, ...) fraction()

# Exercise: write vec_cast methods so as.numeric() works on fractions
vec_cast.double.fraction <- function(x, to, ...) {
  vctrs::field(x, "numerator") / vctrs::field(x, "denominator")
}
vec_cast.fraction.integer <- function(x, to, ...) {
  fraction(x, 1L)
}

as.numeric(fraction(1:3, 4:6))
vctrs::vec_c(fraction(1L, 2L), 0.5)
fraction(3L, 7L) < 1L

# Exercise: add vec_math and vec_arith for fraction
# Hint: cast to double and use base math/arith; returning double is fine.
# Extension: retain the fraction class for +, -, *, /
vec_math.fraction <- function(.fn, .x, ...) {
  vec_math_base(.fn, vec_cast(.x, double()), ...)
}

vec_arith.fraction <- function(op, x, y, ...) {
  UseMethod("vec_arith.fraction", y)
}
vec_arith.fraction.default <- function(op, x, y, ...) {
  stop_incompatible_op(op, x, y)
}
vec_arith.fraction.fraction <- function(op, x, y, ...) {
  xn <- vctrs::field(x, "numerator")
  xd <- vctrs::field(x, "denominator")
  yn <- vctrs::field(y, "numerator")
  yd <- vctrs::field(y, "denominator")
  switch(
    op,
    "+" = fraction(xn * yd + yn * xd, xd * yd),
    "-" = fraction(xn * yd - yn * xd, xd * yd),
    "*" = fraction(xn * yn, xd * yd),
    "/" = fraction(xn * yd, xd * yn),
    stop_incompatible_op(op, x, y)
  )
}
vec_arith.fraction.double <- function(op, x, y, ...) {
  vec_arith_base(op, vec_cast(x, double()), y)
}
vec_arith.double.fraction <- function(op, x, y, ...) {
  vec_arith_base(op, x, vec_cast(y, double()))
}

mean(fraction(1:4, 5L))
sum(fraction(1:4, 5L))
fraction(3L, 7L) + fraction(9L, 2L)
fraction(3L, 7L) * fraction(9L, 2L)
fraction(3L, 7L) * 2
