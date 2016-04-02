library(shiny)
library(twitteR)
library(wordcloud)
library(tm)
library(shinyBS)

consumerKey = "fIZMJKnLQ2RuGQQEEizjy2GzA"   
consumerSecret = "fEnlXSOzuMWUAcg9x9g2AAWjT3mxMQ4l4ZbeLnfcH7S4IEIV4L"
accessToken = "4835171254-cMJUm81pHUMRNZCYd0xX0q8ZHzPQqDeqBaoCkM4"
accessSecret = "NKhbXctNNEbdKGulVtb6hrydq3VXTriZw2kYMKgp7PJZL"
my_oauth <- setup_twitter_oauth(consumer_key = consumerKey, consumer_secret = consumerSecret,
                                access_token = accessToken, access_secret = accessSecret)

shinyServer(function(input,output){
  
  
  rawData <- (function(){
    tweets <- searchTwitter(input$term, n=input$cant,lang=input$lang)
    twListToDF(tweets)
  })
  
  output$table <- renderTable(function(){
    head(rawData()[1],n=input$cant)
  })
  
  output$tableau <- renderTable(function(){
    
    tw.text <- enc2native(rawData()$text)
    tw.text <- gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", "", tw.text)
    tw.text <- gsub(" ?(f|ht)(tp)(s?)(.*)", "", tw.text)
    tw.text <- gsub(" (.*)[.0-9](.*)", "", tw.text)
    tw.text <- tolower(tw.text)
    tw.text <- removeWords(tw.text,c(stopwords(input$lang),"rt"))
    tw.text <- removePunctuation(tw.text, TRUE)
    tw.text <- unlist(strsplit(tw.text," "))
    word <- sort(table(tw.text),TRUE)
    wordc <- head(word,n=6)

    vecteur1 <- names(wordc)
    vecteur2 <- word
    vecteur3 = c(vecteur1,vecteur2)
    matrice = matrix(data = vecteur3,nrow=2,ncol=6,byrow=TRUE,dimnames = list(c("Mot","Fréquence")))
    print(matrice)
    matrice = matrice[,-1]
    
  })
  
  output$wordcl <- renderPlot(function(){
    
    tw.text <- enc2native(rawData()$text)
    tw.text <- gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", "", tw.text)
    tw.text <- gsub(" ?(f|ht)(tp)(s?)(.*)", "", tw.text)
    tw.text <- gsub(" (.*)[.0-9](.*)", "", tw.text)
    tw.text <- tolower(tw.text)
    tw.text <- removeWords(tw.text,c(stopwords(input$lang),"rt"))
    tw.text <- removePunctuation(tw.text, TRUE)
    tw.text <- unlist(strsplit(tw.text," "))
    word <- sort(table(tw.text),TRUE)
    wordc <- head(word,n=100)
    wordcloud_rep <- repeatable(wordcloud)
    wordcloud_rep(names(wordc), wordc, scale=c(7,1),
                  min.freq = input$freq, max.words=500,random.order=FALSE, ordered.colors = FALSE,
                  colors=rainbow(500), use.r.layout=FALSE, rot.per=.3)
    
    })
  
  output$download <- downloadHandler(filename = function() {paste(input$term, '.csv', sep='')},
                                     content = function(file){
                                       write.csv(rawData(), file)
                                     }
  )
  
  
})