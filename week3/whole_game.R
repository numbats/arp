library(devtools)
# Create package with one function that doubles numbers
create_package("/tmp/doubler")
setwd("/tmp/doubler")
use_git()
use_gpl3_license()

load_all() # Or Ctrl-L

use_r("dblr")

dblr(5)
dblr(3 + 2i)
dblr("A")
dblr(TRUE)

check()

document()

install()
library(doubler)

use_testthat()
use_test("dblr")
test()

use_package()
use_github()
use_readme_rmd()
check()
install()
