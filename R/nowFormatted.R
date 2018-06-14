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
                        dow    = as.numeric(as.POSIXlt(now)$wday), 
                        time   = now)  
  return(now_formatted)
}
# nowFormatted()

