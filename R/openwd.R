##' @title
##' Open file browser in working directory.
##'
##' @description
##' Open a file browser in the current working directory, on MS Windows only.
##'
##' @details
##' \code{openwd()} opens a standard file browser in the current working directory.
##' Currently it works on on MS Windows only. Does nothing but issues a
##' warning on other platforms.
##'
##' @return TRUE if successful, FALSE otherwise.
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @export
##' @examples
##' openwd()
openwd <- function () {
    info <- utils::sessionInfo()
    if (grepl('win', info$running, ignore.case = TRUE)) {
        suppressWarnings(shell(paste("explorer", gsub("/", "\\\\",
                                                      getwd()))))
        invisible(TRUE)
    } else {
        cat("Only MS Windows is currently supported.\n")
        invisible(FALSE)
    }
}
