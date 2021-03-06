% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_dist_parms.R
\name{get_dist_parms}
\alias{get_dist_parms}
\title{Get distribution parameters}
\usage{
get_dist_parms(data, distribution_type)
}
\arguments{
\item{data}{Numeric vector}

\item{distribution_type}{Character.
One of either "normal", "lognormal", or "beta"}
}
\description{
Internal helper function for
calculating parametric distribution parameters.
}
\note{
This function will first try fitting using mme, then mle
}
\keyword{internal}
