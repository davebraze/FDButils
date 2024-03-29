##' @title Greatest common divisor.
##'
##' @description gcd0() Takes two whole numbers as arguments and returns their greatest common divisor.
##'
##' @details gcd0() Takes two whole numbers as arguments and returns their greatest common divisor. Throws
##'     an error if either number is not a whole number (to within \code{.Machine$double.eps^0.5}).
##'
##' @param a A whole number
##' @param b A whole number
##' @return gcd0() returns the greatest common divisor of a and b as a numeric vector of length 1.
##' @author David Braze \email{davebraze@@gmail.com}
## @export
##' @noRd
## @rdname gcd
##' @examples
##' gcd0(36, 48)
##' gcd0(-36, 48)
gcd0 <- function(a,b) {
    if (!(isWholeNumber(a) && isWholeNumber(b))) stop("gcd0() is defined over whole numbers only.")
    a <- abs(a); b <- abs(b)
    ss <- min(a,b)

    for (ii in ss:1) {
        if((a %% ii == 0) && (b %% ii == 0)) return(ii)
    }

    stop("No GCD (should not be possible)")
}

##' @title Greatest common divisor.
##'
##' @description \code{gcd()} takes a vector of whole numbers and returns their greatest common divisor as a numeric vector of length 1.
##'
##' @details \code{gcd()} takes a vector, v, of whole numbers as argument and returns their greatest common
##'     divisor. Throws an error if any number in v is not a whole number (to within \code{.Machine$double.eps^0.5}).
##'
##' @param v A vector of whole numbers
##' @return Returns a numeric value corresponding to the greatest common divisor of the numbers in v.
##' @export
##' @examples
##' gcd(c(48, 96, 144))
gcd <- function(v) {
    Reduce(gcd0, v)
}
