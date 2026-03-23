# Week 4: Chat Agent – Agent
# The Agent autonomously executes work including running code and modifying
# files. Switch to the Agent in the Positron Assistant panel.
# These demos are prompts to paste into the agent chat — not code to run
# directly.

library(ggplot2)
library(dplyr)

# ── Demo dataset (used across examples) ──────────────────────────────────────
# The agent can load and inspect this file directly.
# week4/demo_data.csv is created below for use in Example 1.

write.csv(
  data.frame(
    id      = 1:50,
    age     = c(sample(18:80, 45, replace = TRUE), NA, NA, NA, NA, NA),
    income  = c(abs(rnorm(48, 50000, 15000)), -999, NA),
    group   = sample(c("A", "B", "C"), 50, replace = TRUE)
  ),
  file = here::here("week4/demo_data.csv"),
  row.names = FALSE
)


# ── Example 1: Data cleaning and summary report ───────────────────────────────
# Paste this into the Agent chat:
#
# "Create a new R script that loads week4/demo_data.csv, performs basic data
#  cleaning (remove rows with NA, remove negative values in income), and
#  generates a summary report as a printed table."


# ── Example 2: Update ggplot graphics to colour-blind friendly palette ────────
# This file has several plots using default ggplot2 colours.
# Paste this into the Agent chat:
#
# "Update all ggplot graphics in week4/04_agent.R to use a colour-blind
#  friendly palette from the colorspace or viridis package."

p1 <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(cyl))) +
  geom_point(size = 3) +
  labs(title = "Weight vs MPG", colour = "Cylinders")

p2 <- ggplot(mtcars, aes(x = factor(cyl), y = hp, fill = factor(cyl))) +
  geom_boxplot() +
  labs(title = "HP by Cylinder count", x = "Cylinders", fill = "Cylinders")

p3 <- mtcars |>
  count(cyl, am) |>
  ggplot(aes(x = factor(cyl), y = n, fill = factor(am))) +
  geom_col(position = "dodge") +
  labs(title = "Cars by Cylinders and Transmission",
       x = "Cylinders", y = "Count", fill = "Transmission")

p1
p2
p3
