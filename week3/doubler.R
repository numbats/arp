devtools::dev_sitrep()

library(devtools)
# Create package with one function that doubles numbers

# Since github already set up, we will do that first

create_from_github(
  repo_spec = "numbats/assignment-1-package-creation-robjhyndman",
  destdir = "~/Desktop/",
  protocol = "ssh"
)
# Rename folder and Rproj to your package name
create_package("~/Desktop/doubler")
use_github_links()

use_gpl3_license()


use_r("dblr")
document()
build()
install()
library(doubler)

dblr(5)
dblr(3 + 2i)
dblr("A")
dblr(TRUE)

load_all() # Or Ctrl-L

check()

use_readme_rmd()
build_readme()

usethis::use_vignette("introduction")

use_testthat()
use_test("dblr")
test()

use_package()
use_github()
