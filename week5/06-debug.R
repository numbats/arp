# Exercise: Recursive statistics

collect_stats <- function(lst, results = list()) {
  for (item in lst) {
    if (is.list(item)) {
      collect_stats(item, results) # recurse into sub-lists
    } else {
      results[[length(results) + 1]] <- c(mean = mean(item), n = length(item))
    }
  }
  results
}

data <- list(
  list(c(1, 2, 3), c(4, 5, 6)),
  list(c(7, 8, 9))
)
result <- collect_stats(data)
length(result) # returns 0, should be 3

# There is no error message — the function simply returns an empty list.
# Use debug() to find the problem. Explain why the accumulated results are lost on the way back up, and fix the function.
