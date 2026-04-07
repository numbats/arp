# Exercise: Using browser() to find a silent bug

# Normalise a vector of scores to the 0–100 range
normalise <- function(x) {
  lo <- min(x)
  hi <- max(x)
  (x - lo) / (hi + lo) * 100
}
scores <- c(55, 72, 28, 43, 91, 67)
normalise(scores) # values should lie between 0 and 100

#  The function seems to return incorrect values. I expect min to map to 0 and max to map to 100.
# Insert browser() and step through the calculation to locate the bug.
