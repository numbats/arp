#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
using namespace arma;

// [[Rcpp::export]]
vec nicerig2 (
    const int     n,    // a positive integer - number of draws
    const double  s,    // a positive scale parameter
    const double  nu    // a positive shape parameter
) {
  vec rig2 = s / chi2rnd( nu, n );
  return rig2;
}

/*** R
nicerig2(2, 1, 1)
*/
