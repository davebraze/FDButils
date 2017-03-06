FDButils
====

Utility functions for use in other FDB packages. Code in this package
should make use only of functions in the dozen or so "base R"
packages. Code in FDButils should be pretty stable, as other packages
may depend on it.

Install with devtools::install\_github():

```R
install.packages("devtools") ## If you don't already have it.
library(devtools)
install_github("davebraze/FDButils")
```
