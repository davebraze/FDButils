##' @title Get the greatest common divisor.
##'
##' @description gcd0() Takes two whole numbers as arguments and returns their greatest common divisor.
##'
##' @details gcd0() Takes two whole numbers as arguments and returns their greatest common divisor. Throws
##'     an error if either number is not a whole number.
##'
##' @param a A whole number
##' @param b A whole number
##' @return gcd0() returns the greatest common divisor of a and b.
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
##' @rdname gcd
##' @examples
##' gcd0(36, 48)
##' gcd0(-36, 48)
gcd0 <- function(a,b) {
    if (!(isWholeNumber(a) && isWholeNumber(b))) stop("gcd0() is defined over whole numbers only.")
    a <- abs(a); b <- abs(b)
    if (a>b) ss <- b
    else ss <-  a
    for (ii in 1:ss) {
        if((a %% ii == 0) && (b %% ii == 0)) retval <- ii
    }
    retval
}

##' @title Get the greatest common divisor.
##'
##' @description gcd() takes a vector of whole numbers and returns their greatest common divisor.
##'
##' @details gcd() takes a vector, v, of whole numbers as argument and returns their greatest common
##'     divisor. Throws an error if any number in v is not a whole number.
##'
##' @param v A vector of whole numbers
##' @return gcd() returns the greatest common divisor of the numbers in v.
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
##' @examples
##' gcd(c(48, 96, 144))
gcd <- function(v) {
    Reduce(gcd0, v)
}
