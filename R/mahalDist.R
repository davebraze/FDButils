##' @title Get squared Mahalanobis distances to centroid.
##'
##' @description For N points, in M dimensions, get squared Mahalanobis
##'     distances to center.
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
##'     \code{\link[base]{solve}}.
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
##' @seealso \code{\link[base]{solve}}
##' @examples
##' m <- matrix(rnorm(400, m=.8, s=.05), nrow=100)
##' md <- mahalDistC(m)
##' md$D2
##' hist(md$D2)
##' rug(md$D2)
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

##' @title Get pairwise squared Mahalanobis distances.
##'
##' @description For N points, in M dimensions, get pairwise squared
##'     Mahalanobis distances between points. Return a square matrix of
##'     distances.
##'
##' @details For each pair of N points in M dimensions, get pairwise
##'     squared Mahalanobis distances between points. Returns an
##'     object, \code{d}, of class "dist" (see
##'     \code{\link[stats]{dist}}) containing pairwise squared
##'     Mahalanobis distances for all points in m. The method
##'     attribute of \code{d} is set to "mahalanobis". Obviously,
##'     \code{d} can get big for large N.
##'
##'     The full symmetric distance matrix for d can be recovered by
##'     calling \code{as.matrix(d)}.
##'
##'     This function is a convenience wrapper around
##'     \code{\link[stats]{mahalanobis}}, which see.
##'
##' @param m A matrix with observations in rows.
##' @param covar The covariance matrix for m.
##' @param ... Not used.
##' @return An object of class "dist" (see \code{\link[stats]{dist}})
##'     containing pairwise squared Mahalanobis distances for all
##'     points in m.
##' @author Dave Braze \email{davebraze@@gmail.com}
##' @seealso \code{\link[stats]{mahalanobis}}
##' @seealso \code{\link[stats]{cov}}
##' @seealso \code{\link[base]{solve}}
##' @seealso \code{\link[stats]{dist}}
##' @examples
##' m <- matrix(rnorm(200, m=.8, s=.05), nrow=50)
##' md <- mahalDistP(m)
##' cluster <- hclust(md)
##' plot(cluster)
##'
##' @export
mahalDistP <- function(m, covar = NULL, ...) {
    if(is.null(covar)) covar <- cov(m)
    rows <- 1:nrow(m)
    retval <- lapply(rows, function(row) {
        stats::mahalanobis(x = m,
                    center = m[row, ],
                    cov = covar)
    })
    retval <- do.call("rbind", retval)
    retval <- dist(retval)
    attr(retval, "method") <- "mahalanobis"
    retval
}
