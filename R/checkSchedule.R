#' @name checkSchedule
#' @title checkSchedule
#' @description Check if any of the parsed schedules match the current time. 
#' @inheritParams validateSchedule
#' @param minute_range The range in minutes to allow for a different, and still post. Defaults to 3.
#' @export
#' @examples 
#' now <- crontweets:::nowFormatted()
#' data(schedule)
#' checkSchedule(schedule = schedule, minute_range=5)

checkSchedule <- function(schedule, minute_range, now = NULL){
  
  validateSchedule(schedule)
  
  now <- nowFormatted(now)
  
  parsed_schedule <- schedule
  parsed_schedule$minute <- replaceWildcard(schedule$minute, type = "minute")
  parsed_schedule$hour <- replaceWildcard(schedule$hour, type = "hour")
  parsed_schedule$dow <- replaceWildcard(schedule$dow, type = "dow")
  
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
#' @description Returns the current datetime in a list. 
#' @examples 
#' crontweets:::nowFormatted()

nowFormatted <- function(now_st=NULL){
  if(is.null(now_st)){
    now_st <- Sys.time() 
  } 

  now_formatted <- list(minute = as.numeric(format(now_st, "%M")), 
                        hour   = as.numeric(format(now_st, "%H")), 
                        dow    = as.numeric(as.POSIXlt(now_st)$wday))  
  return(now_formatted)
}
# nowFormatted()
