% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/schedule.R
\docType{data}
\name{schedule}
\alias{schedule}
\title{schedule}
\arguments{
\item{minute}{The minute to be posted, or NA for wildcard.}

\item{hour}{The hour to be posted, or NA for wildcard.}

\item{dow}{The day of the week, 0 to 6, starting on Sunday, as per POSIXlt. Should probably add input validation.}

\item{tz}{The timezone in which the schedule should be run.}
}
\description{
An R object which holds a cron-like schedule of content you want to tweet. NAs are wildcards.
}
\examples{
data(schedule)
schedule
}
