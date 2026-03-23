library(ellmer)
chat <- chat_anthropic(
  model = "claude-sonnet-4-6",
  system_prompt = "You are a helpful assistant for R programming tasks. Be concise and provide code examples when appropriate. Also be funny."
)
chat$chat("How would I code a fizzbuzz function in R?")
chat$chat("Modify it to allow any two numbers to be used instead of 3 and 5.")
