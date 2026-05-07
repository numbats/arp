# Creating your own rcrd objects: fraction
fraction <- function(numerator = numeric(), denominator = numeric()) {
  # Validate inputs
  if(is.integer(numerator)) numerator <- as.numeric(numerator)
  if(is.integer(denominator)) denominator <- as.numeric(denominator)
  vctrs::vec_assert(numerator, numeric())
  vctrs::vec_assert(denominator, numeric())
  if (any(denominator == 0)) {
    stop("I won't let you divide by 0.")
  }
  # Create the data structure (list)
  x <- list(numerator = numerator, denominator = denominator)
  vctrs::new_rcrd(x, class = "fraction")
  #simplify_fraction(out)
}

format.fraction <- function(x, ...) {
  paste0(
    vctrs::field(x, "numerator"),
    "/",
    vctrs::field(x, "denominator")
  )
}
vec_ptype2.fraction.double <- function(x, y, ...) double()
vec_ptype2.double.fraction <- function(x, y, ...) double()
# Common type: fraction + integer -> fraction
vec_ptype2.fraction.integer <- function(x, y, ...) fraction()
vec_ptype2.integer.fraction <- function(x, y, ...) fraction()

vec_cast.double.fraction <- function(x, to, ...) {
  vctrs::field(x, "numerator") / vctrs::field(x, "denominator")
}
vec_cast.fraction.integer <- function(x, to, ...) {
  fraction(x, 1L)
}

vec_math.fraction <- function(.fn, .x, ...) {
  vec_math_base(.fn, vec_cast(.x, double()), ...)
}

vec_arith.fraction <- function(op, x, y, ...) {
  UseMethod("vec_arith.fraction", y)
}
vec_arith.fraction.default <- function(op, x, y, ...) {
  stop_incompatible_op(op, x, y)
}
vec_arith.fraction.numeric <- function(op, x, y, ...) {
  xd <- vctrs::vec_cast(x, double())
  vec_arith_base(op, xd, y)
}
vec_arith.numeric.fraction <- function(op, x, y, ...) {
  yd <- vctrs::vec_cast(y, double())
  vctrs::vec_arith_base(op, x, yd)
}
# vec_arith.fraction.fraction <- function(op, x, y, ...) {
#   xd <- vctrs::vec_cast(x, double())
#   yd <- vctrs::vec_cast(y, double())
#   vec_arith_base(op, xd, yd)
# }

vec_arith.fraction.fraction <- function(op, x, y, ...) {
  xn <- vctrs::field(x, "numerator")
  xd <- vctrs::field(x, "denominator")
  yn <- vctrs::field(y, "numerator")
  yd <- vctrs::field(y, "denominator")
  out <- switch(
    op,
    "+" = fraction(xn * yd + yn * xd, xd * yd),
    "-" = fraction(xn * yd - yn * xd, xd * yd),
    "*" = fraction(xn * yn, xd * yd),
    "/" = fraction(xn * yd, xd * yn),
    stop_incompatible_op(op, x, y)
  )
  simplify_fraction(out)
}

simplify_fraction <- function(x) {
  xn <- vctrs::field(x, "numerator")
  xd <- vctrs::field(x, "denominator")
  gcd <- mapply(DescTools::GCD, xn, xd)
  xn <- xn / gcd
  xd <- xd / gcd
  fraction(xn, xd)
}
