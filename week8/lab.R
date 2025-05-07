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

print.grade <- function(x, ...){
  letter <- if (x < 50) "N"
  else if (x < 60) "P"
  else if (x < 70) "C"
  else if (x < 80) "D"
  else "HD"
  cat(x," [", letter, "]", sep = "")
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

# reverse.character <- function(x) {
#   stringi::stri_reverse(x)
#   # paste(rev(strsplit(x, "")[[1]]), collapse = "")
# }

reverse("abcde")

reverse.integer <- function(x) {
  # as.integer(NextMethod())
  # num_numbers <- floor(log10(x)) + 1
  # 10^num_numbers - x
  # sign_x <- sign(x)
  # x <- abs(x)
  # reversed <- 0
  # while(x > 0) {
  #   digits <- x %% 10
  #   reversed <- reversed * 10 + digits
  #   x <- x %/% 10
  # }
  # as.integer(sign_x * reversed)

  ndigits <- floor(log10(x))
  digits <- seq(floor(log10(x)))
  x*(10^ndigits) - (99*sum(floor(x*10^-digits)*(10^(ndigits-digits))))
}

revint_math <- function(x) {
  ndigits <- floor(log10(x))
  digits <- seq(floor(log10(x)))
  x*(10^ndigits) - (99*sum(floor(x*10^-digits)*(10^(ndigits-digits))))
}
revint_base10 <- function(x) {
  sign_x <- sign(x)
  x <- abs(x)
  reversed <- 0
  while(x > 0) {
    digits <- x %% 10
    reversed <- reversed * 10 + digits
    x <- x %/% 10
  }
  sign_x * reversed
}
revint_stri <- function(x) {
  stringi::stri_reverse(as.character(x))
}

options(scipen = 102938)
bench::mark(
  revint_base10(7653187221304L),
  revint_math(7653187221304L),
  revint_stri(7653187221304L),
  max_iterations = 100000
)

reverse(2345678L)

reverse.double <- function(x) {
  as.double(NextMethod())
  # as.double(reverse(as.character(x)))
}

reverse.default <- function(x) {
  stringi::stri_reverse(as.character(x))
}
class(5678.213)

reverse(5678.213)

reverse(Sys.Date())
reverse(palmerpenguins::penguins)


tsibble:::summarise.grouped_ts



m <- lm(log(Volume)~log(Girth)+log(Height),data=trees)
str(m)



tibble::tibble(
  x = 1:10,
  y = log(x)
)

tibble::new_tibble(
  list(
    x = 1:10,
    y = log(x)
  )
)


fraction <- function(numerator, denominator) {
  # Validate inputs
  stopifnot(is.numeric(numerator))
  stopifnot(is.numeric(denominator))
  if (any(denominator == 0)) stop("I won't let you divide by 0.")

  # Create the data structure (list)
  x <- list(numerator = numerator, denominator = denominator)

  # Return a classed S3 object
  structure(x, class = "fraction")
}

fraction(sample(1:100, 10), sample(1:100, 10))

print
print.fraction <- function(x, ...) {
  cat(paste(x$numerator, "/", x$denominator), sep = "\n")
}
fraction(sample(1:100, 10), sample(1:100, 5))

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

identical(as.numeric, as.double)

as.double.fraction <- function(x, ...) {
  x$numerator / x$denominator
}
as.numeric(fraction(2, 7))
as.double(fraction(2, 7))


fraction(2,7) + 3

`%add%` <- function(e1, e2) {
  # as.numeric(e1) + as.numeric(e2)
  fraction(
  numerator = fraction$numerator + numeric*fraction$denominator,
  denominator = fraction$denominator
  )
}
fraction(2,7) %add% 3
3 %add% fraction(2,7)

fraction(2,7) %add% fraction(2,7)


S7::class_character

# S3
best_grade <- function(x = fraction(), y = numeric(), ...) {
  UseMethod("best_grade", y)
}

# S7
best_grade <- new_generic("best_grade", dispatch_args = c("y"))
