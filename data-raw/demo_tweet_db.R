#' Generating demo tweet_db.
tweet_db <- addNewTweetToDB("I like cats"     , category="animals")
tweet_db <- addNewTweetToDB("I like dogs too.", category="animals", tweet_db = tweet_db)
tweet_db <- addNewTweetToDB("I don't like sardines.", category="food", tweet_db = tweet_db, ask=FALSE)
