##' @title Inverse Box-Cox Transformation.
##'
##' @description None yet.
##'
##' @details
##' Compute the inverse Box-Cox transformation of a variable. Requires arguments x and lambda.
##'
##' @param x A numerical vector.
##' @param lambda Lambda to use for the inverse Box-Cox transform.
##' @return a numerical vector
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @seealso \code{\link[car]{bcPower}}
##' @seealso \code{\link[car]{powerTransform}}
##' @export
invBoxCox <- function(x, lambda) {
    if (0 == lambda) retval <- exp(x)
    else retval = (x*lambda + 1)^(1/lambda)
    retval
}
