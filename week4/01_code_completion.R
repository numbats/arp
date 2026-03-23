# Week 4: Code Completion Demo

library(ggplot2)
library(dplyr)

# ── Example 1: Complete a function from its name ──────────────────────────────

# ── Example 2: Comment-driven completion ──────────────────────────────────────
# Calculate the mean of each numeric column in mtcars

# ── Example 3: Partial function body ─────────────────────────────────────────
# Copilot completes function bodies based on the name and first line.

# Function that returns the geometric mean of a numeric vector
geometric_mean <- function(x) {}

# ── Example 4: Continue a pattern ────────────────────────────────────────────
# Copilot recognises repetitive patterns and suggests the next line.

rename_map <- c(
  mpg = "Miles per gallon",
  cyl = "Cylinders",
  disp = "Displacement",
  # keep typing...
)

# ── Example 5: ggplot2 plot ───────────────────────────────────────────────────
# Type a comment describing the plot you want, then let Copilot write it.

# Scatter plot of horsepower vs mpg, coloured by number of cylinders
