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
  
  output$download <- downloadHandler(
    filename = function() {paste(input$term,'csv', sep='.')},
    content = function(file){
      write.table(terms(),file)}
  )
  
  output$map <- renderPlot({
    tweetsDF <- getTweetsDF(input$country, 100)
    emory <- gmap(input$country, zoom = 5, scale = 2)
    for ( i in 1:nrow(tweetsDF)) { 
      if(!is.na(tweetsDF[i,15])){
        cat(tweetsDF[i,15])
        cat(tweetsDF[i,16])
        d <- data.frame(lat = c(tweetsDF[i,15]), lon = c(tweetsDF[i,16]))
        coordinates(d) <- ~ lon + lat
        projection(d) <- "+init=epsg:4326"
        mm <- "+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs"
        d_mrc <- spTransform(d, CRS = CRS(mm))
        d_mrc_bff <- gBuffer(d_mrc, width = 1000000)
        plot(d_mrc_bff, col = alpha("red", .35), add = TRUE)
      }
    }
    plot(emory)
    
  })
}