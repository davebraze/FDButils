##' @title Positive Inverse Of The Normal Density Function.
##'
##' @description Normal density function is not fully invertible. This function returns the positive
##'     inverse.
##'
##' @details
##' Cribbed from <http://stackoverflow.com/questions/19589191/the-reverse-inverse-of-the-normal-distribution-function-in-r>
##' @param x A numeric vector.
##' @return A vector the same length as x.
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @export
##' @examples
##' x <- seq(-4, 4, .1)
##' y <- dnorm(x)
##' plot(x,y)
##' points(invDnorm(y), y, pch=3, col="blue")
invDnorm <- function(x) {
    sqrt(-2 * log(sqrt(2 * pi) * x))
}

##' @details
##' \code{inv_dnorm()} is deprecated.
##' @rdname invDnorm
##' @export
inv_dnorm <- function(x) {
    warning("inv_dnorm() is deprecated. Use invDnorm() instead.")
    invDnorm(x)
}
