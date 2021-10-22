##' @title Open file browser in working directory.
##'
##' @description Open a file browser in the current working directory, on MS Windows only.
##'
##' @details openwd() opens a file browser in the current working directory. Currently it works on on MS Windows only. Does nothing but issues a warning on other platforms.
##'
##' @return
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @export
##' @examples
##' openwd()
##'
openwd <- function () {
    info <- sessionInfo()
    if (grepl('win', info$running, ignore.case = TRUE)) {
    suppressWarnings(shell(paste("explorer", gsub("/", "\\\\",
                                                  getwd()))))
    } else {
        stop("Only MS Windows is currently supported.")
    }
}
