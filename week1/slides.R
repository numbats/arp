## Ex 1 ------------------------------------------------------------------------
df <- data.frame(runif(3), runif(3))
names(df) <- c(1, 2)


## Ex 2 ------------------------------------------------------------------------
x <- runif(1e6)
y <- list(x, x, x)


## Ex 3 ------------------------------------------------------------------------
a <- c(1, 5, 3, 2)
b <- a
b[[1]] <- 10


## Binding basics

x <- c(1, 2, 3)
y <- x
library(lobstr)
obj_addr(x)
obj_addr(y)


## Syntactic names
_abc <- 1
if <- 10

`_abc` <- 1
`_abc`


## Copy on modify
x <- c(1, 2, 3)
y <- x

y[[3]] <- 4
x

## tracemem()
x <- c(1, 2, 3)
tracemem(x)

y <- x
y[[3]] <- 4L


y[[3]] <- 5L
untracemem(x)


## Modify in place
v <- c(1, 2, 3)

v[[3]] <- 4


## Function calls
f <- function(a) {
  a
}

x <- c(1, 2, 3)
tracemem(x)
z <- f(x)
# there's no copy here!
untracemem(x)


## Lists
l1 <- list(1, 2, 3)
l2 <- l1
l2[[3]] <- 4


## Data frames
d1 <- data.frame(x = c(1, 5, 6), y = c(2, 4, 3))
d2 <- d1
d2[, 2] <- d2[, 2] * 2

d1 <- data.frame(x = c(1, 5, 6), y = c(2, 4, 3))
d3 <- d1
d3[1, ] <- d3[1, ] * 3


## Character vectors
x <- c("a", "a", "abc", "d")

## Ex 4
a <- 1:10
b <- list(a, a)
c <- list(b, a, 1:10)


## Ex 5
x <- list(1:10)
x[[2]] <- x


## Object size
obj_size(ggplot2::diamonds)
banana <- "bananas bananas bananas"
obj_size(banana)
obj_size(rep(banana, 100))

x <- runif(1e6)
obj_size(x)
y <- list(x, x, x)
obj_size(y)
obj_size(x, y)


## ALTREP

obj_size(1:3)
obj_size(1:1e6)
obj_size(c(1:1e6, 10))
obj_size(2 * (1:1e6))


## Ex 6

a <- runif(1e6)
obj_size(a)

b <- list(a, a)
obj_size(b)
obj_size(a, b)

b[[1]][[1]] <- 10
obj_size(b)
obj_size(a, b)

b[[2]][[1]] <- 10
obj_size(b)
obj_size(a, b)


## For loops

x <- data.frame(matrix(runif(3 * 1e4), ncol = 3))
medians <- vapply(x, median, numeric(1))
tracemem(x)

for (i in seq_along(medians)) {
  x[[i]] <- x[[i]] - medians[[i]]
}

y <- as.list(x)
tracemem(y)

for (i in 1:3) {
  y[[i]] <- y[[i]] - medians[[i]]
}


## Unbinding and the garbage collector
x <- 1:3
x <- 2:4
rm(x)

## Missing values
NA > 5
10 * NA
!NA

NA ^ 0
NA | TRUE
NA & FALSE

x <- c(NA, 5, NA, 10)
x == NA
is.na(x)


## Coercion

str(c("a", 1))
x <- c(FALSE, FALSE, TRUE)
as.numeric(x)
sum(x)
as.integer(c("1", "1.5", "a"))


## Ex 7
c(1, FALSE)
c("a", 1)
c(TRUE, 1L)

## Ex 8
1 == "1"
-1 < FALSE
"one" < 2

## Ex 9
c(FALSE, NA_character_)

## Getting and setting attributes
a <- 1:3
attr(a, "x") <- "abcdef"
a

attr(a, "y") <- 4:6
str(attributes(a))

# Or equivalently
a <- structure(
  1:3,
  x = "abcdef",
  y = 4:6
)
str(attributes(a))


## Names
# When creating it:
x <- c(a = 1, b = 2, c = 3)

# By assigning a character vector to names()
x <- 1:3
names(x) <- c("a", "b", "c")

# Inline, with setNames():
x <- setNames(1:3, c("a", "b", "c"))

x


## Dimensions
# Two scalar arguments specify row and column sizes
x <- matrix(1:6, nrow = 2, ncol = 3)
x

# One vector argument to describe all dimensions
y <- array(1:12, c(2, 3, 2))
y

# You can also modify an object in place by setting dim()
z <- 1:6
dim(z) <- c(3, 2)
z


str(1:3)                   # 1d vector
str(matrix(1:3, ncol = 1)) # column vector
str(matrix(1:3, nrow = 1)) # row vector
str(array(1:3, 3))         # "array" vector


## Ex 10
dim(1:10)

## Ex 11

## Ex 12
x1 <- array(1:5, c(1, 1, 5))
x2 <- array(1:5, c(1, 5, 1))
x3 <- array(1:5, c(5, 1, 1))

## Factors
x <- factor(c("a", "b", "b", "a"))
x
typeof(x)
attributes(x)

