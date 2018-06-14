#' @name filterSchedule
#' @title filterSchedule
#' @description Pass a boolean about whether or not a schedule_item is to be posted.
#' @inheritParams validateSchedule
#' @inheritParams checkSchedule
#' @param schedule_item A single row of a \code{\link{schedule}}.
#' @param now A properlay formatted \code{now} object, as produced by \code{\link{nowFormatted}}. Represents the computers current timezone, not the scheudled items tz.
#' @export
#' @importFrom lubridate hour minute
#' @examples 
#' current_time <- as.POSIXlt("2018-06-13 11:00:55", tz = "GMT")
#' now <- crontwit:::nowFormatted(current_time)
#' data(schedule)
#' filterSchedule(schedule_item = schedule[7,], now = now)


filterSchedule <- function(schedule_item, now, minute_range=3){
  schedule_item <- as.list(schedule_item)
  

  # TODO Need to makes `now` respect the tz of each item. 
  
  if(now$dow  != as.numeric(schedule_item$dow)){
    return(FALSE)
    }
  # Need to find time different between timezones.
  # diff_time <- difftime(Sys.time(), now$time)
  # post_time    <- as.POSIXct(paste0(as.Date(now$time),as.numeric(schedule_item$hour) * 60) + as.numeric(schedule_item$minute)
  # current_time <- (as.numeric(hour(now$time))    * 60) + as.numeric(minute(now$time))
  
  post_time    <- as.POSIXct(paste0(as.Date(now$time), " ", 
                                    schedule_item$hour, ":",
                                    schedule_item$minute), tz = schedule_item$tz)
  
 
  time_diff <- abs(as.numeric(difftime(post_time, now$time, units = "mins")))
  
  return(time_diff < minute_range)
    
}
