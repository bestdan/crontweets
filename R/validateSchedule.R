#' @name validateSchedule
#' @title validateSchedule
#' @description Validate that all entries in a schedule object are ok. 
#' @param schedule A \code{\link{schedule}} object.
#' @export
#' @examples 
#' data(schedule)
#' validateSchedule(schedule)
#' 
#' \dontrun{
#' schedule$minute[3] <- 123
#' validateSchedule(schedule)
#' }

validateSchedule <- function(schedule){
  
  valid_names <- c("minute", "hour", "dow", "tz", "category", "id")
  
  namecheck <- sort(names(schedule)) == sort(valid_names)
  
  if(any(!namecheck)){
    stop("schedule must have column names ", paste0(valid_names, collapse = ", "))
  }
  
  dow_failures <- which(!schedule$dow %in% seq(0,6) & !is.na(schedule$dow))
  if(length(dow_failures) > 0){
    stop(paste0("All dow entries must be one of integers 0 to 6. These rows fail: ", 
                paste(dow_failures, collapse = ",")))
  }
  
  hour_failures <- which(!schedule$hour %in% seq(0, 23) & !is.na(schedule$hour))
  if(length(hour_failures) > 0){
    stop(paste0("All hour entries must be one of integers 0 to 23, These rows fail: ", 
                paste(hour_failures, collapse = ",")))
  }
  
  minute_failures <- which(!schedule$minute %in% seq(0, 59) & !is.na(schedule$minute))
  if(length(minute_failures)  > 0){
    stop(paste0("All minute entries must be one of integers 0 to 23. These rows fail: ", 
                paste(minute_failures, collapse = ",")))
  }
  
  overlap_failures <- which(!is.na(schedule$category) & !is.na(schedule$id))
  if(length(overlap_failures)  > 0){
    stop(paste0("Each schedule item should have just one of category or id. These rows fail:  ", 
                paste(overlap_failures, collapse = ",")))
  }
  
  na_list <- apply(schedule, 1, function(x) all(is.na(x["minute"]), is.na(x["hour"]), is.na(x["dow"])))
  if(any(na_list)){
    na_fails <- schedule[which(na_list),]
    stop(paste0("Each schedule item cannot have NA's for all time fields. These rows fail:  ", 
                paste(na_fails, collapse = ",")))
    
  }
  
}



