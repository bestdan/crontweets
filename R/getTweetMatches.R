#' @name getTweetMatch
#' @title getTweetByCategory
#' @description Get a random set of tweets from the \code{\link{tweet_db}}. 
#' @inheritParams filterSchedule
#' @inheritParams loadTweetDB
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

