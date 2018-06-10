#' @name getTweetByCategory
#' @title getTweetByCategory
#' @description Get a random set of tweets from the \code{\link{tweet_db}}. 
#' @param category A category to filter the resulting tweets by.  \code{NULL} by default.
#' @param n How many tweets do you want? Defaults to 1, but if you use 'all', it will pull all. 
#' @param tweet_db Either a tweet_db object, or a filepath to such an object.
#' @export
#' @examples 
#' data(tweet_db)
#' getTweetByCategory(category="animals", tweet_db=tweet_db)

getTweetByCategory <- function(category, n=1, tweet_db){
  tweet_db <- loadTweetDB(tweet_db)
 
  res <- tweet_db[tweet_db$category == category,]
  
  if(n=="all"){
    return(res)
  } else{
    res <- tweet_db[sample(nrow(tweet_db), size = n),]
    return(res)
  }
  
}

