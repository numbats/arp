library(dplyr)

# Load data
demo_data <- read.csv(here::here("week4/demo_data.csv"))

# Clean data
cleaned_data <- demo_data |>
  filter(
    # Exclude negative income values, treating them as invalid/data-quality issues for this analysis
    !is.na(id),
    !is.na(age),
    !is.na(income),
    !is.na(group),
    income >= 0
  )

# Summary report by group
summary_report <- cleaned_data |>
  summarise(
    n = n(),
    age_mean = round(mean(age), 1),
    age_sd = round(sd(age), 1),
    age_min = min(age),
    age_max = max(age),
    income_mean = round(mean(income), 0),
    income_sd = round(sd(income), 0),
    income_min = round(min(income), 0),
    income_max = round(max(income), 0),
    .by = group
  ) |>
  arrange(group)

print(summary_report)
