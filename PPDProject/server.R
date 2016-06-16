function(input, output, session) {
  terms <- reactive({
    input$update
    isolate({
      withProgress({
        setProgress(message = "Analyse en cours...")
        getTermMatrix(input$term, input$lang, input$cant, input$search_date[1], input$search_date[2])
      })
    })
  })
  wordcloud_rep <- repeatable(wordcloud)
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(8,0.5),
                  min.freq = input$freq, max.words=50,random.color = TRUE,random.order = TRUE,
                  rot.per = 0.3,
                  colors=brewer.pal(8, "Dark2"))
  })
  
  output$fiveWord <- renderPlot({
    
    v<-terms()
    barplot(v[1:5], 
            main=" ",
            ylab="Mot",
            xlab="Occurence")
  })
  
  output$avatar <- renderImage({
    user<-getTwitterUser(input$username) 
    addFollowersList(user$followersCount)
    addStatusesList(user$statusesCount)
    addUserList(user$screenName)
    return(list(
      src = user$profileImageUrl,
      SRC = user$profileImageUrl,
      alt = user$screenName
    ))
  })
  
  
  output$screenName <- renderText({
    user<-getTwitterUser(input$username) 
    return(paste(user$screenName))
  })
  
  output$created <- renderText({
    user<-getTwitterUser(input$username) 
    return(paste(user$created))
  })
  
  output$followersCount <- renderText({
    user<-getTwitterUser(input$username) 
    return(paste(user$followersCount))
  })
  
  output$statusesCount <- renderText({
    user<-getTwitterUser(input$username) 
    return(paste(user$statusesCount))
  })
  
  output$statusesCompare <- renderPlot({
    pie(getStatusesList(), labels = getUserList(), main="Comparaison par activite")
  })
  
  output$followersCompare <- renderPlot({
    pie(getFollowersList(), labels = getUserList(), main="Comparaison par activite")
  })
  
  output$download <- downloadHandler(
    filename = function() {paste(input$term,'csv', sep='.')},
    content = function(file){
      write.table(terms(),file)}
  )
}