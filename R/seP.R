##' @title Standard Error of a Proportion.
##'
##' @description None yet.
##'
##' @details
##' Returns the standard error of the proportion of 1s in a vector of 1s and 0s. The vector must
##' contain only 1s and 0s. Missing values are silently dropped. If x is a matrix or data.frame then
##' seP is applied column-wise and a vector of values is returned.
##'
##' @include nobs.R
##' @param x A vector containing only 1s and 0s. NAs are silently dropped.
##' @return The standard error of a proportion.
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
seP <- function(x) {
    x <- x[!is.na(x)]
    if(!all(x %in% 0:1)) {
        print("x must consist of 1s and 0s only.")
        stop()
    }
    if (is.matrix(x)) {
        apply(x, 2, seP)
    } else if (is.vector(x)) {
        sqrt((mean(x) / (1-mean(x))) / nobs(x))
    } else if (is.data.frame(x)) {
        sapply(x, seP)
    } else {
        seP(as.vector(x))
    }
}
