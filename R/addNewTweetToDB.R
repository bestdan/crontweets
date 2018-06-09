#' @name addNewTweetToDB 
#' @description Add a new tweet to the \code{\link{tweet_db}}. If inputs are not specified, it will ask in the console for input. Automatically creats unique identifier.
#' @param tweet_text The text of the tweet.
#' @param category A category to assign the tweet to. 
#' @param media_path A file-path to a picture or something you want to share. 
#' @param tweet_db Allows you to pass an in-memory database in to continue building it out. 
#' @export
#' @importFrom digest sha1
#' @examples 
#' addNewTweetToDB("TestTweet", category="test")


addNewTweetToDB <- function(tweet_text=NULL, category=NULL, media_path = NA, tweet_db=NULL, ask=TRUE){
  
  if(any(is.null(tweet_text), is.null(category))){
    tweet_text <- readline(prompt = "What is the tweet text?")
    category <- readline(prompt = "Which category?")
  }
  
  if(!is.null(tweet_db)){
    if(!category %in% unique(tweet_db$category) & ask==TRUE){
      category_response <- askYesNo(msg = "This category doesn't exist yet. Are you sure you want to create a new one?")
      if(!category_response){return()}
    }   
  }
  
  this_tweet <- data.frame(tweet_text = tweet_text, 
                           category = category, 
                           media_path = media_path, 
                           id = digest::sha1(paste0(tweet_text, category, media_path)))
                          
  
  if(!is.null(tweet_db)){
    tweet_db <- rbind(tweet_db, 
                      this_tweet)  
  } else{
    tweet_db <- this_tweet
  }
  
  
  return(tweet_db)
}
