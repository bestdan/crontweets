% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getTweetMatch.R
\name{getTweetMatch}
\alias{getTweetMatch}
\title{getTweetmatch}
\usage{
getTweetMatch(schedule_item, tweet_db)
}
\arguments{
\item{schedule_item}{A single row of a \code{\link{schedule}}.}

\item{tweet_db}{Either an in-memory \code{\link{tweet_db}} object, or a file path to one. This is
a convenience function which sits inside other functions just to parse path vs object.}
}
\description{
Get tweets that match a category or id.
}
\examples{
data(tweet_db)
data(schedule)
getTweetMatch(schedule[1,, drop=FALSE], tweet_db=tweet_db)
}
