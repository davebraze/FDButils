## TODO: Look into magic::rlatin() as an alternative means to build
## sets of random latin squares.
##
## TODO: Look at package 'crossdes' for better thought out latin
## square designs.

##' @title Create Latin squares.
##'
##' @description Get list of random latin squares.
##'
##' @details Get list of random latin squares. At present, these are not guaranteed to be unique.
##'
##' @param nSquares Number of latin squares to create.
##' @param nDims Size of latin squares.
##' @return A list of latin squares, nSquares in length. Each square is nDims x nDims in size.
##' @author David Braze \email{davebraze@@gmail.com}
##' @seealso \code{\link[magic]{latin}}
##' @export
##' @examples
##' d <- 5
##' ll <- latinList(3,d)
##' ll
##' ll.mat <- Reduce(rbind,ll)
##' cond <- letters[1:d]
##' matrix(cond[ll.mat], ncol=d)
latinList <- function(nSquares=3, nDims=4) {
    if (nSquares%%1!=0) stop(nSquares)
    if (length(nSquares)!=1) stop(nSquares)
    if (nDims%%1!=0) stop(nDims)
    if (length(nDims)!=1) stop(nDims)
    nDims
    set <- rep(nDims, nSquares)
    rv <- lapply(set, magic::latin)  ## generates a list of identical Latin squares
    rv <- lapply(rv, magic::another_latin) ## randomizes each square
    ## TODO: check that each square in the list is unique
    rv
}
