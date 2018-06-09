
#' @description A top level function usually called by cron and a command-line-interface. 
#' @inheritParams tweet_db
#' @inheritParams schedule
checkScheduleAndPost <- function(schedule, tweet_db=NULL){
  
  matched_items <- scheduleCheck(schedule, 3)
  
  if(nrow(matched_items) > 0){
    apply(matched_items, 1, postMatchedTweets, tweet_db=tweet_db)
  }
  
}
