#' @name checkSchedule
#' @title checkSchedule
#' @description Check if any of the parsed schedules match the current time. 
#' @inheritParams validateSchedule
#' @param minute_range The range in minutes to allow for a different, and still post. Defaults to 3.
#' @export
#' @examples 
#' now <- crontweets:::nowFormatted()
#' data(schedule)
#' scheduleCheck(schedule = schedule, minute_range=5)

checkSchedule <- function(schedule, minute_range){
  
  validateSchedule(schedule)
  
  now <- nowFormatted()
  
  parsed_schedule <- schedule
  parsed_schedule$minute <- replaceWildcard(schedule$minute)
  parsed_schedule$hour <- replaceWildcard(schedule$hour)
  parsed_schedule$dow <- replaceWildcard(schedule$dow)
  
  matched_schedules <- parsed_schedule[apply(parsed_schedule, 1,
                                             filterSchedule,
                                             now=now, 
                                             minute_range = minute_range),, drop=FALSE]
  return(matched_schedules)
}
# scheduleCheck(schedule, 3)


# Replaces wildcards (NAs) with the current value.
replaceWildcard <- Vectorize(function(x, type){
  if(!is.na(x)) return(x)
  
  now <-  Sys.time()
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
#' @description breaks apart time object to check for matches
#' @examples 
#' nowFormatted()

#' Returns the current datetime in a list. 
nowFormatted <- function(){
  now_st <- Sys.time()
  now_formatted <- list(minute = as.numeric(format(now_st, "%M")), 
                        hour   = as.numeric(format(now_st, "%H")), 
                        dow    = as.numeric(as.POSIXlt(now_st)$wday))  
  return(now_formatted)
}
# nowFormatted()
