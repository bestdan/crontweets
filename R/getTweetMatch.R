#' @name getTweetMatch
#' @title getTweetmatch
#' @description Get tweets that match a category or id. 
#' @inheritParams filterSchedule
#' @inheritParams loadTweetDB
#' @export
#' @examples 
#' data(tweet_db)
#' data(schedule)
#' getTweetMatch(schedule[1,], tweet_db=tweet_db)

getTweetMatch <- function(schedule_item, tweet_db){
  schedule_item <- as.list(schedule_item)
  validateSchedule(schedule_item)
  
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

