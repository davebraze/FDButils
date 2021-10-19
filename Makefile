R.OPTS = --vanilla -e
DATE = $(shell date.exe "+%Y%m%d")
PKG.VERS = $(shell Rscript $(R.OPTS) "cat(read.dcf('DESCRIPTION', fields='Version'))")
PKG.NAME = $(shell Rscript $(R.OPTS) "cat(read.dcf('DESCRIPTION', fields='Package'))")
BUILT.PKG = $(PKG.NAME)_$(PKG.VERS).tar.gz

## TODO:
## o Add target for pushing version tag (e.g., v0.0.9) to github for package release

test:
	@echo $(BUILT.PKG)

date:
	@echo $(DATE)

##### targets to build and check package

## Build the package. Set 'binary=FALSE' (build a source package) for cross-platform portability.
build: 
	R $(R.OPTS) "devtools::build(pkg='.', binary=FALSE, vignettes=TRUE, manual=TRUE)"

## Check the built package for current version number.
## Must pass checks with no errors, and preferably no warnings. 
checkbuilt: 
	R $(R.OPTS) "devtools::check_built(path=here::here('..', '$(BUILT.PKG)'))"

## Build and check the package. Does not save built package.
## Must pass checks with no errors, and preferably no warnings. 
check:
	R $(R.OPTS) "devtools::check(pkg='.')"

##### target to build pkgdown site from scratch (online documentation)
pkgdown:
	R $(R.OPTS) "pkgdown::clean_site(pkg='.')"
	R $(R.OPTS) "pkgdown::build_site(pkg='.', preview=TRUE)"

##### targets to build documentation in various formats, mostly in order to check it's ok before release

## Build roxygen2 documentation
document: 
	R $(R.OPTS) "devtools::document(pkg='.')"

## Build PDF manual and put it in the parent directory to the package.
manual: 
	R $(R.OPTS) "devtools::build_manual(pkg='.')"

