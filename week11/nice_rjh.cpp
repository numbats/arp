#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
NumericMatrix nicetry (int T) {
  NumericVector i(T, 1.0);
  IntegerVector intt = seq_len(T);
  NumericVector t = as<NumericVector>(intt);
  NumericVector tt = t - mean(t);
  NumericVector tt2 = pow(tt, 2);
  NumericMatrix out = cbind(i, tt, tt2);
  return out;
}

// [[Rcpp::export]]
NumericVector nicerw (int n) {
  NumericVector x = rnorm(n);
  for(int i = 1; i < n; i++) {
      x[i] = x[i-1] + x[i];
  }
  return x;
}


// [[Rcpp::export]]
vec nicerw2 (
    const int T
) {
  vec x(T, fill::randn);
  return cumsum(x);
}

