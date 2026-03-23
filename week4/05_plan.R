# Week 4: Chat Agent – Plan
# The Plan agent creates detailed step-by-step plans before executing anything.
# Switch to the Plan agent in the Positron Assistant panel, then paste the
# prompts below into the chat.

library(dplyr)
library(ggplot2)

# ── Example script: a data processing pipeline ───────────────────────────────
# This is the script we will ask the Plan agent to reason about.

process_sales <- function(path) {
  df <- read.csv(path)

  # Basic cleaning
  df <- df[!is.na(df$revenue), ]
  df <- df[df$revenue > 0, ]

  # Feature engineering
  df$profit_margin <- (df$revenue - df$cost) / df$revenue

  # Aggregation
  summary_df <- df |>
    group_by(region, product) |>
    summarise(
      total_revenue = sum(revenue),
      avg_margin    = mean(profit_margin, na.rm = TRUE),
      n_sales       = n(),
      .groups       = "drop"
    )

  summary_df
}


# ── Example 1: Turn this script into an R package ────────────────────────────
# Paste into the Plan agent chat:
#
# "Outline the steps needed to turn week4/05_plan.R into an R package,
#  including documentation, DESCRIPTION file, and exported functions."


# ── Example 2: Plan adding tests ──────────────────────────────────────────────
# Paste into the Plan agent chat:
#
# "Plan how to add testthat unit tests for the process_sales() function
#  defined in week4/05_plan.R. Include edge cases."


# ── Example 3: Optimise a pipeline ───────────────────────────────────────────
# Paste into the Plan agent chat:
#
# "Create a step-by-step plan to optimise the process_sales() data processing
#  pipeline in week4/05_plan.R for performance and readability."
