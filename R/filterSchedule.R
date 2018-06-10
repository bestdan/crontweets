#' @name filterSchedule
#' @title filterSchedule
#' @description Pass a boolean about whether or not a schedule_item is to be posted.
#' @inheritParams validateSchedule
#' @inheritParams checkSchedule
#' @param schedule_item A single row of a \code{\link{schedule}}.
#' @param now A properlay formatted \code{now} object, as produced by \code{\link{nowFormatted}}.
#' @export
#' @examples 
#' now <- crontweets:::nowFormatted()
#' data(schedule)
#' filterSchedule(schedule_item = schedule[1,], now = now)

filterSchedule <- function(schedule_item, now, minute_range=3){
  schedule_item <- as.list(schedule_item)
  
  results <- all(now$dow  == as.numeric(schedule_item$dow), 
                 now$hour == as.numeric(schedule_item$hour),
                 abs(as.numeric(now$minute) - as.numeric(schedule_item$minute)) < minute_range)
  
  return(results) # Boolean
}
