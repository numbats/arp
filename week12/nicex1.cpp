#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix nicetry (int n) {
  NumericVector i(n, 1.0);
  NumericVector t = cumsum(i);
  NumericVector tt = t - mean(t);
  NumericVector tt2 = pow(tt, 2);
  NumericMatrix out = cbind(i, tt, tt2);
  return out;
}

/*** R
nicetry(4)
*/
