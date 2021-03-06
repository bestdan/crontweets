% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getTweetByID.R
\name{getTweetByID}
\alias{getTweetByID}
\title{getTweetByID}
\usage{
getTweetByID(id, tweet_db)
}
\arguments{
\item{id}{An automatically generated unique identifier in your \code{\link{tweet_db}}, as generated by \code{\link{addNewTweetToDB}}.}

\item{tweet_db}{Either an in-memory \code{\link{tweet_db}} object, or a file path to one. This is
a convenience function which sits inside other functions just to parse path vs object.}
}
\value{
A single row of a tweet_db.
}
\description{
Get a specific tweet by it's unique identifier.
}
\examples{
data("tweetdb")
getTweetByID("3aef9b07818ba871e5db6eebd5c5b77f46eea04d", tweet_db = tweet_db)
}
