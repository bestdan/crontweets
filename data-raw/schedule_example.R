#' Creating a schedule object
schedule <- data.frame(minute   = 00,
                       hour     = 08,
                       dow      = 1,
                       tz       = "America/New_York",
                       category = "animals", 
                       id       = NA)

schedule <- rbind(schedule,
                  data.frame(minute   = 05,
                             hour     = 12,
                             dow      = 3,
                             tz       = "America/New_York",
                             category = "animals", 
                             id       = NA))

schedule <- rbind(schedule,
                  data.frame(minute   = 05,
                             hour     = 12,
                             dow      = 03,
                             tz       = "America/New_York",
                             category = "food", 
                             id       = NA))

schedule <- rbind(schedule,
                  data.frame(minute   = 00,
                             hour     = 07,
                             dow      = NA,
                             tz       = "America/New_York",
                             category = "wakeup", 
                             id       = NA))

validateSchedule(schedule)
usethis::use_data(schedule, overwrite = TRUE)



