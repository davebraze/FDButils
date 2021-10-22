## Makefile tailored to R package development.
## 
## My general strategy here is to use calls to devtools:: functions, rather than
## calling 'R CMD ...' directly.
## 
## The Makefile is intended to live in a packages top-level folder. It should work
## from there with no need for package-specific mods.

R.OPTS := --vanilla -e
DATE := $(shell date "+%Y%m%d")
PKG.VERS := $(shell Rscript $(R.OPTS) "cat(read.dcf('DESCRIPTION', fields='Version'))")
PKG.NAME := $(shell Rscript $(R.OPTS) "cat(read.dcf('DESCRIPTION', fields='Package'))")
BUILT.PKG := $(PKG.NAME)_$(PKG.VERS).tar.gz

## Few if any targets correspond to files so, list them here to ensure they always run.
.phoney: help build checkbuilt check pkgdown document manual versiontab installgh installtb

## TODO:

## Print Constants and Targets defined in this Makefile
help:
	@echo Constants::
	@echo R.OPTS: $(R.OPTS)
	@echo DATE: $(DATE)
	@echo PKG.VERS: $(PKG.VERS) 
	@echo PKG.NAME: $(PKG.NAME) 
	@echo BUILT.PKG: $(BUILT.PKG) 
	@echo
	@echo Targets::
	@echo --
	@grep -E -B 1 "^[^\# ]+:" Makefile
	@echo --
	@echo 

##### Targets to build and check package.
##### Should pass checks with no errors, and preferably no warnings. 

## Build package with 'binary=FALSE' for portability. Put tarball in parent to source directory.
build: 
	R $(R.OPTS) "devtools::build(pkg='.', binary=FALSE, vignettes=TRUE, manual=FALSE)"

## Check the built package for current version number.
checkbuilt: ../$(BUILT.PKG)
	R $(R.OPTS) "devtools::check_built(path=here::here('..', '$(BUILT.PKG)'))"

## Build and check the package. Does not save built package. 
check:
	R $(R.OPTS) "devtools::check(pkg='.')"

## Build pkgdown site from scratch (online documentation). Overwrites existing site.
pkgdown:
	R $(R.OPTS) "pkgdown::clean_site(pkg='.')"
	R $(R.OPTS) "pkgdown::build_site(pkg='.', preview=TRUE)"

##### targets to build documentation in various formats, mostly in order to check it's ok before release

## Build rds documentation via roxygen2.
document: 
	R $(R.OPTS) "devtools::document(pkg='.')"

## Build PDF manual and put it in the parent directory to the package.
manual: document
	R $(R.OPTS) "devtools::build_manual(pkg='.')"

##### Prepare for release of new version

## Set a version tag and push it to remote. 
versiontag:
	git tag -a v$(PKG.VERS) -m "new release version v$(PKG.VERS)"
	git push --tags

##### Targets to install package 

##  Install most recent version available on github.
installgh:
	R $(R.OPTS) "remotes::install_github('davebraze/$(PKG.NAME)')"

## Install current version from a local tarball, if available.
installtb:
	R $(R.OPTS) "devtools::install('../$(PKG.NAME)')"
