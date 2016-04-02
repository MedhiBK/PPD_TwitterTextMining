library(twitteR)
api_key <- "fIZMJKnLQ2RuGQQEEizjy2GzA" # From dev.twitter.com
api_secret <- "fEnlXSOzuMWUAcg9x9g2AAWjT3mxMQ4l4ZbeLnfcH7S4IEIV4L" # From dev.twitter.com
token <- "4835171254-cMJUm81pHUMRNZCYd0xX0q8ZHzPQqDeqBaoCkM4" # From dev.twitter.com
token_secret <- "NKhbXctNNEbdKGulVtb6hrydq3VXTriZw2kYMKgp7PJZL" # From dev.twitter.com
setup_twitter_oauth(api_key, api_secret, token, token_secret)
tweets <- searchTwitter("Dassault", n=100, lang="en", since="2016-01-20")
tweets.df <- twListToDF(tweets)