#' @title run_crontwit.R
#' Ensure you have dependencies. 

if(!require(pacman)) install.packages("pacman", repos='http://cran.us.r-project.org')
pacman::p_load(twitteR, yaml)
library(crontwit)

# Load paths
creds_path <- "~/src/degan_creds.yaml"
schedule_path <- "~/src/schedule.rda"
tweet_db_path <- "~/src/tweet_db.rda"

twitter_creds <- yaml.load_file(creds_path)$twitter

# Tell it to auto-cache the credentials
getOption("httr_oauth_cache")
setup_twitter_oauth(consumer_key = twitter_creds$consumer_key, 
                    consumer_secret = twitter_creds$consumer_secret, 
                    access_token = twitter_creds$access_token, 
                    access_secret = twitter_creds$access_token_secret)

# Load schedule
load(schedule_path)
load(tweet_db_path)

# Check schedule and post if necessary. 
checkScheduleAndPost(schedule, tweet_db)