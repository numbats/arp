# Not working
my_sum <- function(x) {
  total <- 0
  for (i in length(x)) {
    total <- total + i
  }
  return(total)
}
my_sum(1:5)
