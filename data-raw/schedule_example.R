#' Creating a schedule object
schedule <- data.frame(minute   = 00,
                       hour     = 08,
                       dow      = 1,
                       category = "animals", 
                       id       = NA)

schedule <- rbind(schedule,
                  data.frame(minute   = 05,
                             hour     = 12,
                             dow      = 3,
                             category = "animals", 
                             id       = NA))

schedule <- rbind(schedule,
                  data.frame(minute   = 10,
                             hour     = 16,
                             dow      = 5,
                             category = "food", 
                             id       = NA))

validateSchedule(schedule)
usethis::use_data(schedule, overwrite = TRUE)


