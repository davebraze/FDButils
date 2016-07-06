# Use .onLoad for side effects of package.
.onLoad <- function(lib,pkg) {
    ## See HW page for thoughts on what to do here: http://r-pkgs.had.co.nz/r.html
}

# Use .onAttach for informative messages.
.onAttach <- function(lib, pkg) {

    packageStartupMessage("    Welcome to ", pkg, ".")

    ## Better to build the startupMessage by reading the Description file, as in:
    ## ver <- read.dcf(file.path(lib, pkg, "DESCRIPTION"), "Version")
    ## ver <- as.character(ver)
    ## packageStartupMessage(paste("Welcome to",  pkg, ", version ", ver, "."))

    packageStartupMessage("    (c) 2014-2016, Dave Braze and others.")
    packageStartupMessage("    Released under the MIT license.\n")

    ## maybe call citation("FDButils")

    invisible()
}
