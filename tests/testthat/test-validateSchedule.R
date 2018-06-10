context("validateSchedule")


data(schedule)

test_that("validateSchedule: all good passes", {
  expect_error(validateSchedule(schedule), NA)
  
})

test_that("validateSchedule: error in minute input caught", {
  schedule$minute[3] <- 123
  expect_error(validateSchedule(schedule), 
               regexp = "minute")
  
})



test_that("validateSchedule: error in hour input caught", {
  schedule$hour[3] <- -100
  expect_error(validateSchedule(schedule), 
               regexp = "hour")
  
})

test_that("validateSchedule: error in dow input caught", {
  schedule$dow[3] <- 22
  expect_error(validateSchedule(schedule), 
               regexp = "dow")
  
})
