library(dplyr)

# Generic functions and methods
trees
plot(trees)

m <- lm(log(Volume) ~ log(Girth) + log(Height), data = trees)
plot(m)

.leap.seconds
plot(.leap.seconds)

nhtemp
plot(nhtemp)

class(.leap.seconds)
unclass(.leap.seconds)
str(.leap.seconds)
class(nhtemp)
unclass(nhtemp)
str(nhtemp)
class(trees)
unclass(trees)
str(trees)
class(m)
unclass(m)
str(m)

print
methods("print")
stats:::print.acf
plot
methods("plot")
plot.ts
stats:::plot.lm


# S3: Classes. Make our own grade class with print, plot and summary methods
make_grade <- function(x) {
  stopifnot(is.numeric(x))
  stopifnot(all(x >= 0 & x <= 100))
  grades <- letter_grades(x)
  structure(list(x = x, grades = grades), class = "grade")
}
letter_grades <- function(x) {
  cut(
    x,
   breaks = c(-Inf, 50, 60, 70, 80, Inf),
   labels = c("N", "P", "C", "D", "HD"),
   right = FALSE
  )
}
print.grade <- function(x, ...) {
  output <- paste(x$x, "[", as.character(x$grades), "]", sep = "")
  cat(output)
  invisible(x)
}
x
plot.grade <- function(x, ...) {
  x$grades |>
    table() |>
    barplot(main = "Grade Distribution", xlab = "Letter Grade", ylab = "Frequency")
}
summary.grade <- function(x, ...) {
  x$grades |>
  table()
}

`[.grade` <- function(x, i, ...) {
  make_grade(x$x[i])
}

x <- make_grade(sample(50:100, 10))
class(x)
typeof(x)
x
x[2:3]
plot(x)
summary(x)









# Reversing strings and numbers with S3 methods
reverse <- function(x) {
  UseMethod("reverse")
}

# Writing S3 methods for reverse
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

# S3: .default methods
reverse.default <- function(x) {
  stringi::stri_reverse(as.character(x))
}

reverse(Sys.Date())
reverse(mtcars)

# Creating your own S3 objects: fraction
fraction <- function(numerator, denominator) {
  # Validate inputs
  stopifnot(is.numeric(numerator) && is.numeric(denominator))
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
print.fraction <- function(x, ...) {
  cat(paste0(x$numerator, "/", x$denominator), sep = " ")
}

simplify_fraction <- function(x) {
  gcd <- DescTools::GCD(x$numerator, x$denominator)
  x$numerator <- x$numerator / gcd
  x$denominator <- x$denominator / gcd
  x
}

fraction(2, 4)
fraction(sample(1:100, 10), sample(1:100, 10))


reverse
reverse.fraction <- function(x) {
  fraction(numerator = x$denominator, denominator = x$numerator)
}
reverse(
  fraction(2, 7)
)
reverse(fraction(1, 7))


as.double.fraction <- function(x, ...) {
  x$numerator / x$denominator
}
as.numeric(fraction(2, 7))
as.double(fraction(2, 7))

# S3: Inheritance / NextMethod
reverse.double <- function(x) {
  as.double(NextMethod())
}

# Extra: custom fraction addition operator
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
fraction(2, 8) %add% fraction(1, 4)

fraction(2, 7) %add% 3
3 %add% fraction(2, 7)
  