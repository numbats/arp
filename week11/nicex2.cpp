#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector nicetry (int n) {
  NumericVector i = rnorm(n);
  return cumsum(i);
}

/*** R
nicetry(4)
*/
