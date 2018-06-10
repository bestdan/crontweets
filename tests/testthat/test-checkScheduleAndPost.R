context("checkScheduleAndPost")

data(schedule)
data("tweet_db")

test_that("checkScheduleAndPost: no schedule messages returns as such.", {
  expect_message(checkScheduleAndPost(schedule = schedule, tweet_db = tweet_db), 
                 regexp = "No scheduled content.")

})


test_that("checkScheduleAndPost: Finds valid post, pushes it.", {
  #' So I'm not really sure how to do this, without spamming twitter. 
  #' Perhaps vcr would be helpful.   https://github.com/ropensci/vcr

  #  Change schedule
  now <- Sys.time()
  schedule$minute[1] <- as.numeric(format(now, format="%M"))
  schedule$hour[1]   <- as.numeric(format(now, format="%H"))
  schedule$dow[1]    <- as.numeric(as.POSIXlt(now)$wday)
  
  expect_error(
    checkScheduleAndPost(schedule = schedule, tweet_db, minute_range=5, now=now),
    regexp = "updateStatus requires OAuth authentication")
  
})
