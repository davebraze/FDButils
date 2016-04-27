##' @title Can Character Vector Be Coerced To Numeric?
##'
##' @description None yet.
##'
##' @details
##' Checks element-wise as to whether each item in a vector of strings can be coerced to numeric.
##'
##' Basics cribbed from \url{http://rosettacode.org/wiki/Determine_if_a_string_is_numeric#R}
##' @param c A vector of strings.
##' @return A vector of logicals, NA where \code{is.na(c)}.
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
##' @examples
##' x <- c('a', 'IX', 'twelve', '0001', '2', '3e1', '-4', '5.5', 'Inf', NA)
##' data.frame(x,
##'            isNumeral(x),
##'            as.numeric(x))
isNumeral <- function(c) {
    retval <- suppressWarnings(!is.na(as.numeric(c)))
    retval[is.na(c)] <- NA
    retval
}

##' @details \code{is.numeral()} is deprecated.
##' @rdname isNumeral
##' @export
is.numeral <- function(c) {
    warning("is.numeral() is deprecated. Use isNumeral() instead.")
    isNumeral(c)
}


