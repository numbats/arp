#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
vec nicerw (
    const int T
) {
  vec x(T, fill::randn);
  return cumsum(x);
}

/*** R
plot.ts(nicerw(100))
*/
