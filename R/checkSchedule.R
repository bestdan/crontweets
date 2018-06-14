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

  # Wildcards are all parsed in terms of the *items*s time zone. 
  parsed_schedule <- parseSchedule(schedule, now)
    
  
  matched_schedules <- parsed_schedule[apply(parsed_schedule, 1,
                                             filterSchedule,
                                             now=now, 
                                             minute_range = minute_range),, drop=FALSE]
  return(matched_schedules)
}
# scheduleCheck(schedule, 3)

