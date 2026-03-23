# Week 4: Chat Agent – Edit
# The Edit agent suggests code changes for you to review and apply.
# Open the Positron Assistant panel and switch to the Edit agent.
# Select code, then describe the change you want in the chat.

library(dplyr)
library(ggplot2)

# ── Example 1: Refactor for efficiency ────────────────────────────────────────
# Select this function, then ask:
# "Refactor this function to be more efficient."

slow_summary <- function(df) {
  result <- data.frame()
  for (col in names(df)) {
    if (is.numeric(df[[col]])) {
      row <- data.frame(
        column  = col,
        mean    = mean(df[[col]], na.rm = TRUE),
        sd      = sd(df[[col]], na.rm = TRUE),
        missing = sum(is.na(df[[col]]))
      )
      result <- rbind(result, row)
    }
  }
  return(result)
}

slow_summary(mtcars)


# ── Example 2: Add error handling ────────────────────────────────────────────
# Select this function, then ask:
# "Add error handling to this code block."

divide <- function(x, y) {
  x / y
}

divide(10, 2)
divide(10, 0)
divide("a", 2)


# ── Example 3: Update to modern dplyr ────────────────────────────────────────
# Select the pipeline below, then ask:
# "Update this script to use modern dplyr style (no group_by, use .by instead,
#  use across() for column operations)."

old_style <- mtcars |>
  group_by(cyl, am) |>
  summarise(
    mean_mpg  = mean(mpg),
    mean_hp   = mean(hp),
    mean_wt   = mean(wt),
    .groups   = "drop"
  )

old_style
