library(tidyverse)
library(rainbow)

survey_data <- read.csv("https://arp.numbat.space/week4/survey_data.csv", row.names = FALSE)

survey_data |>
  select(-RespondentID) |>
  group_by(Gender) |>
  count(Satisfaction)
