context("validateSchedule")


data(schedule)

test_that("checkSchedule: Modifying now to fake positive works", {
  
  # Fake time
  now <- as.POSIXct(strptime("00:08 2018-06-11", format="%M:%H %Y-%m-%d"))
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)
  expect_equal(1, nrow(res))
  expect_equal(res$category, "animals")
  expect_equal(res$id, NA)
  expect_equal(res$minute, 0)
  expect_equal(res$hour, 8)
  expect_equal(res$dow, 1)
})


test_that("checkSchedule: Modifying now to fake positive works", {
  
  #  Change schedule
  now <- Sys.time()
  schedule$minute[1] <- as.numeric(format(now, format="%M"))
  schedule$hour[1]   <- as.numeric(format(now, format="%H"))
  schedule$dow[1]    <- as.numeric(as.POSIXlt(now)$wday)
  
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)
  expect_equal(1, nrow(res))
  expect_equal(res$category, "animals")
  expect_equal(res$id, NA)
  
})


test_that("checkSchedule: wildcard works", {
  
  #  Change schedule
  now <- as.POSIXct(strptime("00:07 2018-06-10", format="%M:%H %Y-%m-%d"))
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)
  
  expect_equal(1, nrow(res))
  expect_equal(res$category, "wakeup")
  expect_equal(res$id, NA)
  
})

test_that("checkSchedule: wildcard works", {
  
  #  Change schedule
  now <- as.POSIXct(strptime("05:12 2018-06-13", format="%M:%H %Y-%m-%d"))
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)
  
  expect_equal(2, nrow(res))
  expect_equal(res$category, c("animals","food"))
  
})