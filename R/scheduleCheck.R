#' @description Check if any of the parsed schedules match the current time. 
scheduleCheck <- function(schedule, minute_range){
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



filterSchedule <- function(schedule_item, now, minute_range=3){
  schedule_item <- as.list(schedule_item)
  results <- all(now$dow == schedule_item$dow, 
                 now$hour == schedule_item$hour,
                 abs(as.numeric(now$minute) - as.numeric(schedule_item$minute)) < minute_range)
  
  return(results) # Boolean
}
# now <- nowFormatted()
# filterSchedule(now = nowFormatted(), schedule_item = schedule[12,])
