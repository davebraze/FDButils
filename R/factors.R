##' @title Coerce Factor Vector to Numeric Preserving Levels.
##'
##' @description Coerce a vector of class "factor" to numeric.
##'
##' @details
##' Coerces a vector of class factor to numeric. This function preserves underlying integer
##' associated with each element of f.
##'
##' cf. > unclass(f)
##'
##' @param f A vector of class "factor".
##' @return A vector of class "numeric".
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @seealso
##' \code{\link{fact2char}}
##' \code{\link{as.numeric}}
##' @export
fact2num <- function(f) {
    as.numeric(f)
}

##' @title Coerce Factor Vector to Character Preserving Labels.
##'
##' @description Coerce a vector of class "factor" to character.
##'
##' @details
##' Coerces a vector of class factor to numeric. This function preserves level labels associated
##' with each element of f.
##'
##' cf. > unclass(f)
##'
##' @param f A vector of class factor.
##' @return A vector of class "character".
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @seealso
##' \code{\link{fact2num}}
##' \code{\link{as.character}}
##' @export
fact2char <- function(f) {
    as.character(f)
}

##' @title Reorder factor levels.
##'
##' @description None yet.
##'
##' @details Reorders the levels of factor f as specified in new.order, which must contain all and
##' only the existing levels of f (including unused levels), but in the desired order. If new.order
##' and levels(f) do not contain exactly the same elements, then do nothing.
##'
##' @param f A factor.
##' @param new.order A character vector containing all and only the levels of f, in the desired order.
##' @return A factor.
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @seealso
##' \code{\link{factor}}
##' \code{\link{levels}}
##' \code{\link[stats]{relevel}}
##' @export
levelOrder <- function(f, new.order) {
    stopifnot(all(levels(f) %in% new.order) & all(new.order %in% levels(f)))
    retval <- factor(f, levels = new.order)
    retval
}
