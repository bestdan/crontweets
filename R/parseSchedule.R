#' @name parseSchedule
#' @title parseSchedule
#' @description Parse the items of a schedule, replacing wildcards and dealing with timezones. 
#' @inheritParams validateSchedule
#' @inheritParams nowFormatted
#' @export
#' @examples 
#' now <- crontwit:::nowFormatted()
#' data(schedule)
#' parseSchedule(schedule = schedule, now)

parseSchedule <- function(schedule, now){
  parsed_schedule <- schedule
  parsed_schedule$minute <- replaceWildcardV(schedule$minute, type = "minute", tz=schedule$tz, now_raw=now)
  parsed_schedule$hour   <- replaceWildcardV(schedule$hour,   type = "hour",   tz=schedule$tz, now_raw=now)
  parsed_schedule$dow    <- replaceWildcardV(schedule$dow,    type = "dow",    tz=schedule$tz, now_raw=now)
  
  return(parsed_schedule)
}


# Replaces wildcards (NAs) with the current value in the declared timezone
# NOTE: time zone is time zone to be posted in! 
replaceWildcard <- function(x, type, tz, now_raw=NULL){
  
  if(!is.na(x)) return(x)
  
  now_raw_class <- class(now_raw)
  if(length(now_raw_class) > 1){
    if(any(now_raw_class %in% c("POSIXt", "POSIXct", "POSIXlt"))){
      now_raw_class <- "POSIXt"
    }
  }
  
  now <- switch(now_raw_class, 
                "NULL" = Sys.time(), 
                "list" = now_raw$time,
                "POSIXt" = now_raw)

  now_shifted <- shiftTZ(now, tz)
  
  y <- switch(type, 
              minute = as.numeric(format(now_shifted,'%M')), 
              hour   = as.numeric(format(now_shifted,'%H')),
              dow    =  as.numeric(as.POSIXlt(now_shifted)$wday))
  return(y)
}
replaceWildcardV <- Vectorize(replaceWildcard, vectorize.args = c("x", "tz"))
# crontwit:::replaceWildcard(NA, "hour", tz="GMT", now= as.POSIXct("2018-06-11 07:00:00 EDT"))

#' @importFrom lubridate with_tz
shiftTZ <- function(x, target_tz){
  y <- lubridate::with_tz(x, target_tz)
  return(y)
}
# crontwit:::shiftTZ(Sys.time(), "GMT")
