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
create_package(".")
# Add github links to DESCRIPTION file
use_github_links()
# Use GPL-3 licence
use_gpl3_license()
# Create first R file in R folder
use_r("dblr")
# Go somewhere in R file and select "Insert Roxygen Skeleton" from RStudio code menu. Then complete documentation
# Generate help files
document()
# Build and load package
build() # Or Ctrl-Shift-B
# Load current version of package without rebuilding it
load_all() # Or Ctrl-Shift-L
# Check package passes tests
check() # Or Ctrl-Shift_E

# Generate readme file
use_readme_rmd()
# Build readme file
build_readme()
# Generate vignette
usethis::use_vignette("introduction")
# Use testthat facilities for unit testing
use_testthat()
# Create tests for dblr() function
use_test("dblr")
# Run tests
test() # Or Ctrl-Shift-T

# Add package to imports
use_package()
# Add pkgdown website
use_pkgdown()

# Add github action to check package
use_github_action_check_standard()
