#' @title getTweetByID
#' @name  getTweetByID
#' @description Get a specific tweet by it's unique identifier. 
#' @inheritParams tweet_db
#' @inheritParams loadTweetDB
#' @return A single row of a tweet_db.
#' @export
#'
#' @examples
#' data("tweetdb")
#' getTweetByID("3aef9b07818ba871e5db6eebd5c5b77f46eea04d", tweet_db = tweet_db)

getTweetByID <- function(id, tweet_db){
  tweet_db <- loadTweetDB(tweet_db)
  
  res <- tweet_db[tweet_db$id == id,]
  
  return(res)
}

