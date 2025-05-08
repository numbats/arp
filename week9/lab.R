sum
mean
base:::mean.default

rnorm(14, mean = 1:10)
rnorm(14, mean = c(1:10, 1:4))

# pillar

library(fpp3)
fabletools:::pillar_shaft.agg_vec

tourism |>
  aggregate_key(State, Trips = sum(Trips))

library(distributional)
generate(dist_normal(1:10), 14)

library(ggdist)
tibble(mu = 1:10, dist = dist_normal(mu)) |>
  mutate(generate(dist, 14)) |>
  ggplot(aes(xdist = dist, y = y)) +
  stat_slab()

tourism |>
  summarise(Trips = sum(Trips)) |>
  model(ETS(Trips)) |>
  forecast() |>
  ggplot(aes(xdist = Trips, y = Quarter)) +
  stat_slab()


attendance <- vctrs::new_vctr(c(80, 70, 75, 50), class = "percent")

tibble(attendance)


percent <- function(x = numeric()) {
  vctrs::vec_assert(x, numeric())
  vctrs::new_vctr(x, class = "percent")
}

percent("80%")


numeric(10L)
character(1L)



library(vctrs)
vec_init(percent(), 10)

percent(c(80, 40, 88, 29))

paste0(
  vec_data(percent(c(80, 40, 88, 29))),
  "%"
)

format.percent <- function(x, ...) {
  paste0(vctrs::vec_data(x), "%")
}
tibble(attendance)


attendance[2]
attendance[1:3]
head(attendance, 2)

tourism[2]
tourism[2,]

typeof(tourism)
unclass(tourism)


list(letters, LETTERS)[2]


vec_slice(tourism, 2)


wallet <- vctrs::new_rcrd(
  data.frame(amt = c(10, 38), unit = c("AU$", "¥")), class = "currency"
)
format.currency <- function(x, ...) {
  paste0(vctrs::field(x, "unit"), vctrs::field(x, "amt"))
}
tibble(wallet)

vec_data(wallet)$unit
field(wallet, "unit")

norm_sample <- rnorm(10)
c(norm_sample, 3)

your_wallet <- vctrs::new_rcrd(
  data.frame(amt = c(3, 1), unit = c("AU$", "¥")), class = "currency"
)
c(wallet, your_wallet)


bind_rows(
  tibble(money = wallet),
  tibble(money = your_wallet),
)

vec_cast(1L, double())
vec_cast("one", double())
vec_cast("1", double())

# Create a `fraction` record class (`new_rcrd()`)
# 1. Use new_rcrd()
# 2. Validate inputs with vec_assert()
# 3. Write format method
# 4. Experiment with tibble/tidyverse

fraction <- function(numerator = numeric(), denominator = numeric()) {
  # Validate inputs
  # vec_assert(numerator, numeric())
  numerator <- vec_cast(numerator, numeric())
  # vec_assert(denominator, numeric())
  denominator <- vec_cast(denominator, numeric())

  if (any(denominator == 0)) stop("I won't let you divide by 0.")

  # Create the data structure (list)
  x <- vec_recycle_common(
    numerator = numerator, denominator = denominator
  )

  # Return a classed S3 object
  vctrs::new_rcrd(x, class = "fraction")
}
fraction(rnorm(10), rnorm(10))


format.fraction <- function(x, ...) {
  paste(field(x, "numerator"), "/", field(x, "denominator"))
}

tibble(fraction(1:10, 4:13))


tibble(fraction(1:10, 4))


vec_recycle(1:10, 4)
vec_recycle(1:10, 100)
vec_recycle(3, 100)

vec_recycle_common(letters, 3, 1:10)

vec_cast(attendance, fraction())

# prototypes
letters[0]
vec_ptype(letters)
attendance[0]
vec_ptype(attendance)

c(1, Sys.Date())
c(Sys.Date(), 1)


vctrs::vec_c(1, Sys.Date())
vctrs::vec_c(Sys.Date(), 1)


ratios <- fraction(1:10, 4)
tibble(ratios)

vec_c(ratios, 1.3)
#' @export
vec_ptype2.fraction.double <- function(x, y, ...) {
  double() # Prototype since this produces size-0
}
#' @export
vec_ptype2.double.fraction <- function(x, y, ...) {
  double() # Prototype since this produces size-0
}

vec_c(ratios, 1.3)
vec_c(1.3, ratios)


vctrs::vec_ptype2(attendance, 0.8)

vec_cast.double.fraction <- function(x, to, ...) {
  field(x, "numerator") / field(x, "denominator")
}
vec_cast.fraction.double <- function(x, to, ...) {
  fraction(x, 1)
}
vec_c(ratios, 1.3)
vec_c(1.3, ratios)

vec_cast(1.3, fraction())

as.fraction <- function(x) {
  vec_cast(x, fraction())
}

as.fraction(1.3)


fraction(3, 7) < 1L

#' @export
vec_ptype2.fraction.integer <- function(x, y, ...) {
  fraction() # Prototype since this produces size-0
}
#' @export
vec_ptype2.integer.fraction <- function(x, y, ...) {
  fraction() # Prototype since this produces size-0
}
vec_cast.fraction.integer <- function(x, to, ...) {
  fraction(x, 1)
}

vec_c(fraction(3, 7), 2L)


fraction(3/7) + fraction(9/2)
2L + fraction(9/2)

vec_arith.fraction <- function(op, x, y, ...) {
  UseMethod("vec_arith.fraction", y)
}
vec_arith.fraction.default <- function(op, x, y, ...) {
  stop_incompatible_op(op, x, y)
}
fraction(3,7) + fraction(9,2)

vec_arith.fraction.fraction <- function(op, x, y, ...) {
  xd <- field(x, "denominator")
  yd <- field(y, "denominator")
  xn <- field(x, "numerator")
  yn <- field(y, "numerator")
  if(op == "+") {

    fraction(
      numerator = xn * yd + yn * xd,
      denominator = xd * yd
    )

  } else if (op == "*") {
    fraction(
      numerator = xn * yn,
      denominator = xd * yd
    )
  }
  else {
    stop("Can't do that operation yet")
  }
}

fraction(3,7) + fraction(9,2)
fraction(3,7) * fraction(9,2)

(dist_normal(3, 2) + 3) * 2
