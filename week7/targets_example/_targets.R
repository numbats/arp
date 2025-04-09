library(targets)
tar_option_set(packages = c("readr", "dplyr", "ggplot2"))
tar_source()
list(
  tar_target(file, "data/data.csv", format = "file"),
  tar_target(data, get_data(file)),
  tar_target(model, fit_model(data)),
  tar_target(plot, plot_model(model, data))
)
