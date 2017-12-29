##' @title Get a human readable timestamp as string.
##'
##' @description
##' Return a human readable timestamp as a string: 'YYYYMMDD-HHMMSS'.
##'
##' @details
##' Convenience function to get a human readable timestamp string: 'YYYYMMDD-HHMMSS'.
##' This is mostly useful for including in filenames.
##'
##' @return A string corresponding to a human readable timestamp: 'YYYYMMDD-HHMMSS'.
##' @author David Braze \email{davebraze@@gmail.com}
##' @export
##' @examples
##' timestamp()
timestamp <- function() {
    format(Sys.time(), "%Y%m%d-%H%M%OS")
}
