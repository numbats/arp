library(reticulate)

os <- reticulate::import("os")
# os.abort()
# os$abort()

files <- os$listdir()
readLines(files[1])

numpy <- import("numpy", convert = FALSE)

a <- numpy$array(c(1:4))
a
a$length
b <- a$cumsum()
a$size
class(a)

py_to_r(b)
r_to_py(1:4)

# py_install("matplotlib")
# reticulate::install_python()

r_to_py(1)
r_to_py(list(1))
r_to_py(1:10)
r_to_py(as.list(1:10))


r_to_py(mtcars)

library(dplyr)
con <- DBI::dbConnect(RSQLite::SQLite(), host = ":memory:")
DBI::dbListTables(con)
copy_to(con, mtcars)
DBI::dbWriteTable(con, "mtcars", mtcars)

DBI::dbListTables(con)

db_mtcars <- tbl(con, "mtcars")
class(db_mtcars)


db_mtcars |> 
  filter(cyl == 4) |> 
  summarise(hp = mean(hp, na.rm=TRUE)) |> 
  collect()
DBI::dbDisconnect(con)

con


con <- DBI::dbConnect(
  RPostgres::Postgres(),
  dbname = "arp",
  host = "arp.nectric.com.au", port = "5432",
  user = "monash", password = "arp2024"
)
con
# Host: arp.nectric.com.au:5432
# Username: monash
# Password: arp2024
# Database: arp


DBI::dbListTables(con)
tbl(con, "penguins") |> 
  group_by(species) |> 
  summarise(avg_weight_g = mean(body_mass_g, na.rm = TRUE)) |> 
  collect()

usethis::create_package("wordcloud2")
