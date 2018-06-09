#' @title loadTweetDB
#' @description Loads
#' @param tweet_db Either an in-memory \code{\link{tweet_db}} object, or a file path to one. This is
#'   a convenience function which sits inside other functions just to parse path vs object.
#' @return A tweet_db object
#' @export
#'
#' @examples
#' loadTweetDB()

loadTweetDB <- function(tweet_db){
  if(!class(tweet_db) %in% c("data.frame", "character")) stop("tweet_db must be either data.frame, or file path.")
  if(class(tweet_db)=="character"){
    load(tweed_db)
  } 
  return(tweet_db)
}
