library(ellmer)
library(palmerpenguins)

chat <- chat_anthropic(model = "claude-sonnet-4-6")

# Register a tool the LLM can call
summarise_column <- function(dataset, column) {
  data <- get(dataset, envir = .GlobalEnv)
  paste(capture.output(summary(data[[column]])), collapse = "\n")
}
chat$register_tool(tool(
  summarise_column,
  name = "summarise_column",
  description = "Summarise a column of a dataset",
  arguments = list(
    dataset = type_string("Name of the dataset", required = TRUE),
    column = type_string("Name of the column", required = TRUE)
  )
))

# LLM decides when and how to call the tool
chat$chat(
  "What does the bill_length_mm column in penguins look like?"
)
