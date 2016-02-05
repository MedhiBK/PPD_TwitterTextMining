library(shiny)
library(twitteR)
library(wordcloud)
library(tm)

consumerKey = "fIZMJKnLQ2RuGQQEEizjy2GzA"   
consumerSecret = "fEnlXSOzuMWUAcg9x9g2AAWjT3mxMQ4l4ZbeLnfcH7S4IEIV4L"
accessToken = "4835171254-cMJUm81pHUMRNZCYd0xX0q8ZHzPQqDeqBaoCkM4"
accessSecret = "NKhbXctNNEbdKGulVtb6hrydq3VXTriZw2kYMKgp7PJZL"
my_oauth <- setup_twitter_oauth(consumer_key = consumerKey, consumer_secret = consumerSecret,
                                access_token = accessToken, access_secret = accessSecret)
1



shinyServer(function(input,output){
  
  rawData <- (function(){
    tweets <- searchTwitter(input$term, n=input$cant,lang=input$lang)
    twListToDF(tweets)
  })
  
  output$table <- renderTable(function(){
    head(rawData()[1],n=input$cant)
  })
  
  output$wordcl <- renderPlot(function(){
    tw.text <- enc2native(rawData()$text)
    tw.text <- tolower(tw.text)
    tw.text <- removeWords(tw.text,c(stopwords(input$lang),"rt"))
    tw.text <- removePunctuation(tw.text, TRUE)
    tw.text <- unlist(strsplit(tw.text,""))
    
    word <- sort(table(tw.text),TRUE)
    wordc <- head(word,n=15)
    
    
    
    wordcloud(names(wordc),wordc,random.color = TRUE,colors = rainbow(10),scale = c(15,2))
  })
  
  output$download <- downloadHandler(filename = function() {paste(input$term, '.csv', sep='')},
                                     content = function(file){
                                       write.csv(rawData(), file)
                                     }
  )
  
  
})