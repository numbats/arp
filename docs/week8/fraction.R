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
  structure(x, class = "fraction")
}

print.fraction <- function(x, ...) {
  cat(paste0(x$numerator, "/", x$denominator), sep = " ")
}
