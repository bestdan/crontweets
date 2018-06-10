
context("addNewTweetToDB")

test_that("addNewTweetToDB: Single entry without existing tweet_db", {
  
  r1 <- addNewTweetToDB("TestTweet", category="test")  
  expect_identical(r1$media_path, NA)
  expect_equal(nrow(r1), 1)
})

r1 <- addNewTweetToDB("TestTweet", category="test")  

test_that("addNewTweetToDB: Two unique identifiers are created", {

  r2 <- addNewTweetToDB("TestTweet2", category="test")
  expect_true(r1$id != r2$id)
})


test_that("addNewTweetToDB: Adding to pre-existing tweet_db increases rows", {
  
  twdb <- addNewTweetToDB("TestTweet2", category="test", tweet_db = r1)
  expect_equal(nrow(twdb), 2)
})




