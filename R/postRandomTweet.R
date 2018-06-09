#' @name postRandomTweet 
#' @description Posts a random tweet from a category (optional) to twitter
#' @inheritParams tweet_db
#' @note ToDo: prevent from re-posting same previous tweet?
#' @export
#' @examples 
#' \dontrun{
#' postRandomTweet()
#' }

postRandomTweet <- function(category=NULL, id = NULL, tweet_db=NULL){
  result <- getRandomTweetFromCategory(category = category, tweet_db = tweet_db)
  twitteR::tweet(result, bypassCharLimit=TRUE)
  return(result)
}