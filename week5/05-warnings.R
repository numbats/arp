# Exercise: Catching warnings with options(warn = 2)

clean_and_sum <- function(x) {
  nums <- as.numeric(x)
  sum(nums[nums > 0], na.rm = TRUE)
}
readings <- c("1.2", "3.4", "N/A", "2.1", "-0.5", "4.7")
clean_and_sum(readings)

# The function silently discards some values. Set options(warn = 2) before running to convert warnings to errors, then use the traceback to identify the exact line responsible.
