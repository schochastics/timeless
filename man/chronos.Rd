% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chronos.R
\name{chronos}
\alias{chronos}
\title{Fast general purpose parser for date(time) from input data}
\usage{
chronos(x, formats = NULL, tz = "", to_tz = "", out_format = "datetime")
}
\arguments{
\item{x}{A vector with date(time) expressions to be parsed and converted.}

\item{formats}{character vector of formats to try out (see \link[base:strptime]{base::strptime}).
If NULL, uses a set of predefined formats mostly taken from the anytime package.}

\item{tz}{assumed input timezone. If "", uses local timezone. See details}

\item{to_tz}{convert datetime to timezone given in to_tz. If "", tz is used.
See details}

\item{out_format}{character. Defining the format of the returned result.
Can be "datetime", "date", or "character".}
}
\value{
A character vector which can be transformed to \code{POSIXct} or date
}
\description{
Fast general purpose parser for date(time) from input data
}
\details{
The internal parsing is done "timezoneless". The timezone given in
tz is just added to the datetime without any conversion. If to_tz is given, a
conversion is made from tz to to_tz.
}
\examples{
chronos(bench_date)
}
\seealso{
\link{parse_datetime}, \link{parse_date}, and \link{parse_epoch} if you need more control over formatting
}
