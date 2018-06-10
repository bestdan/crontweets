context("loadTweetDB")


test_that("loadTweetDB: In-memory works", {
  data("tweet_db")
  res <- crontwit:::loadTweetDB(tweet_db[1,, drop=FALSE])
  expect_equal(res$id, "e70fd8558e1ca0ec28c315fe42166ca2deef868d")
  expect_equal(nrow(res), 1)
  
  
})

test_that("loadTweetDB: In-memory works", {
  fpath <- system.file("exdata", "tweet_db.rda", package="crontwit")
  
  res <- crontwit:::loadTweetDB(fpath)[1,, drop=FALSE]
  expect_equal(res$id, "e70fd8558e1ca0ec28c315fe42166ca2deef868d")
  expect_equal(nrow(res), 1)

})
