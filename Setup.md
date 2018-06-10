
## Overview
What `crontwit` does is very simple:  
* Creates and validates a `tweet_db` database of tweets. 
* Creates and validates a `schedule` you want to post on. 
* Checks if the current time matches a schedule item, and posts any matching tweets.


In this guide, I'll go through: 
- Getting and storing your twitter credentials
- Making, using and storing your `schedule` and `tweet_db` files
- Setting up crontabs and shell scripts
- Updating your library
- An AWS EC2 specific guide
- Troubleshooting
- Background: why you might want to use this. 



## Step 1: Getting and storing your twitter API credentials: 
### Getting your API keys
In order to post tweets via the Twitter API, you'll need to setup your Twitter account to allow an API connections, and get your API credentials. You can read how to do that [here](https://medium.com/@GalarnykMichael/accessing-data-from-twitter-api-using-r-part1-b387a1c7d3e). 

### Storing your credentials

:closed_lock_with_key: **Critical Security note** :closed_lock_with_key: : You should never store or transmit your credentials in public using plain-text that someone else can see. For example, don't store them in a public github repo :no_good: . 

I recommend saving your credentials into a `twitter_credentials.yaml` file as below. If you're not familiar with yaml, just know that the indentation is key. The example below holds credentials for two twitter accounts and one github account. I'll use examples that load these credentials to authenticate.  

```yaml
twitter:
  account: daniel_egan
    username: "dpegan_tweets"
    consumer_key: "##################"
    consumer_secret: "##################"
    access_token: "##################"
  account: some_other_account
    username: "someone_else_tweets"
    consumer_key: "##################"
    consumer_secret: "##################"
    access_token: "##################"

github:
  username: "bestdan"
  token: "###################"
```

However you decide to deploy your crontwit schedule, you'll need to have the local path to these credentials. For example, I store mine in `~/src/twitter_credentials.yaml` on my local computer, and `~/creds/twitter_credentials.yaml` on my EC2 instance. 

## Step 2: Making, using and storing your `schedule` and `tweet_db` 

### Making a `tweet_db` library of content
Your content is stored in an object called `tweet_db`. You can build out this library and save it down locally like this:

```r
tweet_db <- addNewTweetToDB("I like cats"            , category="animals")
tweet_db <- addNewTweetToDB("I like dogs too."       , category="animals", tweet_db = tweet_db)
tweet_db <- addNewTweetToDB("I don't like sardines." , category="food"   , tweet_db = tweet_db)
save(tweet_db, file =file.path("~","Desktop", "tweet_db.rda"))
```

We'll then use that `tweet_db.rda` file as the source of our tweets.


### Making a crontab-like `schedule` in R
The `schedule` object holds a cron-like set of data for knowing when to post what. Here's an example:

```r
>   minute hour dow category id
> 1      0    8   1  animals NA
> 2      5   12   3  animals NA
> 3      5   12   3     food NA
> 4      0    7  NA   wakeup NA
```

Much like a contab there is an entry for minute, hour, and day-of-week (dow). There are additional fields category and id for pulling specific tweets or picking at random from a category.


## Step 3: Setting up crontabs and shell scripts

### Setting up crontab
The way I went about running the schedule was using crontab, which is a local utility that comes with linux and mac computers. Effectively, you tell the computer to run a file on a schedule. To open crontab, in a terminal go:

```bash
sudo nano crontab -e
```

It should open up an empty file. You can add entries to follow any schedule you want. If you want one which runs the bash fie `run_crontwit.sh` every 5 minutes, it looks like this:

```crontab
*/5 * * * * sudo sh ~/src/myscellany/degan_tweets/run_crontwit.sh
```


I'm going to use bash [shell scripts](https://fileinfo.com/extension/sh) in my crontab. They tell the computer what to do. For example, `run_crontwit.sh` is:
 
 ```bash
 #!/bin/bash                                                             # Hi! I'm a bash file. 
{
    sudo Rscript src/myscellany/degan_tweets/run_contwit.R    # As a super-user, please use R to run this file.
} >> src/myscellany/degan_tweets/log/bash_log.txt                        # Send any output to this text file (for troubleshooting.)
```

> crontab --> bash --> R --> twitter

`run_crontwit.R` is an R Script file which ensures that R has all the material/packages it needs, and then runs my schedul


```r
#' Ensure you have dependencies. 
if(!require(pacman)) install.packages("pacman", repos='http://cran.us.r-project.org')
pacman::p_load(twitteR, yaml)
library(crontwit)

# Load paths
creds_path <- "~/src/degan_creds.yaml"
schedule_path <- "~/src/schedule.rda"
tweet_db_path <- "~/src/tweet_db.rda"

twitter_creds <- yaml.load_file()$twitter

# Tell it to auto-cache the credentials
getOption("httr_oauth_cache")
setup_twitter_oauth(consumer_key = twitter_creds$consumer_key, 
                    consumer_secret = twitter_creds$consumer_secret, 
                    access_token = twitter_creds$access_token, 
                    access_secret = twitter_creds$access_token_secret)

# load schedule
load(schedule_path)
load(tweet_db_path)

checkScheduleAndPost(schedule, tweet_db)

```

## Step 4: Updating your library
How do you get new content into your tweet_db, or change your schedule? I'd suggest a nightly run via crontab pulling through a web-based service like github, dropbox, or S3. 

### crontab + github
This solution uses crontab to run a daily sync via g

## Tangent: An AWS EC2 guide

[Here](ec2_setup.md)

## Step 5: Troubleshooting

```bash
#!/bin/bash
{
    sudo Rscript src/myscellany/degan_tweets/postRandomTweet_script.R
} >> src/myscellany/degan_tweets/log/bash_log.txt
```


### Time zones
One nasty potential problem (I've never experienced it) is if the machine (EC2 etc) you deploy your `schedule` on is in a different time zone. 
I should probably make some kind of time-zone argument to the `schedule`. Pull requests are welcome! 


## Background
I generally try to write ever-green/non-ephemeral [articles](http://www.dpegan.com/optimal_behavior/). I then periodically share random pieces of content on twitter, which helps people keep discovering relevant ideas. I appreciate it when other people do this, so I thought I would do it myself.
 
I used to pay ~$500 a year for [MeetEdgar](www.meetedgar.com). It maintained a categorical library of social media content, and posts random things at pre-apppointed times from different categories. 

This is just a DIY version of that service. It still costs ~$5 a month for AWS given how I've done it though. 