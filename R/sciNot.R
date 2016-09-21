##' @title Convert numeric vector to character in scientific notation.
##'
##' @description Convert numeric vector to character in scientific notation.
##'
##' @details Takes a numeric vector, x, and returns a corresponding
##'     character vector the same length as x. Elements of the return
##'     vector are representations of corresponding elements of x in
##'     scientific notation. This is handy for use with 'labels'
##'     argument to ggplot2:: 'scales' functions:
##'
##'     scales_x_log10(labels=sciNot)
##'
##' @param x Numeric vector.
##' @return Character vector the same length as x, containing
##'     representation in scientific notation of each element in x.
##' @author David Braze \email{davebraze@@gmail.com}
##' @seealso
##' \code{\link[ggplot2]{scale_continuous}}
##' @export
sciNot <- function(x){
    if(is.numeric(x)){
        format(x, scientific=TRUE)
    }else{
        stop("x must be numeric")
    }
}
