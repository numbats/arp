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
