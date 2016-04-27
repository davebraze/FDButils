##' @include isWholeNumber.R

##' @title Find Regular Sequences Of Integers In Numeric Vector.
##'
##' @description Find regular sequences of integers in numeric vector v.
##'
##' @details Takes a vector of whole numbers and returns a matrix with 3 columns: (1) integer at
##' beginning of series, (2) index pointing to beginning of series, (3) length of series
##'
##' @param v A numeric vector containing only whole numbers.
##' @param step The step size and direction (distance between adjacent items) for identifying
##'     series. Note that the sign of the step matters. Use positive values for monotonically
##'     increasing series and negative values for monotonically decreasing series. Defaults to
##'     1. Use 0 for invariant series (runs).
##' @param minseries The minimimum series length. Defaults to 2.
##'
##' @return
##' Numeric matrix with 1 row for each series, and three columns indicating:
##'
##' \enumerate{
##'     \item first: Integer at beginning of series.
##'     \item runstart: Index into \code{v} for start of series.
##'     \item runlength: Length of series.
##' }
##'
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
series <- function(v, step=1, minseries=2) {
    if (any(is.na(v))) {
        warning("Missing values removed from v.")
        v <- v[!is.na(v)]
    }
    if (!is.numeric(v)) stop("v must be numeric.")
#    if (!all(sign(v)==1)) stop("v must contain only positive numbers.")
    if (!all(isWholeNumber(v))) stop("v must contain only whole numbers.")
    diffs <- diff(v)
    breaks <- (c(FALSE, diffs==step))
    runstart <- which(!breaks)
    first <- v[runstart]
    runlengths <- diff(c(runstart, length(v)+1))
    retval <- cbind(first, runstart, runlengths)
    retval <- retval[retval[,3]>=minseries,]
    if(!is.matrix(retval)) {
        cnames <- names(retval)
        dim(retval) <- c(1,3)
        colnames(retval) <- cnames
    }
    retval
}

if (FALSE) {
    v1 <- c(2:5, 7:11, 13, 4:9, 11:13, 1:6, 101:105)
    o1 <- series(v1)

    v2 <- v1; v2[3] <- NA
    o2 <- series(v2)

    v3 <- -3:3
    o3 <- series(v3)

    v4 <- v3; v4[4] <- 12
    o4 <- series(v4)

    v5 <- c(rep(1,5), 100, rep(21, 5), 200)
    o5a <- series(v5, step=0)
    o5b <- series(v5)

    v6 <- c(seq(1,20,4), 100, seq(100, 121,3), 200)
    o6a <- series(v6)
    o6b <- series(v6, step=0)
    o6c <- series(v6, step=3)
    o6d <- series(v6, step=4)

    v7 <- 3:-3
    o7a <- series(v7)
    o7b <- series(v7, step=-1)
}

