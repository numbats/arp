library(rlang)
text <- "5 * 3 + 7"
code <- rlang::expr_text(text)
math <- rlang::parse_expr(text)
as.list(math)


f <- function(func) {
  g(func)
}
g <- function(func) {
  f(func)
}

g(f)


call2(sym("mutate"), .data = sym("mtcars"), expr(wt/hp))
call2(sym("/"), sym("wt"), sym("hp"))
