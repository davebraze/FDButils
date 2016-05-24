##' @title Logits To Probabilities.
##'
##' @description A wrapper around \code{\link[stats]{plogis}}.
##'
##' @details Convert logit units to probabilities.
##'
##' @param x A vector on the logit scale.
##' @return A vector on on the probability scale.
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @seealso
##' \code{\link[stats]{plogis}}
##' \code{\link[base]{exp}} (for converting logits to odds-ratios)
##' @import stats
##' @export
invLogit <- function(x) {
    stats::plogis(x)
}
