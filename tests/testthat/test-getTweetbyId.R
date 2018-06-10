context("getTweetByID")

data("tweet_db")

test_that("getTweetByID: successful pulls.", {
  res <- getTweetByID(id = "3aef9b07818ba871e5db6eebd5c5b77f46eea04d", tweet_db = tweet_db)
  expect_equal(res$id, "3aef9b07818ba871e5db6eebd5c5b77f46eea04d")
  expect_equal(nrow(res), 1)
  expect_equal(res$tweet_text, "I like dogs too.")

})


test_that("getTweetByID: error handling pulls.", {
  res <- getTweetByID(id = "3aef9b07818ba871e5db6eebd5c5b77f46eea04d", tweet_db = tweet_db)
  expect_equal(res$id, "3aef9b07818ba871e5db6eebd5c5b77f46eea04d")
  expect_equal(nrow(res), 1)
  expect_equal(res$tweet_text, "I like dogs too.")
  
})

