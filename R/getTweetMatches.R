#' @name getTweetMatch
#' @title getTweetByCategory
#' @description Get a random set of tweets from the \code{\link{tweet_db}}. 
#' @param category A category to filter the resulting tweets by.  \code{NULL} by default.
#' @param n How many tweets do you want? Defaults to 1, but if you use 'all', it will pull all. 
#' @param tweet_db Either a tweet_db object, or a filepath to such an object.
#' @export
#' @examples 
#' data(tweet_db)
#' getTweetByCategory(category="animals", tweet_db=tweet_db)

getTweetMatch <- function(schedule_item, tweet_db){
  tweet_db <- loadTweetDB(tweet_db)
 
  if(!is.na(schedule_item$id)){
    tweet <- getTweetByID(schedule_item$id, tweet_db = tweet_db)
    return(tweet)
  }
  
  if(!is.na(schedule_item$category)){
    tweet <- getTweetByCategory(schedule_item$category, n=1, tweet_db = tweet_db)
    return(tweet)
  }

  
}

