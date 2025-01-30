#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
List nicernig2 (
    const int n, 
    const vec mu,
    const mat Sigma,
    const double s, 
    const double nu
) {
  
  vec rig2 = s / chi2rnd( nu, n );
  mat X(n, mu.n_elem);
  for (int i=0; i<n; i++) {
    X.row(i) = trans(mvnrnd( mu, Sigma ));
  }
  
  return List::create(
    _["x"] = X,
    _["sigma2"] = rig2
  );
}

/*** R
nicernig2(4, rep(0,2), diag(2), 1, 1)
*/