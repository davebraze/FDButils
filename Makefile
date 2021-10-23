## Makefile for R package development.
## 
## My general strategy here is to use calls to devtools:: functions, rather than
## calling 'R CMD ...' directly.
## 
## The Makefile is intended to live in a package's top-level folder. It should work
## from there with no need for package-specific mods.
##
## I use GNU make. Be warned.
##

R.OPTS := --vanilla -e
DATE := $(shell date "+%Y%m%d")
PKG.VERS := $(shell Rscript $(R.OPTS) "cat(read.dcf('DESCRIPTION', fields='Version'))")
PKG.NAME := $(shell Rscript $(R.OPTS) "cat(read.dcf('DESCRIPTION', fields='Package'))")
BUILT.PKG := $(PKG.NAME)_$(PKG.VERS).tar.gz

.phoney: help build checkbuilt check pkgdown document manual versiontab install.gh install.local
## Few targets correspond to files, so, list them here to ensure they always run.

## TODO:

help:
## Print Constants and Targets defined in this Makefile
	@echo Constants::
	@echo R.OPTS: $(R.OPTS)
	@echo DATE: $(DATE)
	@echo PKG.VERS: $(PKG.VERS) 
	@echo PKG.NAME: $(PKG.NAME) 
	@echo BUILT.PKG: $(BUILT.PKG) 
	@echo
	@echo Targets::
	@echo --
	@grep -E -A 1 "^[^\# ]+:" Makefile
	@echo --
	@echo 

##### Targets to build and check package.
##### Should pass checks with no errors, and preferably no warnings. 

build: 
## Build package with 'binary=FALSE' for portability. Put tarball in parent to source directory.
	R $(R.OPTS) "devtools::build(pkg='.', binary=FALSE, vignettes=TRUE, manual=FALSE)"

checkbuilt:
## Check the built package for current version number.
## TODO: 1st check existence of '..$(built.pkg); build it if necessary (make build)
	R $(R.OPTS) "devtools::check_built(path=here::here('..', '$(BUILT.PKG)'))"

check:
## Build and check the package. Does not save built package. 
	R $(R.OPTS) "devtools::check(pkg='.')"

pkgdown: document
## Build pkgdown site from scratch (online documentation). Overwrites existing site.
	R $(R.OPTS) "pkgdown::clean_site(pkg='.')"
	R $(R.OPTS) "pkgdown::build_site(pkg='.', preview=TRUE)"

##### targets to build documentation in various formats, mostly in order to check it's ok before release

document: 
## Build rds documentation via roxygen2.
	R $(R.OPTS) "devtools::document(pkg='.')"

manual: document
## Build PDF manual and put it in the parent directory to the package.
	R $(R.OPTS) "devtools::build_manual(pkg='.')"

##### Prepare for release of new version

versiontag:
## Set a version tag and push it to remote. 
	git tag -a v$(PKG.VERS) -m "new release version v$(PKG.VERS)"
	git push --tags

##### Targets to install package 

install.gh:
## Install most recent version available on github.
## TODO: FIXME! Does not work, presently
	R $(R.OPTS) "remotes::install_github(repo='davebraze/$(PKG.NAME)')"

install.local:
## Install current version from a local tarball, if available.
## Looks to the parent of the package source directory to find the tarball.
## TODO: 1st check existence of the tarball; build it if necessary (make build).
	R $(R.OPTS) "remotes::install_local(path=here::here('..', '$(BUILT.PKG)'))"
