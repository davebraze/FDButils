##' @title Get the sample mode of a vector or matrix.
##'
##' @description Return the most common value in a sample or, for numerix x with no duplicate
##'     values, return the maximum density estimate.
##'
##' @details Returns the mode (most common value) of a vector or matrix or, for numerix x with no
##'     duplicate values, return the maximum density estimate. For non-numeric x with no duplicates
##'     return NA. When there is more than 1 mode, return the one whose value occurs first in x.
##'
##' @param x A vector or matrix.
##' @return A single value corresponding to the most common value in x.
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
##' @examples
##' x0 <- c(1:10, 3,3,2)
##' sampleMode(x0)
##'
##' x1 <- sample(letters, 200)
sampleMode <- function(x, na.rm=FALSE) {
    if(na.rm){
        x <- x[!is.na(x)]
    }
    if ("matrix" == class(x)) {
        x <- as.vector(x)
        }
    u <- unique(x)
    if (length(u) == length(x)) {
        warn <- "WARNING: No value occurs more than once!"
        if(is.numeric(x)) {
            warn <- paste(warn, "Returning maximum density estimate for numeric x.")
            d <- density(x)
            mode <- d$x[which.max(d$y)]
        } else {
            warn <- paste(warn, "Returning NA.")
            mode <- NA
        }
        warning(warn)
    } else {
        mode <- u[which.max(tabulate(match(x, u)))]
    }
    mode
}
