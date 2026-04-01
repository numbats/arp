reverse <- function(x, ...) {
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


fraction <- function(numerator, denominator) {
  if (!is.numeric(numerator)) {
    stop("numerator must be numeric.")
  }
  if (!is.numeric(denominator)) {
    stop("denominator must be numeric.")
  }
  if(any(denominator == 0)) {
    stop("denominator cannot be zero.")
  }
  lst <- vctrs::vec_recycle_common(
    numerator = numerator,
    denominator = denominator
  )
  structure(lst, class = "fraction")
}

print.fraction <- function(x, ...) {
  cat(paste0(x$numerator, "/", x$denominator, collapse = " "), "\n")
}

fraction(1, sample(100, 10))

reverse.fraction <- function(x, ...) {
  fraction(x$denominator, x$numerator)
}

fraction(1, 1:10)
reverse(fraction(1, 1:10))

as.double.fraction <- function(x, ...) {
  x$numerator / x$denominator
}

as.numeric(fraction(1,1:10))
