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

getTermMatrix <- memoise(function(term, lang, cant, search_date1, search_date2) {
  text <- searchTwitter(paste(term, " -RT"), n=cant,lang=lang, resultType = "recent", since =  as.character(search_date1), until = as.character(search_date2))
  
  text <- twListToDF(text)
  text$text <- enc2native(text$text)
  text$text <- gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", "", text$text)
  text$text <- gsub(" ?(f|ht)(tp)(s?)(.*)", "", text$text)
  text$text <- gsub(" (.*)[.0-9](.*)", "", text$text)
  text$text <- tolower(text$text)
  text$text <- removeWords(text$text,c(stopwords(lang),"rt", "RT"))
  text$text <- removeWords(text$text,term)
  text$text <- removePunctuation(text$text, TRUE)
  myCorpus = Corpus(DataframeSource(text[1]))
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
 
  m = as.matrix(myDTM)
  sort(rowSums(m), decreasing = TRUE)
})