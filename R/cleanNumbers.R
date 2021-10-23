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
    retval <- cleanLessthan(c)
    retval <- cleanGreaterthan(retval)
    retval <- cleanK(retval)
    retval <- cleanStar(retval)
    retval <- cleanPlus(retval)
    retval <- cleanCruft(retval)
    retval
}

##' @title Remove "<" from string.
##'
##' @details
##' \code{cleanLessthan()} removes "<" from ordinal values at end of range in anticipation of converting to numeric.
##' These sometimes occur in otherwise numeric standardized test scores.
##' Report the number of such characters removed.
##'
##' @param c A character vector of potentially numeric values.
##' @export
##' @noRd
##' @rdname cleanNumbers
##' @examples
##' c = c("<1", "1", "2", "3")
##' cleanLessthan(c)
##'
cleanLessthan <- function(c) {
    ## maybe add an option to decrement values expressed with "<"
    n <- sum(stringr::str_count(c, "<"), na.rm=TRUE)
    if(n) warning("Removing ", n, " '<'")
    stringr::str_remove_all(c, "<")
}

##' @title Remove ">" from string.
##'
##' @details
##' \code{cleanGreaterthan()} removes ">" from ordinal values at end of range in anticipation of converting to numeric.
##' These sometimes occur in otherwise numeric standardized test scores.
##' Report the number of such characters removed.
##'
##' @param c A character vector of potentially numeric values.
##' @export
##' @noRd
##' @rdname cleanNumbers
##' @examples
##' c = c("1", "1", "2", ">3")
##' cleanGreaterthan(c)
##'
cleanGreaterthan <- function(c) {
    ## remove ">" from ordinal values at end of range in anticipation of converting to numeric
    ## I'm assuming there will be no more than 1 per entry
    ## maybe add an option to increment values expressed with ">"
    n <- sum(stringr::str_count(c, ">"), na.rm=TRUE)
    if(n) warning("Removing ", n, " '>'")
    stringr::str_remove_all(c, ">")
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

##' @title Remove "*" from string.
##'
##' @details
##' \code{cleanStar()} removes "*" from ordinal values in anticipation of converting to numeric.
##' These sometimes occur in otherwise numeric standardized test scores.
##' Report the number of such characters removed.
##'
##' @param c A character vector of potentially numeric values.
##' @export
##' @noRd
##' @rdname cleanNumbers
##' @examples
##' c = c("*K.1", "K.8", "1.6", "2.1", "3.0", ">12.9")
##' cleanStar(c)
##'
cleanStar <- function(c) {
    ## remove "*" that occur sometimes with otherwise numeric values
    ## I'm assuming there will be no more than 1 per entry.
    n <- sum(stringr::str_count(c, "[*]"), na.rm=TRUE)
    if(n) warning("Removing ", n, " '*'")
    stringr::str_remove_all(c, "[*]")
}

##' @title Remove "+" from string.
##'
##' @details
##' \code{cleanPlus()} removes "+" from ordinal values at end of range in anticipation of converting to numeric.
##' These sometimes occur in otherwise numeric standardized test scores.
##' Report the number of such characters removed.
##'
##' @param c A character vector of potentially numeric values.
##' @export
##' @noRd
##' @rdname cleanNumbers
##' @examples
##' c = c("*K.1", "K.8", "1.6", "2.1", "3.0", "12.9+")
##' cleanPlus(c)
##'
cleanPlus <- function (c) {
    ## remove "+" that occur sometimes with otherwise numeric values
    ## I'm assuming there will be no more than 1 per entry.
    n <- sum(stringr::str_count(c, "[+]"), na.rm=TRUE)
    if(n) warning("Removing ", n, " '+'")
    stringr::str_remove_all(c, "[+]")
}

##' @title Strip all non-numeric characters from string.
##'
##' @details
##' \code{cleanCruft()} removes residual non-numeric characters from test scores,
##' often present due to fat-fingered data entry, in anticipation of converting to numeric.
##' Report the number of such characters removed.
##'
##' @param c A character vector of potentially numeric values.
##' @export
##' @noRd
##' @rdname cleanNumbers
##' @examples
##' c = c("0.1", "_0.8", "1.6", "2.1`", "+3. 0", "12.9")
##' cleanCruft(c)
##'
cleanCruft <- function (c) {
    count <- sum(stringr::str_count(c, "[^-.0-9]"), na.rm=TRUE)
    cruft <- stringr::str_extract_all(c, "[^-.0-9]", simplify=TRUE)
    cruft <- as.vector(cruft)
    cruft <- stringi::stri_remove_empty_na(cruft)
    cruft <- capture.output(print(cruft))
    cruft <- stringr::str_remove(cruft, "^.1. ")
    if(count) warning("Removing ", count, " characters from the set: ", cruft)
    stringr::str_remove_all(c, "[^-.0-9]")
}
