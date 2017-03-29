FDButils
====
[![github release](https://img.shields.io/github/release/davebraze/FDButils.svg?label=current+release)](https://github.com/davebraze/FDButils/releases)
[![Travis-CI Build Status](https://travis-ci.org/davebraze/FDButils.svg?branch=master)](https://travis-ci.org/davebraze/FDButils)
[![license](https://img.shields.io/badge/license-MIT-lightgray.svg)](LICENSE)

Utility functions for use in other FDB packages. Code in this package
should make use only of functions in the dozen or so "base R"
packages. It should also be pretty stable, as other packages may
depend on it.

Install with devtools::install\_github():

```R
install.packages("devtools") ## If you don't already have it.
library(devtools)
install_github("davebraze/FDButils")
```
