##' @title Strip all non-numeric characters from string formated test scores.
##'
##' @description Remove non-numeric characters from otherwise numeric standardized
##' test scores.
##'
##' @details
##' Remove non-numeric characters that sometimes occur in otherwise numeric standardized
##' test scores. Several characters are handled specially. These four characters "<>+*"
##' are simply removed. The letter "K" is \emph{\strong{replaced}} with "0" (zero). All other non-numeric
##' characters are removed. A count of each type of character removed or replaced is
##' printed to the console.
##'
##' Advantages over \code{\link{readr::parse_number()}} are that it provides
##' explicit alerts as to what characters are being replaced and in what quantity. Useful
##' cases where you are working with unfamiliar data (e.g., client data, or found data).
##'
##' @param c A character vector of potentially numeric values.
##' @return A character vector
##' @export
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @seealso \code{\link{readr::parse_number()}}
##' @examples
##' c <- c("<K.1", "k.8", "2.5", "_4.3", "6.4", "12.9+", "9.2", "10.1", ">12.9")
##' cleanNumbers(c)
##'
cleanNumbers <- function(c) {
    retval <- scrubc(c, re="[<]") ## cleanLessthan(c)
    retval <- scrubc(retval, re="[>]") ## cleanGreaterthan(retval)
    retval <- cleanK(retval)
    retval <- scrubc(retval, re="[*]") ## cleanStar(retval)
    retval <- scrubc(retval, re="[+]") ## cleanPlus(retval)
    retval <- scrubc(retval)
    retval
}

##' @title Replace "K" with "0" (zero).
##'
##' @details
##' \code{cleanK()} replaces "K" and "k" with "0" in grade-equivalent test scores in anticipation of converting to numeric.
##' These sometimes occur in otherwise numeric standardized test scores.
##' Report the number of such characters replace.
##'
##' @param c A character vector of potentially numeric values.
##' @export
##' @noRd
##' @rdname cleanNumbers
##' @examples
##' c = c("<K.1", "K.8", "1.6", "2.1", "3.0", ">12.9")
##' cleanK(c)
##'
cleanK <- function(c) {
    ## change grade level "K" to "0" in anticipation of converting to numeric
    ## I'm assuming there will be no more than 1 per entry
    n <- sum(stringr::str_count(c, "[kK]"), na.rm=TRUE)
    if(n) warning("Converting ", n, " 'K'", " to '0'")
    stringr::str_replace_all(c, "[kK]", "0")
}

##' @title Strip non-numeric characters from string.
##'
##' @description
##' \code{scrubc()} removes non-numeric characters from test scores.
##'
##' @details
##' \code{scrubc()} removes non-numeric characters from test scores,
##' often present due to fat-fingered data entry, in anticipation of converting to numeric.
##' Report the number of such characters removed. Characters to be removed are specified by regular expression (re).
##' The default re is "[^-.0-9]", which will remove all non-numeric characters at one swoop.
##'
##' A typical use case in interactive use is to remove exactly 1 specific character at a time, e.g.,
##' \code{scrubc(c=c("*K.1", "K.8", "1.6", "2.1", "3.0", ">12.9"), re="[>]")}. This serves to alert
##' the analyst to how many of each non-numeric character removed.
##'
##' @param c A character vector of potentially numeric values.
##' @param re A regular expression specifying which characters to remove. For best effect,
##' re should begin with "[" and end with "]" to specify a character set. At some point, I'll add
##' a check to enforce this.
##' @export
##' @@noRd
##' @rdname cleanNumbers
##' @examples
##' c <- c("0.1", "_0.8", "1.6", "2.1`", "+3. 0", "12.9")
##' scrubc(c)
##'
scrubc <- function(c, re="[^-.0-9]") {
    ## TODO: Check to ensure re begins with "[" and ends with "]".
    count <- sum(stringr::str_count(c, re), na.rm=TRUE)
    removed <- stringr::str_extract_all(c, re, simplify=TRUE)
    removed <- as.vector(removed)
    removed <- unique(removed)
    removed <- stringi::stri_remove_empty_na(removed)
    removed <- capture.output(print(removed))
    removed <- stringr::str_remove(removed, "^.1. ")
    if(count) cat(crayon::blue(paste0("Removing ", count, " characters from the set: ", removed, "\n")))
    stringr::str_remove_all(c, re)
}
