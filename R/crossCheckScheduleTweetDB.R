#' @name crossCheckScheduleTweetDB
#' @title crossCheckScheduleTweetDB
#' @description Cross-checks a \code{\link{schedule}} against a \code{\link{tweetdb}} to ensure no missing entries in either object. 
#' @inheritParams tweet_db
#' @inheritParams validateSchedule
#' @export
#' @examples 
#' data(tweetdb)
#' data(schedule)
#' crossCheckScheduleTweetDB(schedule, tweet_db)

crossCheckScheduleTweetDB <- function(schedule, tweet_db){
  
  # category matches
  ## check that every category entry in schedule has a corresponding value in tweet_deb
  ## check that every category entry in tweetdb has at least one corresponding value in schedule
  
}


