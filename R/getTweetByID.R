
#' Title
#' @inheritParams tweet_db
#' @return A single row of a tweet_db.
#' @export
#'
#' @examples
#' 

getTweetByID <- function(id, tweet_db=NULL){
  tweet_db <- loadTweetDB(tweet_db)
  
  res <- tweet_db[tweet_db$id == id,]
  
  return(res)
}

