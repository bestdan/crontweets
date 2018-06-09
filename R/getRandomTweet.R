#' @name getRandomTweetFromCategory
#' @description Get a random set of tweets from the \code{\link{tweet_db}}. 
#' @param category A category to filter the resulting tweets by.  \code{NULL} by default.
#' @param tweet_db Either a tweet_db object, or a filepath to such an object.
#' @importFrom here here 
#' @export
#' @examples 
#' res<- getRandomTweets(search_text="#BeFiFails")

getRandomTweetFromCategory <- function(category, tweet_db=NULL){
  tweet_db <- loadTweetDB()
 
  res <- tweet_db[tweet_db$category == category,]
  res <- sample(x = tweet_db[tweet_db$category == category,],1)

  return(res)
}


getTweetByID <- function(id, tweet_db=NULL){
  tweet_db <- loadTweetDB()
  
  res <- tweet_db[tweet_db$id == id,]
  
  return(res)
}

loadTweetDB <- function(tweet_db){
  if(!class(tweet_db) %in% c("data.frame", "character")) stop("tweet_db must be either data.frame, or file path.")
  if(class(tweet_db)=="character"){
    load(tweed_db)
  } 
  return(tweet_db)
}
