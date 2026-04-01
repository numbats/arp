library(dplyr)
library(vctrs)

# vctrs percent class

percent <- function(x = numeric()) {
  vctrs::vec_assert(x, numeric())
  vctrs::new_vctr(x, class = "percent")
}
format.percent <- function(x, ...) {
  paste0(vctrs::vec_data(x), "%")
}
percent(letters)
attendance <- percent(c(80, 70, 75, 50))
attendance
tibble(attendance)
percent()

# vctrs fraction class

fraction <- function(numerator = integer(), denominator = integer()) {
  lst <- vctrs::vec_recycle_common(
    numerator = vctrs::vec_cast(numerator, integer()),
    denominator = vctrs::vec_cast(denominator, integer())
  )
  vctrs::new_rcrd(lst, class = "fraction")
}
format.fraction <- function(x, ...) {
  paste0(vctrs::field(x, "numerator"), "/", vctrs::field(x, "denominator"))
}
vec_cast.double.fraction <- function(x, to, ...) {
  vctrs::field(x, "numerator") / vctrs::field(x, "denominator")
}
vec_cast.fraction.integer <- function(x, to, ...) {
  fraction(x, 1)
}
vec_ptype2.fraction.double <- vec_ptype2.double.fraction <- function(x, y, ...) {
  numeric()
}
vec_ptype2.fraction.integer <- vec_ptype2.integer.fraction <- function(x, y, ...) {
  fraction()
}



fraction(1, 1:10) > 0.5

fraction(1:3, 4:6) |> as.numeric()
fraction(-1:4, 0L) |> as.numeric()
vec_c(fraction(1:3, 4:6), 0)

fraction(3, 7) < 1L
