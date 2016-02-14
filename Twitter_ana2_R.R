#Twitter analytics with R

library(devtools)
install_github("twitteR", "geoffjentry")

install.packages("ROAuth")
install.packages("twitteR")
install.packages(c("devtools", "rjson", "bit64", "httr"))

library(ROAuth)
library(twitteR)

api_key<-'rHalljP1nSsedFIGgQ2sjFzA9'
api_secret<-'wvWJlG5Bciq2ir70ebgUloGbAdIoE9fTae5jg4oxTqVTzsveGU'
access_token<-'145942066-e4np1rbvAXWIeFDTg73VG9bxPOozaqarJHoWvBE5'
access_token_secret<-'CnrIDoggOdqgNxwknySGO1y5uEWA51fBUyQ3VdYbVlYOJ'

setup_twitter_oauth(api_key, api_secret,access_token, access_token_secret)

searchTwitteR("Slash")

----------------------------------
  library(httr)

# 1. Find OAuth settings for twitter:
#    https://dev.twitter.com/docs/auth/oauth
oauth_endpoints("twitter")

# 2. Register an application at https://apps.twitter.com/
#    Make sure to set callback url to "http://127.0.0.1:1410"
#
#    Replace key and secret below
myapp <- oauth_app("twitter",
                   key = "rHalljP1nSsedFIGgQ2sjFzA9",
                   secret = "wvWJlG5Bciq2ir70ebgUloGbAdIoE9fTae5jg4oxTqVTzsveGU"
)

install.packages("base64enc")
install.packages("httpuv")
library("base64enc")

# 3. Get OAuth credentials
twitter_token <- oauth1.0_token(oauth_endpoints("twitter"), myapp)

# 4. Use API
req <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json",
           config(token = twitter_token))
stop_for_status(req)
content(req)
  
  
searchTwitter("iphone")
  