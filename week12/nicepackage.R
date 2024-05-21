
RcppArmadillo::RcppArmadillo.package.skeleton("nicepackage")
usethis::use_git()
usethis::use_gpl3_license()
usethis::use_package_doc()
roxygen2::roxygenise()
usethis::use_rcpp_armadillo()

Rcpp::compileAttributes()
devtools::document()
devtools::check()


devtools::load_all()
hist(nicerig2(10000, 1, 10), breaks = 100)
?nicerig2
?nicepackage



# to be copy/pasted
############################################################

#ifndef _NICERIG2_H_
#define _NICERIG2_H_

#include <RcppArmadillo.h>

arma::vec nicerig2 (
  const int     n,    // a positive integer - number of draws
  const double  s,    // a positive scale parameter
  const double  nu    // a positive shape parameter
);

#endif  // _NICERIG2_H_

############################################################

#' @title Samples random numbers from the inverted gamma 2 distribution
#'
#' @description Provides independent draws
#' @param n a positive integer, number of draws
#' @param scale a positive scalar, scale parameter
#' @param shape a positive integer, shape parameter
#'
#' @return a vector with \code{n} independent draws from the inverted gamma 2 distribution
#'
#' @export

############################################################

#' @name nicepackage-package
#' @aliases nicepackage-package nicepackage
#' @docType package
#' @importFrom Rcpp sourceCpp
#' @useDynLib nicepackage, .registration = TRUE
#' @keywords internal
"_PACKAGE"

############################################################
