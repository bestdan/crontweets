
context("filterSchedule")
data(schedule)

test_that("filterSchedule: Filter works with same tz", {
  current_time <- as.POSIXlt("2018-06-13 11:00:55", tz = "GMT")
  now <- crontwit:::nowFormatted(current_time)
  res <- filterSchedule(schedule_item = schedule[7,], now = now)
  expect_equal(res, TRUE)
})



test_that("filterSchedule works with different time zones", {
  
  current_time <- as.POSIXlt("2018-06-13 6:00:55", tz = "EST")  # Current time defined in EST
  now <- crontwit:::nowFormatted(current_time)
  expect_true(filterSchedule(schedule_item = schedule[7,], now = now)  )
})