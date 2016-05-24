##' @title Standard Error Of The Mean.
##'
##' @description Compute standard error of the mean of x.
##'
##' @details
##' Returns the standard error of the mean of x, which can be either a vector, matrix or data.frame.
##' In the latter two cases, SEM is computed column-wise and a vector of values is returned. When x is
##' a vector, a single value is returned.
##'
##' @include nobs.R
##' @param x Object to compute SEMs for. Can be vector, matrix or data.frame.
##' @param na.rm Specify how to handle missing values.
##' @return Standard error of the mean for x, or each column of x.
##' @author David Braze \email{davebraze@@gmail.com}
##' @aliases se seM
##' @import stats
##' @export
se <-
    function(x, na.rm=FALSE) {
        if (is.matrix(x)) {
            apply(x, 2, se, na.rm = na.rm)
        } else if (is.vector(x)) {
            stats::sd(x, na.rm = na.rm)/sqrt(nobs(x))
        } else if (is.data.frame(x)) {
            sapply(x, se, na.rm = na.rm)
        } else {
            se(as.vector(x), na.rm=na.rm)
        }
    }


##' @export
##' @rdname se
seM <- se
