##' @title Identify potential outliers in a numeric vector.
##'
##' @description Identify potential outliers in a numeric vector.
##'
##' @details Takes a numeric vector, x, and returns a corresponding
##'     logical vector the same length as x. Values of TRUE in return
##'     vector indicate corresponding value in x may be an
##'     outlier. Handy for use with \code{dplyr::mutate()}.
##'
##'     If method is boxplot, then values more than \code{coef} times
##'     the IQR above the 3rd quartile, or more than \code{coef} times
##'     the IQR below the 1st quartile are flagged as possible
##'     outliers.
##'
##'     If method is stdev, then values more than \code{coef} standard
##'     deviations from the mean are flagged as possible outliers.
##'
##'     Both methods are rather simple-minded ways of IDing possible outliers
##'     in the context of a presumed normal distribution.
##'
##' @param x Numeric vector.
##' @param method Method for identifying outliers. Defaults to
##'     "boxplot". Other possibility is "stdev".
##' @param coef Multiplier for determining how extreme a value must be
##'     to be flagged as a potential outlier. Defaults to 1.5 for
##'     boxplot method, indicating 1.5 times the inter-quartile range
##'     from the median, and to 2 for stdev method, indicating 2 times
##'     the standard deviation from the mean.
##' @return Logical vector the same length as x, indicating for each
##'     value in x whether it is a possible outlier as determined by
##'     the specified method and coefficient.
##' @author David Braze \email{davebraze@@gmail.com}
##' @seealso \code{\link[stats]{quantile}}
##' @export
##' @examples
##' set.seed(1234)
##' x <- rt(50, df=2)
##' bp <- boxplot(x)
##' x[outliers(x)]
outliers <- function(x, method=c("boxplot", "stdev"), coef=NULL) {
    method <- match.arg(method, c("boxplot", "stdev"))
    if (method=="boxplot") {
        ## not entirely consistent with graphics::boxplot()
        if (is.null(coef)) coef <- 1.5
        else coef = coef
        q <- quantile(x, c(.25,.75))
        iqr <- diff(q)
        bounds <- c(q[1]-iqr*coef, q[2]+iqr*coef)
    } else if (method=="stdev") {
        if (is.null(coef)) coef <- 2
        else coef = coef
        m <- mean(x, na.rm=TRUE)
        s <- sd(x, na.rm=TRUE)
        bounds <- c(m-s*coef, m+s*coef)
    }
    print(bounds)
    ifelse(x<bounds[1] | x>bounds[2], TRUE, FALSE)
}

