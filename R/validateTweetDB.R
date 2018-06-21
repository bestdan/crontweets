#' @name validateTweetDB
#' @title validateTweetDB
#' @description Validate that all entries in a \code{\link{tweetdb}} object are ok. 
#' @inheritParams validateSchedule
#' @inheritParams tweet_db
#' @export
#' @examples 
#' data(tweetdb)
#' validateTweetDB(tweetdb)


validateTweetDB <- function(tweet_db){
  
  valid_names <- c("tweet_text", "category", "media_path", "id")
  
  namecheck <- sort(names(schedule)) == sort(valid_names)
  
  if(any(!namecheck)){
    stop("tweet_db must have column names ", paste0(valid_names, collapse = ", "))
  }
  
  # Every entry should have a category
  category_failures_length <- which(sapply(tweet_db$category, nchar) < 1)
  category_failures_na <- which(is.na(tweet_db$category))
  category_failures <- union(category_failures_length, category_failures_na)
  
  if(length(category_failures) > 0){
    stop(paste0("All tweets must have a category entry. These rows fail: ", 
                paste(dow_failures, collapse = ",")))
  }
  
  
  
}



