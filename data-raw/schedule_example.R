#' Creating a schedule object
schedule <- data.frame(minute   = NA,
                       hour     = 08,
                       dow      = 1,
                       tz       = "EST",
                       category = "animals", 
                       id       = NA)

schedule <- rbind(schedule,
                  data.frame(minute   = 05,
                             hour     = NA,
                             dow      = 3,
                             tz       = "EST",
                             category = "animals", 
                             id       = NA))

schedule <- rbind(schedule,
                  data.frame(minute   = 05,
                             hour     = 12,
                             dow      = 03,
                             tz       = "EST",
                             category = "food", 
                             id       = NA))

schedule <- rbind(schedule,
                  data.frame(minute   = 00,
                             hour     = 07,
                             dow      = 1,
                             tz       = "EST",
                             category = "wakeup", 
                             id       = NA))
schedule <- rbind(schedule,
                  data.frame(minute   = 00,
                             hour     = 07,
                             dow      = NA,
                             tz       = "EST",
                             category = "wakeup", 
                             id       = NA))

schedule <- rbind(schedule,
                  data.frame(minute   = 00,
                             hour     = 07,
                             dow      = NA,
                             tz       = "GMT",
                             category = "wakeup", 
                             id       = NA))

schedule <- rbind(schedule,
                  data.frame(minute   = 00,
                             hour     = 11,
                             dow      = 3,
                             tz       = "GMT",
                             category = "wakeup", 
                             id       = NA))

validateSchedule(schedule)
usethis::use_data(schedule, overwrite = TRUE)



