#' @title checkScheduleAndPost
#' @name checkScheduleAndPost
#' @description A top level function usually called by cron and a command-line-interface. 
#' @inheritParams loadTweetDB
#' @inheritParams validateSchedule
#' @export
#' @examples 
#' data(tweet_db)
#' data(schedule)
#' checkScheduleAndPost(schedule, tweet_db)

checkScheduleAndPost <- function(schedule, tweet_db=NULL){
  
  matched_items <- checkSchedule(schedule, 3)
  
  if(nrow(matched_items) > 0){
    message(paste0("Posting ", nrow(matched_items), " tweets."))
    
    results <- lapply(matched_items, 1, getTweetMatch, tweet_db=tweet_db)
    lapply(matched_items, 1, postTweet, tweet_db=tweet_db)
  } else {
    message("No scheduled content.")
  }

  
}
