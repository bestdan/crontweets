
require(crontwit)
require(testthat)
context("checkSchedule")
data(schedule)

test_that("checkSchedule: Modifying 'now' to generate positive matches works.", {
  
  # Fake time to match an entry
  now <- as.POSIXct(strptime("00:08 2018-06-11", format="%M:%H %Y-%m-%d"), tz =  "America/New_York")
  expect_error(res <- checkSchedule(schedule = schedule, minute_range=5, now=now), 
               regexp = NA)
  
  expect_equal(1, nrow(res))
  expect_equal(res$category, "animals")
  expect_equal(res$id, NA)
  expect_equal(res$minute, 0)
  expect_equal(res$hour, 8)
  expect_equal(res$dow, 1)
})


test_that("checkSchedule: Modifying the schedule to generate positive matches works.", {
  
  # Get the current time on the system, change the schedule to match
  now <- lubridate::now("UTC")
  tzvals <- attributes(as.POSIXlt(now))$tzone
  this_tz <- tzvals[which.max(nchar(tzvals))]
  
  schedule$minute[1] <- as.numeric(format(now, format="%M"))
  schedule$hour[1]   <- as.numeric(format(now, format="%H"))
  schedule$dow[1]    <- as.numeric(as.POSIXlt(now)$wday)
  schedule$tz[1]     <- this_tz
  
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)
  
  expect_equal(1, nrow(res))
  expect_equal(res$tz, "UTC")
  expect_equal(res$category, "animals")
  expect_equal(res$id, NA)
  
})


test_that("checkSchedule: wildcard works on dow", {
  
  #  Change schedule
  now <- as.POSIXct(strptime("00:07 2018-06-11", format="%M:%H %Y-%m-%d"), tz = "America/New_York")
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)
  
  expect_equal(2, nrow(res))
  expect_equal(res$category, c("wakeup", "wakeup"))
  expect_equal(res$dow, c(1,1))
  expect_equal(res$hour, c(7,7))
})

test_that("checkSchedule: wildcard works on hour", {
  
  #  Change schedule
  now <- as.POSIXct(strptime("2018-06-13 00:05", format="%Y-%m-%d %H:%M"), tz = "America/New_York")
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)
  
  expect_equal(1, nrow(res))
  expect_equal(res$category, "animals")
  expect_equal(res$dow, 3)
  expect_equal(res$hour, 0)
})

test_that("checkSchedule: multiple items returned", {
  
  #  Change schedule
  now <- as.POSIXct(strptime("2018-06-13 12:05", format="%Y-%m-%d %H:%M"), tz = "America/New_York" )
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)
  
  expect_equal(2, nrow(res))
  expect_equal(res$category, c("animals","food"))
  
})

test_that("checkSchedule: time zones are respected", {
  now <- as.POSIXct(strptime("00:07 2018-06-13", format="%M:%H %Y-%m-%d"), tz = "GMT")
  res <- checkSchedule(schedule = schedule, minute_range=5, now=now)  
  expect_equal(nrow(res), 1)
  expect_equal(res$category, "wakeup")
  expect_equal(res$tz, "GMT")
})
