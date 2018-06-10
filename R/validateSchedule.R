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
  
  dow_failures <- which(!schedule$dow %in% seq(0,6))
  
  if(length(dow_failures) > 0){
    stop(paste0("All dow entries must be one of integers 0 to 6. These rows fail: ", 
                paste(dow_failures, collapse = ",")))
  }
  
  hour_failures <- which(!schedule$hour %in% seq(0, 23))
  if(length(hour_failures) > 0){
    stop(paste0("All hour entries must be one of integers 0 to 23, These rows fail: ", 
                paste(hour_failures, collapse = ",")))
  }
  
  minute_failures <- which(!schedule$minute %in% seq(0, 59))
  if(length(minute_failures)  > 0){
    stop(paste0("All minute entries must be one of integers 0 to 23. These rows fail: ", 
                paste(minute_failures, collapse = ",")))
  }
  
  overlap_failures <- which(!is.na(schedule$category) & !is.na(schedule$id))
  if(length(overlap_failures)  > 0){
    stop(paste0("Each schedule item should have just one of category or id. These rows fail:  ", 
                paste(overlap_failures, collapse = ",")))
  }
  
  
}



