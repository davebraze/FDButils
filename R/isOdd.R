##' @title Are Elements Of x Even Numbers?
##'
##' @description Return TRUE if n is an integer evenly divisibly by 2.
##'
##' @details
##' Test whether elements of a numeric vector are even. For whole numbers return TRUE or FALSE. For decimals return NA.
##'
##' @param n A numeric vector.
##' @return A logical vector the same length as n. TRUE if n is an integer and is even, FALSE if n
##' is an integer and not even, NA otherwise.
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
##' @examples
##' n <- 1:10
##' isEven(n)
##'
##' m <- seq(1, 10, .5)
##' isEven(m)
isEven <- function (n)
{
    n[n %% 1 != 0] <- NA
    retval <- n %% 2 == 0
    retval
}

##' @title Are elements of x odd numbers?
##'
##' @description Return TRUE if n is an integer that is not evenly divisible by 2.
##'
##' @details
##' Test whether elements of numeric vector are odd. For whole numbers return TRUE or FALSE. For decimals return NA.
##'
##' @param n A numeric vector.
##' @return A logical vector the same length as n. TRUE if n is an integer and is even, FALSE if n
##' is an integer and not even, NA otherwise.
##' @export
isOdd <-
    function(n) {
        !isEven(n)
    }
