R_OPTS = --vanilla

date:
	date.exe "+%Y%m%d"

### building a package

document: # Build documentation
	R $(R_OPTS) -e "devtools::document(pkg='.')"

precheck: # Check for problems. Must pass without errors, and preferably no warnings. 
	R $(R_OPTS) -e "devtools::check(pkg='.')"

build: ## build the package
	R $(R_OPTS) -e "devtools::build(pkg='.', path='..', binary=FALSE, vignettes=FALSE, manual=FALSE)"

check: ## check the built package
	R $(R_OPTS) -e "devtools::check_built(path='..', 'FDButils_0.0.8.tar.gz')"



nogo:
	R $(R_OPTS) -e "knitr::purl('$(source)')" ## pull source from Rmd file
	R $(R_OPTS) -e "rmarkdown::render('"03-slides.Rmd"')"
	rm -f "02-cohort1-dibels-pssa.R"

### cleaning up
