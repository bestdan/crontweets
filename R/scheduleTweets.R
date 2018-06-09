#' @name schedule
#' @docType data
#' @description An R object which holds a cron-like schedule of content you want to tweet.
#' @inheritParams tweet_db
#' @param minute
#' @param hour
#' @param dow The day of the week, 0 to 6, starting on Sunday, as per POSIXlt. Should probably add input validation.
#' @export
#' @examples 
#' schedule <- data.frame(minute   = 05, 
#'             hour     = 12, 
#'             dow      = 1, 
#'             category = "dpegan_blog_posts", 
#'             id       = NA))
#' 
#' schedule <- rbind(schedule, 
#'                   data.frame(minute   = 05, 
#'                              hour     = 12, 
#'                              dow      = 3, 
#'                              category = "dpegan_blog_posts", 
#'                              id       = NA))
#' 
#' schedule <- rbind(schedule, 
#'                   data.frame(minute   = 05, 
#'                              hour     = 12, 
#'                              dow      = 5, 
#'                              category = "dpegan_blog_posts", 
#'                              id       = NA))


schedule <- data.frame(minute=numeric(), 
                       hour=numeric(), 
                       dow=numeric(), 
                       category=character(), 
                       id=character())

schedule <- rbind(schedule, 
                  data.frame(minute   = 05, 
                             hour     = 12, 
                             dow      = 1, 
                             category = "dpegan_blog_posts", 
                             id       = NA))

schedule <- rbind(schedule, 
                  data.frame(minute   = 05, 
                             hour     = 12, 
                             dow      = 3, 
                             category = "dpegan_blog_posts", 
                             id       = NA))

schedule <- rbind(schedule, 
                  data.frame(minute   = 05, 
                             hour     = 12, 
                             dow      = 5, 
                             category = "dpegan_blog_posts", 
                             id       = NA))

schedule <- rbind(schedule, 
                  data.frame(minute   = 05, 
                             hour     = 08, 
                             dow      = 00, 
                             category = "befi_fails", 
                             id       = NA))

schedule <- rbind(schedule, 
                  data.frame(minute   = 05, 
                             hour     = 08, 
                             dow      = 02, 
                             category = "betterment_posts", 
                             id       = NA))

schedule <- rbind(schedule, 
                  data.frame(minute   = 05, 
                             hour     = 08, 
                             dow      = 04, 
                             category = "betterment_posts", 
                             id       = NA))

schedule <- rbind(schedule, 
                  data.frame(minute   = 05, 
                             hour     = 16, 
                             dow      = 06, 
                             category = "fintwit_quotes", 
                             id       = NA))

validateSchedule <- function(schedule){
  if(!all(schedule$dow %in% seq(0,6))){
    stop("All dow entries must be one of integers 0 to 6")
  }
  
  if(!all(schedule$hour %in% seq(0,23))){
    stop("All hour entries must be one of integers 0 to 23")
  }
  
  if(!all(schedule$minute %in% seq(0,59))){
    stop("All minute entries must be one of integers 0 to 23")
  }
}
# validateSchedule(schedule = schedule)


#' @description Replaces wildcards (NAs) with the current value.
replaceWildcard <- function(x, type){
  if(!is.na(x)) return(x)
  
  now <-  Sys.time()
  y <- switch(type, 
              minute = format(now,'%M'), 
              hour = format(now,'%H'),
              dow =  as.POSIXlt(now)$wday)
  return(y)
}
replaceWildcard <- Vectorize(replaceWildcard)
# replaceWildcard(NA, "hour")

#' @description Returns the current datetime in a list. 
nowFormatted <- function(){
  now_st <- Sys.time()
  now_formatted <- list(minute = format(now_st, "%M"), 
                        hour = format(now_st, "%H"), 
                        dow = as.POSIXlt(now_st)$wday)  
  return(now_formatted)
}
# nowFormatted()
