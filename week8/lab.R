library(dplyr)

dplyr:::mutate.data.frame
dplyr:::dplyr_col_modify.data.frame

.leap.seconds


plot
mutate

class(nhtemp)
plot.ts


x <- structure(83, class = "grade")
class(x)

# tools:::CRAN_package_reverse_dependencies_and_views("fable")

x

# print.default

y <- print(1:10)
y

print.grade <- function(x, ...) {
  letter <- if (x < 50) {
    "N"
  } else if (x < 60) {
    "P"
  } else if (x < 70) {
    "C"
  } else if (x < 80) {
    "D"
  } else {
    "HD"
  }
  cat(x, " [", letter, "]", sep = "")
  invisible(x)
}
unclass(x)
class(x) <- "students"
x
class(x) <- "grade"

x

today <- Sys.Date()
today
class(today)
class(today) <- "grade"
today

plot

reverse <- function(x) {
  UseMethod("reverse")
}

reverse.character <- function(x, ...) {
  stringi::stri_reverse(x)
}

reverse.integer <- function(x, ...) {
  as.integer(reverse(as.character(x)))
}
reverse.double <- function(x, ...) {
  as.double(reverse(as.character(x)))
}

reverse(9197)

reverse("desserts")

reverse(1.9599)

reverse(2345678L)

reverse.double <- function(x) {
  as.double(NextMethod())
}

reverse.default <- function(x) {
  stringi::stri_reverse(as.character(x))
}
class(5678.213)

reverse(5678.213)

reverse(Sys.Date())
reverse(palmerpenguins::penguins)


m <- lm(log(Volume) ~ log(Girth) + log(Height), data = trees)
str(m)


fraction <- function(numerator, denominator) {
  # Validate inputs
  stopifnot(is.numeric(numerator))
  stopifnot(is.numeric(denominator))
  stopifnot(length(numerator) == length(denominator))
  if (any(denominator == 0)) {
    stop("I won't let you divide by 0.")
  }

  # Create the data structure (list)
  x <- list(numerator = numerator, denominator = denominator)

  # Return a classed S3 object
  structure(x, class = "fraction") |>
    simplify_fraction()
}
simplify_fraction <- function(x) {
  gcd <- DescTools::GCD(x$numerator, x$denominator)
  x$numerator <- x$numerator / gcd
  x$denominator <- x$denominator / gcd
  x
}

fraction(2, 4)


fraction(sample(1:100, 10), sample(1:100, 10))

print
print.fraction <- function(x, ...) {
  cat(paste0(x$numerator, "/", x$denominator), sep = "\n")
}
fraction(sample(1:100, 5), sample(1:100, 5))

reverse
reverse.fraction <- function(x) {
  # tmp <- x$numerator
  # x$numerator <- x$denominator
  # x$denominator <- tmp

  fraction(numerator = x$denominator, denominator = x$numerator)
}
reverse(
  fraction(2, 7)
)
reverse(fraction(1, 7))

identical(as.numeric, as.double)

as.double.fraction <- function(x, ...) {
  x$numerator / x$denominator
}
as.numeric(fraction(2, 7))
as.double(fraction(2, 7))

fraction(2, 7) + 3

`%add%` <- function(e1, e2) {
  # as.numeric(e1) + as.numeric(e2)
  if (is.numeric(e1)) {
    e1 <- fraction(numerator = e1, denominator = 1)
  }
  if (is.numeric(e2)) {
    e2 <- fraction(numerator = e2, denominator = 1)
  }
  common_denominator <- e1$denominator * e2$denominator
  x <- fraction(
    numerator = e1$numerator * e2$denominator + e2$numerator * e1$denominator,
    denominator = common_denominator
  )
  simplify_fraction(x)
}
fraction(2, 7) %add% fraction(3, 5)
fraction(1, 8) %add% fraction(1, 4)

fraction(2, 7) %add% 3
3 %add% fraction(2, 7)
