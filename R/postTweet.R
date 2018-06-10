#' @name postTweet
#' @title postTweet
#' @description Posts a tweet after parsing the media path.
#' @param tweetx A specific tweet as a list object, with items as in \code{\link{tweet_db}}.
#' @param ... Optional arguments for \code{\link[twitteR]{tweet}}.
#' @export
#' @importFrom twitteR tweet
#' @examples 
#' \dontrun{
#' data(tweet_db)
#' postTweet(as.list(tweet_db[1,]))
#' }

postTweet <- function(tweetx, ...){
  
  if(!is.null(tweetx$mediaPath)){
    twitteR::tweet(text       = tweetx$tweet_text, 
                   mediaPath  = tweetx$media_path, 
                   ...)  
  }
  
  if(is.null(tweetx$mediaPath)){
    twitteR::tweet(text = tweetx$tweet_text, 
                   ...)  
  }
  return(NULL)
}
