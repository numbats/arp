######## Course info ########
library(tidyverse)

# Start of semester
start_semester <- "2024-02-26"

# Week of mid-semester break
mid_semester_break <- "2024-04-01"

# Schedule
schedule <- tibble(
  Week = seq(12),
  Topic = c(
    "Foundations of R programming",
    "R package development",
    "R package development",
    "Debugging and profiling",
    "Functional programming",
    "Object-oriented programming",
    "Reactive programming: shiny",
    "Reactive programming: targets",
    "Metaprogramming",
    "Metaprogramming",
    "Rewriting R code in C++",
    "Interfacing with other languages"
  ),
  Reference = c(
    "1-8. *Advanced R*",
    "*R Packages*",
    "*R Packages*",
    "22-24. *Advanced R*",
    "9-11. *Advanced R*",
    "12-13. *Advanced R*",
    "*Mastering Shiny*",
    "*The {targets} R package user manual*",
    "17-20. *Advanced R*",
    "17-20. *Advanced R*",
    "25. *Advanced R*",
    "21. *Advanced R*"
  ),
  Reference_URL = c(
    "https://adv-r.hadley.nz/foundations-intro.html",
    "https://r-pkgs.org",
    "https://r-pkgs.org",
    "https://adv-r.hadley.nz/debugging.html",
    "https://adv-r.hadley.nz/fp.html",
    "https://adv-r.hadley.nz/oo.html",
    "https://mastering-shiny.org",
    "https://books.ropensci.org/targets/",
    "https://adv-r.hadley.nz/metaprogramming.html",
    "https://adv-r.hadley.nz/metaprogramming.html",
    "https://adv-r.hadley.nz/rcpp.html",
    "https://adv-r.hadley.nz/translation.html"
  )
)

# Add mid-semester break
calendar <- tibble(
    Date = seq(as.Date(start_semester), by = "1 week", length.out = 13)
  ) |>
  mutate(
    Week = row_number(),
    Week = if_else(Date < mid_semester_break, Week, Week - 1),
    #Week =
  )

# Add calendar to schedule
schedule <- schedule |>
  left_join(calendar, by = "Week") |>
  mutate(
    Week = if_else(Date == mid_semester_break, NA, Week),
    Topic = if_else(Date == mid_semester_break, "Mid-semester break", Topic),
    Reference = if_else(Date == mid_semester_break, NA, Reference),
    Reference_URL = if_else(Date == mid_semester_break, NA, Reference_URL)
  ) |>
  select(Week, Date, everything())

# Add assignment details
lastmon <- function(x) {
  7 * floor(as.numeric(x-1+4)/7) + as.Date(1-4, origin="1970-01-01")
}

assignments <- read_csv(here::here("assignments.csv")) |>
  mutate(
    Date = lastmon(Due),
    Moodle = paste0("https://learning.monash.edu/mod/assign/view.php?id=", Moodle),
    File = paste0("assignments/", File)
  )

schedule <- schedule |>
  full_join(assignments, by = "Date") |>
  mutate(Week = if_else(is.na(Week) & Date > "2024-05-20", 13, Week))

show_assignments <- function(week) {
  ass <- schedule |>
    filter(
      Week >= week & (week > Week - 3 | week > 8),
      !is.na(Assignment),
    ) |>
    select(Assignment:File)
  if(NROW(ass) > 0) {
    cat("\n\n## Assignments\n\n")
    for(i in seq(NROW(ass))) {
      cat("* [", ass$Assignment[i], "](../", ass$File[i], ") is due on ",
          format(ass$Due[i], "%A %d %B.\n"), sep="")
    }
  }
}


submit <- function(schedule, assignment) {
  ass <- schedule  |>
    filter(Assignment == assignment)
  due <- format(ass$Due, "%e %B %Y") |> stringr::str_trim()
  url <- ass$Moodle
  button <- paste0("<br><br><hr><b>Due: ", due, "</b><br>",
                   "<a href=",url," class = 'badge badge-large badge-blue'>",
                   "<font size='+2'>&nbsp;&nbsp;<b>Submit</b>&nbsp;&nbsp;</font><br></a>")
  cat(button)
}