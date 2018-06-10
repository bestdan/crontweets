#' @title checkScheduleAndPost
#' @name checkScheduleAndPost
#' @description A top level function usually called by cron and a command-line-interface. 
#' @inheritParams loadTweetDB
#' @inheritParams checkSchedule
#' @export
#' @examples 
#' data(tweet_db)
#' data(schedule)
#' checkScheduleAndPost(schedule, tweet_db)

checkScheduleAndPost <- function(schedule, tweet_db=NULL, minute_range = NULL, now=NULL){
  
  matched_items <- checkSchedule(schedule,
                                 minute_range =  minute_range, 
                                 now = now)
  
  if(nrow(matched_items) > 0){
    message(paste0("Posting ", nrow(matched_items), " tweets."))
    
    results <- apply(matched_items, MARGIN = 1, 
                     FUN = getTweetMatch, 
                      tweet_db=tweet_db)
    
    lapply(results, 
           postTweet, 
           tweet_db=tweet_db)
    
    return(results)
  } else {
    message("No scheduled content.")
    return(NULL)
  }

  
}
