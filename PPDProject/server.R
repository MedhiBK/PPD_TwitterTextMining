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
  observeEvent(input$reset,{
    
    userList <<- c()
    followersList <<-c()
    statusesList <<-c()
    
    output$statusesCompare <- renderGvis({
      gvisPieChart(a, labelvar = "users", numvar = "statuses", options = list(title = "Comparaison par activité"), "statuses")
    })
    output$followersCompare <- renderGvis({
      gvisPieChart(b, labelvar = "users", numvar = "followers", options = list(title = "Comparaison par popularité"), "followers")
    })
    updateTextInput(session, "username",value = "")
  })
  
  output$fiveWord <- renderPlot({
    
    v<-terms()
    barplot(v[1:5], 
            main=" ",
            ylab="Mot",
            xlab="Occurence")
  })
  
  output$tweetList <- renderTable({
  text <- twListToDF(getAllData(input$term, input$lang, input$cant, input$search_date[1], input$search_date[2]))
  tri <- text[order(text[,3],decreasing = TRUE),]
  donne <- matrix(tri$text,nrow=5,ncol = 1)
  })
  
  output$avatar <- renderImage({
    user<-getTwitterUser(input$username)
    followersList <<- append(followersList,user$followersCount)
    statusesList <<- append(statusesList,user$statusesCount)
    userList <<- append(userList,user$screenName)
    a = data.frame(userList, statusesList)
    colnames(a) <- c("users", "statuses")
    b = data.frame(userList, followersList)
    colnames(b) <- c("users", "followers")
    output$statusesCompare <- renderGvis({
      gvisPieChart(a, labelvar = "users", numvar = "statuses", options = list(title = "Comparaison par activité"), "statuses")
    })
    output$followersCompare <- renderGvis({
      gvisPieChart(b, labelvar = "users", numvar = "followers", options = list(title = "Comparaison par popularité"), "followers")
    })
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
  
  
  output$download <- downloadHandler(
    filename = function() {paste(input$term,'csv', sep='.')},
    content = function(file){
      write.table(twListToDF(getAllData(input$term, input$lang, input$cant, input$search_date[1], input$search_date[2])),file)}
      
  )
}