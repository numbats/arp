# Exercise: Reading a traceback

parse_date_range <- function(dates) {
  start <- extract_date(dates[1])
  end <- extract_date(dates[2])
  difftime(end, start, units = "days")
}
extract_date <- function(x) {
  validate_format(x)
  as.Date(x, format = "%Y-%m-%d")
}
validate_format <- function(x) {
  if (!grepl("^\\d{4}-\\d{2}-\\d{2}$", x)) {
    stop("Invalid date format: ", x)
  }
}
parse_date_range(c("2024-01-01", "01/06/2024"))

#  Run the code and use the traceback to identify which function produced the error. Then fix it.
