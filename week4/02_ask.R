# Week 4: Chat Agent – Ask
# Use the Ask agent to get answers and code suggestions WITHOUT automatic
# execution. Open the Positron Assistant panel (Ctrl+Shift+P → "Positron
# Assistant") and switch to the Ask agent before running these demos.

library(ggplot2)

# ── Demo data ─────────────────────────────────────────────────────────────────
my_data <- data.frame(
  value = c(3.1, 4.7, 2.9, 5.5, 6.1, 3.8, 4.2, 7.0, 5.1, 4.9),
  group = rep(c("A", "B"), each = 5),
  measure = c(10, 12, 9, 15, 14, 11, 13, 16, 12, 10)
)

# ── Example 1: Plotting question ──────────────────────────────────────────────
# Ask: "How do I plot a histogram of the `value` variable in my dataset
#       `my_data`?"
# Expected: Copilot suggests ggplot2 code using geom_histogram().

# Paste / run the suggested code here:

# ── Example 2: Syntax error explanation ───────────────────────────────────────
# This function has a bug. Highlight it and ask:
# "Why is this function returning the wrong result?"

my_sum <- function(x) {
  total <- 0
  for (i in length(x)) {
    # BUG: should be seq_along(x)
    total <- total + x[i]
  }
  return(total)
}
my_sum(1:5) # Returns 5 instead of 15


# ── Example 3: Explain a function ─────────────────────────────────────────────
# "Review this code and suggest improvements for readability, correctness,
#  and R best practices."

compute_stats <- function(data, col) {
  x = data[[col]]
  n = length(x)
  m = 0
  for (i in 1:n) {
    m = m + x[i]
  }
  m = m / n
  v = 0
  for (i in 1:n) {
    v = v + (x[i] - m)^2
  }
  v = v / (n - 1)
  s = sqrt(v)
  list(mean = m, sd = s, n = n)
}

compute_stats(mtcars, "mpg")
