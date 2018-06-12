#' @name checkSchedule
#' @title checkSchedule
#' @description Check if any of the parsed schedules match the current time. 
#' @inheritParams validateSchedule
#' @inheritParams nowFormatted
#' @param minute_range The range in minutes to allow for a different, and still post. Defaults to 3.
#' @export
#' @examples 
#' now <- crontwit:::nowFormatted()
#' data(schedule)
#' checkSchedule(schedule = schedule, minute_range=5)

checkSchedule <- function(schedule, minute_range, now = NULL){
  
  validateSchedule(schedule)
  
  now <- nowFormatted(now)
  
  parsed_schedule <- schedule
  parsed_schedule$minute <- replaceWildcard(schedule$minute, type = "minute", tz=schedule$tz)
  parsed_schedule$hour <- replaceWildcard(schedule$hour, type = "hour", tz=schedule$tz)
  parsed_schedule$dow <- replaceWildcard(schedule$dow, type = "dow", tz=schedule$tz)
  
  matched_schedules <- parsed_schedule[apply(parsed_schedule, 1,
                                             filterSchedule,
                                             now=now, 
                                             minute_range = minute_range),, drop=FALSE]
  return(matched_schedules)
}
# scheduleCheck(schedule, 3)


# Replaces wildcards (NAs) with the current value.
# NOTE: time zone is time zone to be posted in! 
replaceWildcard <- Vectorize(function(x, type, tz){
  if(!is.na(x)) return(x)
  
  now <- as.POSIXct(Sys.time())
  attributes(now)$tzone <- tz
  
  y <- switch(type, 
              minute = as.numeric(format(now,'%M')), 
              hour = as.numeric(format(now,'%H')),
              dow =  as.numeric(as.POSIXlt(now)$wday))
  return(y)
})
# replaceWildcard <- Vectorize(replaceWildcard)
# replaceWildcard(NA, "hour")

#' @name nowFormatted
#' @title nowFormatted
#' @description Returns the current datetime in a list. 
#' @param now Optional. A prespecified time-date object if you want to supply one.
#' @examples 
#' crontwit:::nowFormatted()

nowFormatted <- function(now=NULL){
  if(is.null(now)){
    now <- Sys.time() 
  } else {
    if(!any(class(now) %in% c( "POSIXct", "POSIXt"))) stop(paste0("now, if supplied, must be of class POSIXct or POSIXt. Supplied: ", class(now), ": ", now))
  }

  now_formatted <- list(minute = as.numeric(format(now, "%M")), 
                        hour   = as.numeric(format(now, "%H")), 
                        dow    = as.numeric(as.POSIXlt(now)$wday))  
  return(now_formatted)
}
# nowFormatted()
