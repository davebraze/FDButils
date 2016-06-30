##' @title Can Elements Of x Be Interpreted As Whole Numbers?
##'
##' @description Determine whether each element of numerical vector can reasonably be interpreted as a
##'     whole number.
##'
##' @details
##' Takes a numeric vector and returns a Logical vector the same length.
##'
##' @param v A numeric vector.
##' @param tol What counts as close enough to 0? Defaults to .Machine$double.eps^0.5.
##' @return A vector of Logicals.
##' @author Cribbed from example in \code{\link[base]{integer}}
##' @export
isWholeNumber <- function(v, tol = .Machine$double.eps^0.5) {
    abs(v - round(v)) < tol
}

##' @details \code{is.wholenumber()} is deprecated.
##' @rdname isWholeNumber
##' @export
is.wholenumber <- function(v, tol) {
    warning("is.wholenumber() is deprecated. Use isWholeNumber() instead.")
    isWholeNumber(v, tol)
}
