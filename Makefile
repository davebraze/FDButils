R_OPTS = --vanilla -e
DATE = $(shell date.exe "+%Y%m%d")

date:
	@echo $(DATE)

##### build and check package

## Build the package. Set 'binary=FALSE' (build a source package) for cross-platform portability.
build: 
	R $(R_OPTS) "devtools::build(pkg='.', binary=FALSE, vignettes=TRUE, manual=TRUE)"

## Check the built package for current version number.
checkbuilt: 
	R $(R_OPTS) "devtools::check_built(path=here::here('..', 'FDButils_0.0.9.tar.gz'))"

## Build and check the package. Does not save built package. Must pass checks with no errors, and preferably no warnings. 
check:
	R $(R_OPTS) "devtools::check(pkg='.')"

##### Build pkgdown site from scratch (online documentation)
pkgdown:
	R $(R_OPTS) "pkgdown::clean_site(pkg='.')"
	R $(R_OPTS) "pkgdown::build_site(pkg='.', preview=TRUE)"

##### Build documentation in various formats in order to check it's ok.

## Build roxygen2 documentation
document: 
	R $(R_OPTS) "devtools::document(pkg='.')"

## Build PDF manual and put it in the parent directory to the package.
manual: 
	R $(R_OPTS) "devtools::build_manual(pkg='.')"
