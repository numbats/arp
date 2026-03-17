#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List nicelist (int n) {
  NumericVector p = rnorm(n);
  NumericVector s(n);
  for (int i=0; i<n; i++) {
    s[i] =  pow(p[i], 2);
  }
  return List::create(_["p"] = p, _["s"] = s);
}
