##' @title Number Of Non-missing Values In Vector.
##'
##' @description Count non-missing values in v.
##'
##' @details Returns the number of non-missing values in vector v. A convenience wrapper around
##'     \code{sum(!is.na(v))}.
##'
##' @param v A vector.
##' @return integer, length of x minus the number of NAs in x.
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
nobs <-
    function (v){
        if (!is.vector(v)) {
            warning('v must be a vector')
            return()
        }
        sum(!is.na(v))
    }
