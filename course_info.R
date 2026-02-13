######## Course info ########
library(dplyr)

# Start of semester
start_semester <- "2026-03-02"

# Week of mid-semester break
mid_semester_break <- "2026-04-06"

# Schedule
schedule <- tibble(
  Week = seq(12),
  Topic = c(
    "R tools and data structures",
    "Foundations of R programming",
    "R package development",
    "R programming with LLMs",
    "Debugging",
    "Functional programming",
    "Measuring and improving performance",
    "Object-oriented programming with S3",
    "Object-oriented programming with vctrs",
    "Metaprogramming",
    "Rewriting R code in C++",
    "Package hackathon"
  )
)

# Add mid-semester break
# Date here is Monday of each week
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
    Topic = if_else(Date == mid_semester_break, "Mid-semester break", Topic)
  ) |>
  select(Week, Date, everything())

# Add assignment details
lastmon <- function(x) {
  7 * floor(as.numeric(x - 1 + 4) / 7) + as.Date(1 - 4, origin = "1970-01-01")
}

assignments <- readr::read_csv(here::here("assignments.csv")) |>
  mutate(
    Date = lastmon(Due),
    Moodle = paste0(
      "https://learning.monash.edu/mod/assign/view.php?id=",
      Moodle
    ),
    File = paste0("assignments/", File)
  )

schedule <- schedule |>
  full_join(assignments, by = "Date")

show_assignments <- function(week) {
  ass <- schedule |>
    filter(
      Week >= week,
      !is.na(Assignment),
    ) |>
    filter(Week == min(Week) | Week - week <= 2) |>
    select(Assignment:File)
  if (NROW(ass) > 0) {
    cat("\n\n## Assignments\n\n")
    for (i in seq(NROW(ass))) {
      cat(
        "* [",
        ass$Assignment[i],
        "](../",
        ass$File[i],
        ") is due on ",
        format(ass$Due[i], "%A %d %B.\n"),
        sep = ""
      )
    }
  }
}

submit <- function(schedule, assignment) {
  ass <- schedule |>
    filter(Assignment == assignment)
  due <- format(ass$Due, "%e %B %Y") |> stringr::str_trim()
  url <- ass$Moodle
  button <- paste0(
    "<br><br><hr><b>Due: ",
    due,
    "</b><br>",
    "<a href=",
    url,
    " class = 'badge badge-large badge-blue'>",
    "<font size='+2'>&nbsp;&nbsp;<b>Join GitHub Classroom</b>&nbsp;&nbsp;</font><br></a>"
  )
  cat(button)
}

show_slides <- function(week) {
  qmd_file <- here::here(paste0("week", week, "/slides.qmd"))
  slides_exist <- fs::file_exists(qmd_file)
  if (slides_exist) {
    pdf_file <- paste0("https://arp.numbat.space/week", week, "/slides.pdf")
    embed <- paste0(
      "<iframe src='https://docs.google.com/gview?url=",
      pdf_file,
      "&embedded=true' width='100%' height=465></iframe>"
    )
    button <- paste0(
      "<a href=",
      pdf_file,
      " class='badge badge-small badge-red'>Download pdf</a>"
    )
    cat(paste0("## Slides for week\n\n", embed, "\n", button))
  }
}
