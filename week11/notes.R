Rcpp::cppFunction('
  DataFrame nicetry (int n) {
    NumericVector v = rnorm(n);
    IntegerVector x = seq_len(n);
    LogicalVector y = v > 0;
    CharacterVector z(n, "nice");
    return List::create(_["v"] = v, _["x"] = x, _["y"] = y, _["z"] = z);
  }
')

nicetry(2)
