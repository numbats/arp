
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix timesTwo(int T) {
  NumericVector i(T, 1.0);
  NumericVector t = cumsum(i);
  NumericVector tt = t - mean(t);
  NumericVector tt2 = pow(t, 2);
  NumericMatrix out = cbind(i, tt, tt2);
  return out;
}


/*** R
timesTwo(42)
*/