sex_char <- c("m", "m", "m")
sex_factor <- factor(sex_char, levels = c("m", "f"))
table(sex_char)
table(sex_factor)

grade <- ordered(c("b", "b", "a", "c"), levels = c("c", "b", "a"))
grade

## Dates
today <- Sys.Date()
typeof(today)
attributes(today)
date <- as.Date("1970-02-01")
unclass(date)

## Date-times
now_ct <- as.POSIXct("2018-08-01 22:00", tz = "UTC")
now_ct

typeof(now_ct)
attributes(now_ct)

structure(now_ct, tzone = "Asia/Tokyo")
structure(now_ct, tzone = "America/New_York")
structure(now_ct, tzone = "Australia/Lord_Howe")

## Ex 13
z <- table(LETTERS)
typeof(z)
attributes(z)
class(z)

## Ex 14
f1 <- factor(letters)
levels(f1) <- rev(levels(f1))

## Ex 15
f2 <- rev(factor(letters))
f3 <- factor(letters, levels = rev(letters))

## Lists
l1 <- list(
  1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9)
)
typeof(l1)
str(l1)
l3 <- list(list(list(1)))
str(l3)

l4 <- list(list(1, 2), c(3, 4))
l5 <- c(list(1, 2), c(3, 4))
str(l4)
str(l5)

## Testing and coercion
list(1:3)
as.list(1:3)

## Data frames and tibbles
df1 <- data.frame(x = 1:3, y = letters[1:3])
typeof(df1)
attributes(df1)

library(tibble)
df2 <- tibble(x = 1:3, y = letters[1:3])
typeof(df2)
attributes(df2)

names(data.frame(`1` = 1))
names(tibble(`1` = 1))

data.frame(x = 1:4, y = 1:2)
tibble(x = 1:4, y = 1:2)

tibble(
  x = 1:3,
  y = x * 2,
  z = 5
)

## Row names
df3 <- data.frame(
  age = c(35, 27, 18),
  hair = c("blond", "brown", "black"),
  row.names = c("Bob", "Susan", "Sam")
)
df3

as_tibble(df3)
as_tibble(df3, rownames = "name")

## Printing
dplyr::starwars

## List columns
df <- data.frame(x = 1:3)
df$y <- list(1:2, 1:3, 1:4)
data.frame(
  x = 1:3,
  y = I(list(1:2, 1:3, 1:4))
)
tibble(
  x = 1:3,
  y = list(1:2, 1:3, 1:4)
)


## Matrix and data frame columns
dfm <- tibble(
  x = 1:3 * 10,
  y = matrix(1:9, nrow = 3),
  z = data.frame(a = 3:1, b = letters[1:3])
)
str(dfm)


## Ex 16
data.frame(y = NULL)
data.frame(y = numeric(0))
tibble(y = numeric(0))

## Ex 17
data.frame(
  age = c(35, 27, 18),
  hair = c("blond", "brown", "black"),
  row.names = c("Bob", "Susan", "Bob")
)

## Ex 18
t(df3)
t(t(df))

## Ex 19
as.matrix(df3)

## NULL
length(NULL)
x <- NULL
x == NULL
is.null(x)

## Ex 20
x <- 1:10
x[3]
x[-3]
x[c(TRUE,FALSE)]
x["a"]

# Ex 21
x <- list(a = 1, b = 2)
x[1]
x[[1]]
x$a
x[["a"]]
x["a"]

## Ex 22
x <- matrix(1:4, nrow=2, ncol = 2)
x[,1]
x[,1,drop=FALSE]

## Ex 23
x[] <- 0
x
x <- 0
x

## Ex 24
x <- c("Liz", "John", "Bob")
z <- c(Alice = "Alicia",
       Bob = "Robert",
       Cat = "Catherine",
       John = "Jonathan",
       Liz = "Elizabeth")
newx <- z[x]
newx

## Ex 25
mtcars[mtcars$cyl = 4, ]
mtcars[-1:4, ]
mtcars[mtcars$cyl <= 5]
mtcars[mtcars$cyl == 4 | 6, ]

## Ex 26
mtcars[1:20]
mtcars[1:20, ]

## Ex 27
mydiag <- function(x) {
  stopifnot(is.matrix(x), nrow(x) == ncol(x))
  n <- nrow(x)
  x[1 + (0:(n-1))*(n+1)]
}
mydiag(matrix(1:9, nrow = 3))
mydiag(matrix(1:8, ncol=4))

## Ex 28
mod <- lm(mpg ~ wt, data = mtcars)
names(mod)
mod$df.residual

## Ex 29
summary(mod) |> names()
summary(mod)$r.squared

## Ex 30
mtcars[,sample(ncol(mtcars))]

# Ex 31
mtcars[sample(nrow(mtcars)),sample(ncol(mtcars))]

# Ex 32
m <- 3
mtcars[sample(nrow(mtcars), m),]
mtcars[sample(nrow(mtcars)-m, 1)+ (0:(m-1)),]

# Ex 33
mtcars[,order(colnames(mtcars))]
