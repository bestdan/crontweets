#' @name schedule
#' @title schedule
#' @docType data
#' @description An R object which holds a cron-like schedule of content you want to tweet. NAs are wildcards.
#' @inheritParams tweet_db
#' @param minute The minute to be posted, or NA for wildcard.
#' @param hour The hour to be posted, or NA for wildcard.
#' @param dow The day of the week, 0 to 6, starting on Sunday, as per POSIXlt. Should probably add input validation.
#' @param tz The timezone in which the schedule should be run.
#' @examples 
#' data(schedule)
#' schedule
NULL
