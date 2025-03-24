# Exercise 1

c(1, FALSE)
c("a", 1)
c(TRUE, 1L)

# Exercise 2

1 == "1"
-1 < FALSE
"one" < 2

# Exercise 3

c(FALSE, NA_character_)

# Exercise 4

x <- c(1, 2, 3)
dim(x)

# Exercise 5

NROW(x)
NCOL(x)
NROW(mtcars)
NCOL(mtcars)

# Exercise 6

x1 <- array(1:5, c(1, 1, 5))
x2 <- array(1:5, c(1, 5, 1))
x3 <- array(1:5, c(5, 1, 1))

# Exercise 7

table(mtcars$cyl) |> class()
table(mtcars$cyl) |> typeof()
table(mtcars$cyl) |> attributes()
table(mtcars$cyl) |> dim()
table(mtcars$cyl, mtcars$gear) |> dim()

# Exercise 8

f1 <- factor(letters)
levels(f1) <- rev(levels(f1))

# Exercise 9

f2 <- rev(factor(letters))
f3 <- factor(letters, levels = rev(letters))

# Exercise 10

df <- data.frame(x = 1:10, y = LETTERS[1:10])
rownames(df) <- c("a", "a", letters[3:10])

# Exercise 11

t(df)
t(t(df))

# Exercise 12

as.matrix(df)
data.matrix(df)

# Exercise 13

x <- 1:10
x[3:5]
x[-(3:5)]
x[x > 5]
x[c("a", "b", "c")]
names(x) <- letters[1:10]
x[c("a", "b", "c")]

# Exercise 14

L <- list(a = 1, b = 2, c = 3)
L[1]
L[[1]]
L$a

# Exercise 15

x <- matrix(1:9, nrow = 3)
x[1, ]
x[1, , drop = FALSE]

# Exercise 16

mtcars[mtcars$cyl = 4, ]
mtcars[-1:4, ]
mtcars[mtcars$cyl <= 5]
mtcars[mtcars$cyl == 4 | 6, ]

# Exercise 17

mod <- lm(mpg ~ wt, data = mtcars)
names(mod)
mod$df.residual

# Exercise 18

tmp <- summary(mod)
names(tmp)
tmp$r.squared

# Exercise 19

mtcars[sample(NROW(mtcars)), ]

# Exercise 20
m <- 10
mtcars[sample(NROW(mtcars), m), ]
mtcars[sample(NROW(mtcars)-m, 1) - 1 + seq(m), ]

# Exercise 21
mtcars[,order(colnames(mtcars))]

# Exercise 22

sum(1, 2, 3)
mean(1, 2, 3)
sum(1, 2, 3, na.omit = TRUE)
mean(1, 2, 3, na.omit = TRUE)

# Exercise 23

x <- sample(replace = TRUE, 20, x = c(1:10, NA))
y <- runif(min = 0, max = 1, 20)
cor(m = "k", y = y, u = "p", x = x)

# Exercise 24

show_condition <- function(code) {
  tryCatch(
    error = function(cnd) "error",
    warning = function(cnd) "warning",
    message = function(cnd) "message",
    {
      code
      5
    }
  )
}
show_condition(stop("!"))
show_condition(10)
show_condition(warning("?!"))
