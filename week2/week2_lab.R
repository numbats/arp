FALSE == -1
as.logical(-1)
as.logical(NA)
NA || TRUE

list(1,2,3)[c(3,2,1)]

letters[[1:5]]
list(1,2,3)[[1]]


lobstr::tree(list(list(3,2), 1, 4)[[1]])

library(dplyr)
as_tibble(mtcars)$mpg
as_tibble(mtcars)$"mpg"

as_tibble(mtcars)[["mpg"]]
as_tibble(mtcars)["mpg"]

as_tibble(mtcars)[[mpg]]



as_tibble(mtcars)$mp
mtcars$mp
mtcars$mpz <- rnorm(nrow(mtcars))
mtcars$mp


matrix(rnorm(25), nrow = 5)[,1, drop = FALSE]
matrix(rnorm(25), nrow = 5)[[5]]

dim(matrix(rnorm(25), nrow = 5))
attributes(matrix(rnorm(25), nrow = 5))


 mat <- (matrix(rnorm(25), nrow = 5))
c(mat)

help("[[")
?"[["
?`[[`  



mtcars[mtcars$cyl == 4, ]
mtcars[-(1:4), ]
mtcars[mtcars$cyl <= 5, ]
mtcars[mtcars$cyl %in% c(4, 6), ]



if (isTRUE(logy)) {
  log(y)
} else {
  y
}

ifelse(mtcars$cyl <= 5, "small", "large")
dplyr::if_else(mtcars$cyl <= 5, "small", "large")

as_tibble(mtcars) |> 
  mutate(
    ifelse(mtcars$cyl <= 5, "small", "large")
  )

unclass(Sys.Date())

ifelse(c(TRUE, FALSE), Sys.Date(), "Oops")
dplyr::if_else(c(TRUE, FALSE), Sys.Date(), "Oops")
dplyr::if_else(c(TRUE), Sys.Date(), NA)


as.logical(length(1:10))
as.logical(0)
as.logical(-100)

numeric()
length(numeric())


# Recycling makes this incorrect
mtcars[mtcars$cyl == c(4, 6), ]


length(mtcars$cyl)

tibble(a = 1, b = 1:4)

logplus1 <- function (x) {
  x <- x + 1
  if(logx) {
    x <- log(x)
  }
  
  return(x)
}

body(logplus1)
environment(logplus1) <- baseenv()

logx <- TRUE
logplus1(x = mtcars$cyl)

x <- 10
y <- 20
g02 <- function() {
  # x <- 1
  # y <- 2
  c(x, y)
}
g02()


x <- 2
g03 <- function() {
  y <<- 1
  c(x, y)
}
g03()

y


g07 <- function(x) { x + 1 }
g08 <- function(fx) {
  fx(10)
}
g08(log)


h01 <- function(x) {
  x
  10
}
h01(stop("This is an error!"))



show_time <- function(x = stop("Error!")) {
  stop <- function(...) Sys.time()
  print(stop("Error!"))
}
show_time()



i01 <- function(y, z) {
  list(y = y, z = z)
}
i02 <- function(x, ...) {
  browser()
  i01(...)
}
str(i02(x = 1, y = 2, z = 3))

mysum <- function(...) {
  invisible(sum(c(...)))
}
z <- mysum(1,2,3)
z


with_dir <- function(dir, code) {
  old <- setwd(dir)
  on.exit(setwd(old), add = TRUE)
  stop()
}
getwd()


3 + 1
`+`(3, 1)

`%myplus%` <- `+`
`%+%`

3 %myplus% 9


dim() <- 1:2

`dim<-`


x <- list(1,2,3)
names(x) <- c("a", "B", "c")

`names<-`(x, c("a", "B", "c"))

setNames(x, c("a", "B", "c"))
x
