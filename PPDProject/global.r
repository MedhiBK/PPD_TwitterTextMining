library(memoise)
library(twitteR)
library(wordcloud)
library(tm)
library(shiny)
library(shinyBS)

consumerKey = "fIZMJKnLQ2RuGQQEEizjy2GzA"   
consumerSecret = "fEnlXSOzuMWUAcg9x9g2AAWjT3mxMQ4l4ZbeLnfcH7S4IEIV4L"
accessToken = "4835171254-cMJUm81pHUMRNZCYd0xX0q8ZHzPQqDeqBaoCkM4"
accessSecret = "NKhbXctNNEbdKGulVtb6hrydq3VXTriZw2kYMKgp7PJZL"
my_oauth <- setup_twitter_oauth(consumer_key = consumerKey, consumer_secret = consumerSecret,
                                access_token = accessToken, access_secret = accessSecret)

getTermMatrix <- memoise(function(term) {
  text <- searchTwitter(paste(term, " -RT"), n=10)
  
  twListToDF(text)
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})