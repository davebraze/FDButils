##' @title For N points, in M dimensions, get squared Mahalanobis distances
##'     to centroid.
##'
##' @details For each of N points in M dimensions, get squared Mahalanobis
##'     distances to distribution centroid. This is useful for checking for
##'     outliers in a multivariate distribution. The squared Mahalanobis
##'     distances to center for an MV normal distribution with N dimensions
##'     will follow the chi square distribution with DF equal to N.
##'
##'     This function is a convenience wrapper around
##'     \code{\link[stats]{mahalanobis}}, which see. Variables are
##'     optionally scaled before distances are computed. Incomplete
##'     observations will return NA.
##'
##' @param m A data.frame or matrix. Observations in rows.
##' @param scale If TRUE, scale variables before getting mahalanobis
##'     distances.
##' @param use Observations to use in computing covariance matrix. Gets
##'     passed to \code{\link[stats]{cov}}.
##' @param center Type of univariate center for each variable in \code{m};
##'     "mean" or "median"
##' @param ... additional arguments passed to
##'     \code{\link[stats]{mahalanobis}}, and possibly on to
##'     \code{\link[stats]{solve}}.
##' @return
##'     A list with additional class "mahalDist" containing elements:
##'
##'     \enumerate{
##'
##'             \item{
##'                     D2: A vector of squared Mahalanobis distances for
##'                     observations (rows) in \code{m}.  Incomplete observations return
##'                     NA.
##'             }
##'
##'             \item{
##'                     vars: A character vector with the column names from
##'                     \code{m}.
##'             }
##'
##'             \item{
##'                     dim: The number of columns of \code{m}.
##'             }
##'     }
##'
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @seealso \code{\link[stats]{mahalanobis}}
##' @seealso \code{\link[stats]{cov}}
##' @seealso \code{\link[stats]{solve}}
##' @examples
##' m <- matrix(runif(80), nrow=10)
##' md <- mahalDist(m)
##'
##'
##' @export
mahalDistC <- function(m,
                      scale=TRUE,
                      use="complete.obs",
                      center="mean",
                      ...) {
    stopifnot(length(dim(m))==2,
              (center=="mean"|center=="median"))
    m <- as.matrix(m)
    if (scale) m <- apply(m,2,scale)
    if ("mean"==center) c <- apply(m, 2, mean, na.rm=TRUE)
    if ("median"==center) c <- apply(m, 2, median, na.rm=TRUE)
    print(c)
    S <- cov(m, use=use)
    D2 <- stats::mahalanobis(x=m,center=c,cov=S, ...)
    vars <- colnames(m)
    dim <- dim(m)[2]
    retval <- list(D2=D2, vars=vars, dim=dim)
    class(retval) <- c("mahalDist", class(retval))
    retval
}

if (FALSE){
    m <- matrix(rnorm(800), nrow=10)
    md <- mahalDist(m)
    hist(md$D2)
    rug(md$D2)

}
